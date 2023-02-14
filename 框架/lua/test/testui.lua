local japi = require "framework.dzapi"
local MessageHook = require "framework.message_hook"
local UI = require "framework.ui.ui"
local GameUI = require "framework.ui.game_ui"

local state = 1
MessageHook.Add("key_down", 769, "down_f2", function(msg)
    GameUI:removeAllChild()
    UI.LoadScene("MainScene.xmui")

    return true
end)