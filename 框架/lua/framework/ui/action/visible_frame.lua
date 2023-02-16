

---动画时间线
---@class UI.Action.VisibleFrame:UI.Action.Frame
---@field _new function
VisibleFrame = Class("VisibleFrame",UI.Action.Frame)

---创建新实例
---@return UI.Action.VisibleFrame
function VisibleFrame.new()
    return VisibleFrame._new()
end

---构造函数
function VisibleFrame:ctor()
    UI.Action.Frame.ctor(self)
    self._visible = false
end

---设置图片
---@param visible boolean 图片
function VisibleFrame:setVisible(visible)
    self._visible = visible
end

---获得图片
---@return boolean 图片
function VisibleFrame:getVisible()
    return self._visible
end

function VisibleFrame:onEnter(nextFrame,currentFrameIndex)
    if self._node then
        self._node:setVisible(self._visible);
    end
end

UI.Action.VisibleFrame = VisibleFrame