require "framework.ui.action.frame"

---动画时间线
---@class UI.Action.PositionFrame:UI.Action.Frame
---@field _new function
local PositionFrame = Class("PositionFrame",UI.Action.Frame)

---创建新实例
---@return UI.Action.PositionFrame
function PositionFrame.new()
    return PositionFrame._new()
end

---构造函数
function PositionFrame:ctor()
    UI.Action.Frame.ctor(self)
    self._x = 0
    self._y = 0
    self._betweenX = 0
    self._betweenY = 0
end

---设置x
---@param x number x
function PositionFrame:setX(x)
    self._x = x
end

---获得x
---@return number x
function PositionFrame:getX()
    return self._x
end

---设置y
---@param y number y
function PositionFrame:setY(y)
    self._y = y
end

---获得y
---@return number y
function PositionFrame:getY()
    return self._y
end

function PositionFrame:onEnter(nextFrame,currentFrameIndex)
    if self._node==nil then
        return
    end
    self._node:setPosition(self._x,self._y);

    if self._tween then
        self._betweenX = nextFrame._x - self._x;
        self._betweenY = nextFrame._y - self._y;
    end
end

function PositionFrame:onApply(percent)
    if (self._node) and (self._betweenX ~= 0 or self._betweenY ~= 0) then
        local x = self._x + self._betweenX * percent;
        local y = self._y + self._betweenY * percent;
        
        self._node:setPosition(x,y)
    end
end

UI.Action.PositionFrame = PositionFrame