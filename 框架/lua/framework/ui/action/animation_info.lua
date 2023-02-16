
---动画时间线
---@class UI.Action.AnimationInfo
---@field _new function
UI.Action.AnimationInfo = Class("AnimationInfo")

---创建新实例
function UI.Action.AnimationInfo.new()
    return UI.Action.AnimationInfo._new()
end

---构造函数
function UI.Action.AnimationInfo:ctor()
    self._name = ""
    self._startIndex = 0
    self._endIndex = 0
end
