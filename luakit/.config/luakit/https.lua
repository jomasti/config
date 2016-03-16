-- Get Lua environment
local os = require "os"
local io = require "io"
local tonumber = tonumber
local assert = assert
local string = string
local ipairs = ipairs
local table = table

-- Get luakit environment
local webview = webview
local luakit = luakit
local info = info
local strip = lousy.util.string.strip

module("https")

file_path = luakit.data_dir .. "/https-everywhere"

function match(v, uri, signal)
    for i, pat in ipairs(https_list)
    do
        if string.match(uri, pat) and not string.match(uri, "^https://")
        then
            v.uri = string.gsub(uri, "^http", "https")
            return false
        end
    end
end

function load_list(file)
    if os.exists(file)
    then
        local target = {}
        for line in io.lines(file)
        do
            table.insert(target, strip(line))
        end
        return target
    end
end

https_list = load_list(file_path) or {}

webview.init_funcs.https_enforcer = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        return match(v, uri, "navigation-request")
        end)
end
