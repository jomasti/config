{-# OPTIONS_GHC -W -fwarn-unused-imports -fno-warn-missing-signatures #-}

import System.IO

import Data.List (isPrefixOf, nub)

import Graphics.X11.ExtraTypes.XF86

import XMonad hiding (keys)

import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.OnScreen
import XMonad.Actions.SpawnOn
import XMonad.Actions.SwapWorkspaces

import XMonad.Hooks.DynamicLog hiding (dzen)
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook

import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.StackTile

import XMonad.Prompt
import XMonad.Prompt.Eval
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell

import qualified XMonad.StackSet as W

import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.WorkspaceCompare

-- Infix (,) to clean up key and mouse bindings
infixr 0 ~>
(~>) :: a -> b -> (a, b)
(~>) = (,)

stripIM s = if ("IM " `isPrefixOf` s) then drop (length "IM ") s else s

main = do
  --xmproc <- spawnPipe "/usr/bin/xmobar /home/josh/.xmonad/xmobarrc"
  dzen <- spawnPipe myStatusBar
  other <- spawnPipe left
  other <- spawnPipe right
  xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
    { manageHook          = manageHooks
    , layoutHook          = layouts
    , logHook             = myLogHook >> (dynamicLogWithPP $ myDzenPP dzen)
    , terminal            = "urxvtc"
    , modMask             = mod4Mask
    , borderWidth         = 1
    , focusFollowsMouse   = True
    , workspaces          = workspaceNames
    , startupHook         = setWMName "LG3D"
    } `additionalKeysP` keys

myIconDir = "/home/josh/.dzen/dzenIcons/"
myStatusBar = "dzen2 -x '0' -y '0' -h '20' -w '640' -ta 'l' -bg '" ++ myDBGColor ++ "' -fn '" ++ myFont ++ "'"
left = ".dzen/left.zsh | dzen2 -xs 1 -x '640' -y '0' -h '20' -w '640' -ta 'r' -bg '" ++ myDBGColor ++ "' -fg '" ++ myDFGColor ++ "' -fn '" ++ myFont ++ "'"
right = ".dzen/right.zsh | dzen2 -xs 2 -y '0' -h '20' -ta 'r' -bg '" ++ myDBGColor ++ "' -fg '" ++ myDFGColor ++ "' -fn '" ++ myFont ++ "'"
myFont = "xft:Anka/Coder:pixelsize=10"

myRestart :: String
myRestart = "for pid in `pgrep dzen2`; do kill -9 $pid; done && xmonad --recompile && xmonad --restart"

keys =
    [ "M-<Tab>"   ~> namedScratchpadAction pads "scratch"
    , "M-r"       ~> runOrRaisePrompt promptConfig
    , "M-s"       ~> shellPrompt promptConfig
    , "M-S-z"     ~> spawn "xscreensaver-command -lock"
    , "C-<Print>" ~> spawn "sleep 0.2; scrot -s"
    , "<Print>"   ~> spawn "scrot"
    , "M-f"       ~> goToSelected myGSConfig
    , "M-q"       ~> spawn myRestart
    , "M-x"       ~> nextWS
    , "M-z"       ~> prevWS
    , "M-M1-x"    ~> swapTo Next
    , "M-M1-z"    ~> swapTo Prev
    , "<XF86AudioRaiseVolume>"  ~> spawn "sound.sh up"
    , "<XF86AudioLowerVolume>"  ~> spawn "sound.sh down"
    , "<XF86Sleep>" ~> spawn "ktsuss pm-suspend"
    ]

pads =
    [ NS "scratch" "urxvtc -name scratch" (resource =? "scratch") scratchHook
    ]
    where
      scratchHook   = doRectFloat $ rr 0.51 0.52 0.46 0.44
      rr = W.RationalRect -- in fractions of screen: x y w h

layouts = smartBorders $ avoidStruts $ onWorkspace "5:im" imLayout $ lessBorders (Combine Difference Screen OnlyFloat) (standardLayouts)
          where standardLayouts = tiled ||| Mirror tiled ||| fullscreenLayout
                imLayout = withIM (2/10) (Role "buddy_list") (standardLayouts)
                fullscreenLayout = smartBorders Full
                tiled = ResizableTall nmaster delta ratio []
                nmaster = 1
                delta = 0.03
                ratio = 0.5

workspaceNames = ["1:web","2:term","3:media","4:file","5:im","6:games","7:misc"]

additionalManageHooks = composeOne $
      [transience]
      ++
      [ className =? c                            -?> doIgnore | c <- ignoreC ]
      ++
      [ className =? "Firefox" <&&> resource =? r -?> doCenterFloat | r <- floatFF ]
      ++
      [ className =? c                            -?> doCenterFloat | c <- centerFloatC ]
      ++
      [ name =? n                                 -?> doCenterFloat | n <- centerFloatCN ]
      ++
      [ className =? c                            -?> doShift "1:web" | c <- webApps ]
      ++
      [ className =? "URxvt" -?> doShift "2:term"
      , className =? "Thunar" -?> doShift "4:file"
      , className =? "feh"      -?> doF W.shiftMaster <+> doFloat
      , className =? "Pidgin" -?> doShift "5:im"
      ]
      where
        name = stringProperty "WM_NAME"
        floatFF = [ "DTA", "Manager", "Download", "Dialog", "Browser", "Toplevel" ]
        ignoreC = [ "trayer" ]
        centerFloatC = [ "File-roller", "Xmessage", "Ktsuss" ]
        centerFloatCN = [ "File Operation Progress", "Install user style", "MusicBrainz lookup" ]
        webApps = [ "Firefox", "luakit", "jumanji", "dwb" ]

manageHooks = manageDocks
              <+> additionalManageHooks
              <+> composeAll [(isFullscreen --> doFullFloat)]
              <+> namedScratchpadManageHook pads
              <+> manageHook defaultConfig
              <+> (fmap not isDialog --> doF avoidMaster)

promptConfig = defaultXPConfig
    { font = myFont
    , bgColor  = "#000000"
    , fgColor  = "#FFFFFF"
    , bgHLight = "#CCCCCC"
    , fgHLight = "#EEEEEE"
    , promptBorderWidth = 0
    , height   = 28
    , historyFilter = nub
    , showCompletionOnTab = True
    }

myGSConfig = defaultGSConfig { gs_font = myFont }

myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.90

myDFGColor = "#757575" -- Dzen
myDBGColor = "#181818"
myFFGColor = "#cdff00" -- Focused
myFBGColor = myDBGColor
myVFGColor = "#ff3b77" -- Visible
myVBGColor = myDBGColor
myUFGColor = "#ff3b77" -- Urgent
myUBGColor = myDBGColor
myIFGColor = myDFGColor -- Icon
myIBGColor = myDBGColor
mySColor   = myDFGColor -- Separator
myBorder   = "#4c5e52"
myFocusedBorder = "#4c5e52"

myDzenPP h = defaultPP
    { ppCurrent         = dzenColor myFFGColor myFBGColor . wrap ("^fg(" ++ myIFGColor ++ ")^i(" ++ myIconDir ++ "/eye_l.xbm)" ++ "^fg(" ++ myFFGColor ++ ")") ""
    , ppVisible         = dzenColor myVFGColor myVBGColor . wrap "" ("^fg(" ++ myIFGColor ++ ")^i(" ++ myIconDir ++ "/eye_r.xbm)")
    , ppHidden          = dzenColor myDFGColor myDBGColor . wrap ("^i(" ++ myIconDir ++ "/dzen_bitmaps/has_win.xbm)") "" . hideNSP
    , ppHiddenNoWindows = dzenColor myDFGColor myDBGColor . wrap ("^i(" ++ myIconDir ++ "/dzen_bitmaps/has_win_nv.xbm)") "" . hideNSP
    , ppUrgent          = dzenColor myUFGColor myUBGColor . wrap ("^i(" ++ myIconDir ++ "/info_03.xbm)") "" . dzenStrip . hideNSP
    , ppLayout          = dzenColor myDFGColor myDBGColor .
                          (\x -> case x of
                          "Mirror ResizableTall" -> "^fg(" ++ myIFGColor ++ ")^i(" ++ myIconDir ++ "/dzen_bitmaps/mtall.xbm)"
                          "ResizableTall"    -> "^fg(" ++ myIFGColor ++ ")^i(" ++ myIconDir ++ "/dzen_bitmaps/tall.xbm)"
                          "Full"    -> "^fg(" ++ myIFGColor ++ ")^i(" ++ myIconDir ++ "/dzen_bitmaps/full.xbm)"
                          "Grid"    -> "^fg(" ++ myIFGColor ++ ")^i(" ++ myIconDir ++ "/dzen_bitmaps/grid.xbm)"
                          "TwoPane"   -> "^fg(" ++ myIFGColor ++ ")^i(" ++ myIconDir ++ "/dzen_bitmaps/two_pane.xbm)"
                          _ -> x
                          ) . stripIM
    , ppTitle           = dzenColor myVFGColor myVBGColor . shorten 50
    , ppSep             = " "
    , ppOutput          = hPutStrLn h
    }

hideNSP :: WorkspaceId -> String
hideNSP ws = if ws /= "NSP" then pad ws else ""

avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
        W.Stack t [] (r:rs) -> W.Stack t [r] rs
        otherwise     -> c