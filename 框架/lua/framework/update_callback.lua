local japi = require "framework.dzapi"
local EventGroup = require "framework.event_group"
local Time = require "framework.time"

----------------------------------------------------------------
-- 界面更新回调-非同步
----------------------------------------------------------------
local UpdateCallback = {}

local _updateCallbackGroup = EventGroup.new() -- 回调组

function UpdateCallback.AddUpdateCallback(tag, fn)
    _updateCallbackGroup:Add(tag, {isStop = false, fn = fn})
end

function UpdateCallback.FindUpdateCallback(tag)
    return _updateCallbackGroup:Find(tag)
end

function UpdateCallback.RemoveUpdateCallback(tag)
    local v = _updateCallbackGroup:Find(tag)
    if v ~= nil then
        v.isStop = true
    end
    _updateCallbackGroup:Remove(tag)
end

local _last_time = Time.getTime()
japi.DzFrameSetUpdateCallbackByCode(function()
    local t = Time.getTime()
    if t==_last_time then
        return
    end
    local delayTime = t-_last_time
    _last_time = t
    local group = _updateCallbackGroup:Get()
    for k, v in SafePairs(group) do if (not v.isStop) then v.fn(delayTime) end end
end)

return UpdateCallback
