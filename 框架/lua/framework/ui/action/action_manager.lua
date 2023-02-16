local UpdateCallback = require "framework.update_callback"

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

    UpdateCallback.AddUpdateCallback("ActionManager",function (delayTime)
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