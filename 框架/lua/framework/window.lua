local japi = require "framework.dzapi"
local EventGroup = require "framework.event_group"

----------------------------------------------------------------
-- 界面更新回调-非同步
----------------------------------------------------------------
local Window = {}

local _width = 0
local _height = 0

local _width_scale = 1
local _height_scale = 1

local _windowResizeCallbackGroup = EventGroup.new() -- 回调组

function Window.AddResizeCallback(tag, fn)
    _windowResizeCallbackGroup:Add(tag, {isStop = false, fn = fn})
end

function Window.FindResizeCallback(tag)
    return _windowResizeCallbackGroup:Find(tag)
end

function Window.RemoveResizeCallback(tag)
    local v = _windowResizeCallbackGroup:Find(tag)
    if v ~= nil then
        v.isStop = true
    end
    _windowResizeCallbackGroup:Remove(tag)
end

function Window.GetWidthScale()
    return _width_scale
end

function Window.GetHeightScale()
    return _height_scale
end

japi.DzTriggerRegisterWindowResizeEventByCode(nil, false, function()
    _width = japi.DzGetClientWidth()
    _height = japi.DzGetClientHeight()

    _width_scale = _width / 800
    _height_scale = _height / 600

    local group = _windowResizeCallbackGroup:Get()
    for k, v in SafePairs(group) do if (not v.isStop) then v.fn(_width,_height) end end
end)

return Window
