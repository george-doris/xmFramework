

---动画时间线
---@class UI.Action.ScaleFrame:UI.Action.Frame
---@field _new function
local ScaleFrame = Class("ScaleFrame",UI.Action.Frame)

---创建新实例
---@return UI.Action.ScaleFrame
function ScaleFrame.new()
    return ScaleFrame._new()
end

---构造函数
function ScaleFrame:ctor()
    UI.Action.Frame.ctor(self)
    self._scaleX = 0
    self._scaleY = 0
    self._betweenScaleX = 0
    --self._betweenScaleY = 0
end

---设置x缩放
---@param scale number scale
function ScaleFrame:setScaleX(scale)
    self._scaleX = scale
end

---获得x缩放
---@return number x缩放
function ScaleFrame:getScaleX()
    return self._scaleX
end

---设置y缩放
---@param scale number 缩放
function ScaleFrame:setScaleY(scale)
    self._scaleY = scale
end

---获得y缩放
---@return number y缩放
function ScaleFrame:getScaleY()
    return self._scaleY
end

function ScaleFrame:onEnter(nextFrame,currentFrameIndex)
    if self._node==nil then
        return
    end
    self._node:setScale(self._scaleX);

    if self._tween then
        self._betweenScaleX = nextFrame._scaleX - self._scaleX
        --self._betweenScaleY = nextFrame._scaleY - self._scaleY
    end
end

function ScaleFrame:onApply(percent)
    --if ((self._node) and (self._betweenScaleX ~= 0 or self._betweenScaleY ~= 0)) then
    if ((self._node) and (self._betweenScaleX ~= 0 )) then
        local scaleX = self._scaleX + self._betweenScaleX * percent;
        --local scaleY = self._scaleY + self._betweenScaleY * percent;
        
        self._node:setScale(scaleX);
        --_node->setScaleY(scaleY);
    end
end

UI.Action.ScaleFrame = ScaleFrame