local japi = require "framework.dzapi"
local EventGroup = require "framework.event_group"

----------------------------------------------------------------
-- 鼠标类 异步
----------------------------------------------------------------
local Mouse = {}

Mouse.LEFT = 1
Mouse.RIGHT = 2

Mouse.DWON = 1
Mouse.UP = 0

----------------------------------------------------------------
-- 鼠标按键
----------------------------------------------------------------
local _mouseButtonGroup = {} -- 回调组
function Mouse.AddMouseButtonEvent(tag, button,state,fn)
    local group = _mouseButtonGroup[button]
    if group==nil then
        group = {}
        _mouseButtonGroup[button] = group
    end
    local event = group[state]
     if event==nil then
        event = EventGroup.new()
        group[state] = event
    end
    event:Add(tag, {isStop = false, fn = fn})
end

function Mouse.RemoveMouseButtonEvent(tag , button, state)
    local group = _mouseButtonGroup[button]
    if group==nil then
        return
    end
    local event = group[state]
     if event==nil then
        return
    end
    local v = event:Find(tag)
    if v ~= nil then
        v.isStop = true
    end
    event:Remove(tag)
end

local function _mouse()
    local key = japi.DzGetTriggerKey()
    local group = _mouseButtonGroup[key]
    if group==nil then
        return
    end
    local state
    if japi.DzIsKeyDown(key) then
        state = 1
    else
        state = 0
    end
    local event = group[state]
    if event==nil then
        return
    end
    group = event:Get()
    for k, v in SafePairs(group) do if (not v.isStop) then v.fn(k,key,state) end end
end

japi.DzTriggerRegisterMouseEventByCode(nil, Mouse.LEFT, Mouse.DWON, false, _mouse)
japi.DzTriggerRegisterMouseEventByCode(nil, Mouse.LEFT, Mouse.UP, false, _mouse)
japi.DzTriggerRegisterMouseEventByCode(nil, Mouse.RIGHT, Mouse.DWON, false, _mouse)
japi.DzTriggerRegisterMouseEventByCode(nil, Mouse.RIGHT, Mouse.UP, false, _mouse)

----------------------------------------------------------------
-- 鼠标移动
----------------------------------------------------------------
local _mouseMoveGroup = EventGroup.new() -- 回调组
function Mouse.AddMouseMoveEvent(tag, fn)
    _mouseMoveGroup:Add(tag, {isStop = false, fn = fn})
end

function Mouse.RemoveMouseMoveEvent(tag)
    local v = _mouseMoveGroup:Find(tag)
    if v ~= nil then
        v.isStop = true
    end
    _mouseMoveGroup:Remove(tag)
end

function Mouse.FindMouseMoveEvent(tag)
    return _mouseMoveGroup:Find(tag)
end

local function _MouseMove()
    local group = _mouseMoveGroup:Get()
    for k, v in SafePairs(group) do if (not v.isStop) then v.fn() end end
end
japi.DzTriggerRegisterMouseMoveEventByCode(nil,false,_MouseMove)

----------------------------------------------------------------
-- 鼠标齿轮
----------------------------------------------------------------
local _mouseWheelEventGroup = EventGroup.new() -- 回调组

function Mouse.AddMouseWheelEvent(tag, fn)
    _mouseWheelEventGroup:Add(tag, {isStop = false, fn = fn})
end

function Mouse.RemoveMouseWheelEvent(tag)
    local v = _mouseWheelEventGroup:Find(tag)
    if v ~= nil then
        v.isStop = true
    end
    _mouseWheelEventGroup:Remove(tag)
end

local function _MouseWheelEvent()
    local group = _mouseWheelEventGroup:Get()
    for k, v in SafePairs(group) do if (not v.isStop) then v.fn() end end
end
japi.DzTriggerRegisterMouseWheelEventByCode(nil, false, _MouseWheelEvent)
--local trig = CJ.CreateTrigger()
-- japi.DzTriggerRegisterMouseWheelEventByCode(nil, false, function()
--     local group = _mouseWheelEventGroup:Get()
--     for k, v in SafePairs(group) do if (not v.isStop) then v.fn() end end
-- end)

return Mouse
