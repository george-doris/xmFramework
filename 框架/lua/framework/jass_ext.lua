require "framework.ui.jass_ui_ext"

--扩展到T,但需要内置
local code
local _sync_send = {}
local _sync_data = nil
local Dev = require "framework.dev"
if Dev.HasXMLib() then
    code = require "code"
else
    local r,e = pcall(function ()
        return require("jass.code")
    end)
    if r then
        code = require("jass.code")
    end
end
if code ~= nil then
    require "framework.ui.layer"
    require "framework.ui.ui"
    require "framework.ui.tip"
    local japi = require "jass.japi"
    local jass = require "jass.common"
    local Command = require "framework.command"

    local _executeTrigger = jass.TriggerExecute

    code["XMFWSyncData"] = function(trig)
        local name = japi.XMGetTriggerName(trig)
        _sync_send._trig = name
        Command.Send("xmfw",_sync_send)
        _sync_send = {}
    end

    code["XMFWSyncDataImm"] = function(trig)
        local name = japi.XMGetTriggerName(trig)
        _sync_send._trig = name
        Command.SendImm("xmfw",_sync_send)
        _sync_send = {}
    end

    code["XMFWSyncPushString"] = function(key,data)
        _sync_send[key] = data
    end

    code["XMFWSyncGetString"] = function(key)
        return _sync_data[key]
    end

    code["XMFWSyncPushInteger"] = function(key,data)
        _sync_send[key] = data
    end

    code["XMFWSyncGetInteger"] = function(key)
        return _sync_data[key]
    end

    code["XMFWSyncPushReal"] = function(key,data)
        _sync_send[key] = data
    end

    code["XMFWSyncGetReal"] = function(key)
        return _sync_data[key]
    end

    Command.Add("xmfw",function (player, data)
        _sync_data = data
        jass.ExecuteFunc(data._trig)
        _sync_data = nil
    end)
end
