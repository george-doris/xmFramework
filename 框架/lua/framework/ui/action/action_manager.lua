local UpdateCallback = require "framework.update_callback"
local Time = require "framework.time"
local TimerAsyn = require "framework.timer_asyn"
local Dev = require "framework.dev"

---动画时间线
---@class UI.ActionManager
---@field _new function
local ActionManager = Class("ActionManager")

---创建新实例
---@return UI.ActionManager
function ActionManager.new()
    return ActionManager._new()
end

local function _step(self,interval)
    for index, value in SafePairs(self._actions) do
        value:step(interval)
    end
end

---构造函数
function ActionManager:ctor()
    self._actions = {}

    --内置-异步定时器
    local _last_time = Time.getTime()
    TimerAsyn.TimerStart(TimerAsyn.CreateTimer(),0.02,true,function ()
        local t = Time.getTime()
        if t==_last_time then
            return
        end
        local delayTime = t-_last_time
        _last_time = t
        _step(self,delayTime)
    end)
end



---添加动画
function ActionManager:addAction(action)
    self._actions[action] = action
end

---移除动画
function ActionManager:removeAction(action)
    self._actions[action] = nil
end

function ActionManager:removeAllAction()
    self._actions = {}
end

UI.ActionManager = ActionManager.new()

return UI.ActionManager