DOTFILES=$(shell pwd)

all: shell tmux vim X i3 vim mpd mail
shell: 
			ln -fs ${DOTFILES}/.zshrc ${HOME}/.zshrc
			ln -fs ${DOTFILES}/.zshenv ${HOME}/.zshenv
			ln -fs ${DOTFILES}/.zpath ${HOME}/.zpath
			ln -fs ${DOTFILES}/.zprofile ${HOME}/.zprofile
			ln -fns ${DOTFILES}/bin ${HOME}/bin
tmux:
			ln -fs ${DOTFILES}/.tmux.conf ${HOME}/.tmux.conf
X:
			ln -fs ${DOTFILES}/.Xresources ${HOME}/.Xresources
			ln -fs ${DOTFILES}/.xscreensaver ${HOME}/.xscreensaver
			ln -fs ${DOTFILES}/.xinitrc ${HOME}/.xinitrc
i3:
			mkdir -p ${HOME}/.i3
			ln -fs ${DOTFILES}/.i3/config ${HOME}/.i3/config
			ln -fs ${DOTFILES}/.i3/conkyrc ${HOME}/.i3/conkyrc
vim:
			ln -fs ${DOTFILES}/.vimrc ${HOME}/.vimrc
			mkdir -p ${HOME}/.vim/{backup,tmp,colors}
mpd:
			ln -fs ${DOTFILES}/.mpdconf ${HOME}/.mpdconf
			mkdir -p ${HOME}/.ncmpcpp
			ln -fs ${DOTFILES}/.ncmpcpp/config ${HOME}/.ncmpcpp/config
mail:
			ln -fs ${DOTFILES}/.muttrc ${HOME}/.muttrc
			mkdir -p ${HOME}/.mutt
			ln -fs ${DOTFILES}/.mutt/colors.muttrc ${HOME}/.mutt/colors.muttrc
			ln -fs ${DOTFILES}/.mutt/gpg.rc ${HOME}/.mutt/gpg.rc
			ln -fs ${DOTFILES}/.mutt/mailcap ${HOME}/.mutt/.mailcap
			ln -fs ${DOTFILES}/.mutt/sidebar.muttrc ${HOME}/.mutt/sidebar.muttrc
			ln -fs ${DOTFILES}/.urlview ${HOME}/.urlview
			gpg -d ${DOTFILES}/.offlineimaprc.gpg > ${HOME}/.offlineimaprc
