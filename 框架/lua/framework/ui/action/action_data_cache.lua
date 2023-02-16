local dev = require "framework.dev"
---动画时间线
---@class UI.Action.ActionDataCache
---@field _new function
local ActionDataCache = Class("ActionDataCache")

---创建新实例
---@return UI.Action.ActionDataCache
function ActionDataCache.new()
    return ActionDataCache._new()
end

---构造函数
function ActionDataCache:ctor()
    self._cache = {}
end

function ActionDataCache:Load(file,data)
    local actionData = self._cache[file]
    if actionData==nil then
        actionData = {}
        actionData.animation = data.animation
        actionData.animationList = data.animationList

        if not dev.isDebug() then
            self._cache[file] = actionData
        end
    end
    return actionData
end

UI.Action.ActionDataCache = ActionDataCache.new()

return ActionDataCache