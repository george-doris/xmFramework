local japi = require "framework.dzapi"
local EventGroup = require "framework.event_group"

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

japi.DzFrameSetUpdateCallbackByCode(function()
    local group = _updateCallbackGroup:Get()
    for k, v in SafePairs(group) do if (not v.isStop) then v.fn() end end
end)

return UpdateCallback
