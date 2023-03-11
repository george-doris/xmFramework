

---动画时间线
---@class UI.Action.SizeFrame:UI.Action.Frame
---@field _new function
local SizeFrame = Class("SizeFrame",UI.Action.Frame)

---创建新实例
---@return UI.Action.SizeFrame
function SizeFrame.new()
    return SizeFrame._new()
end

---构造函数
function SizeFrame:ctor()
    UI.Action.Frame.ctor(self)
    self._width = 0
    self._height = 0
    self._betweenSizeX = 0
    self._betweenSizeY = 0
end

---设置宽度
---@param width number 宽度
function SizeFrame:setWidth(width)
    self._width = width
end

---获得宽度
---@return number 宽度
function SizeFrame:getWidth()
    return self._width
end

---设置高度
---@param height number 高度
function SizeFrame:setHeight(height)
    self._height = height
end

---获得高度
---@return number 高度
function SizeFrame:getHeight()
    return self._height
end

function SizeFrame:onEnter(nextFrame,currentFrameIndex)
    if self._node==nil then
        return
    end
    self._node:setSize(self._width,self._height)

    if self._tween then
        self._betweenSizeX = nextFrame._width - self._width
        self._betweenSizeY = nextFrame._height - self._height
    end
end

function SizeFrame:onApply(percent)
    --if ((self._node) and (self._betweenSizeX ~= 0 or self._betweenSizeY ~= 0)) then
    if ((self._node) and (self._betweenSizeX ~= 0 )) then
        local sizeX = self._width + self._betweenSizeX * percent
        local sizeY = self._height + self._betweenSizeY * percent
        
        self._node:setSize(sizeX,sizeY)
    end
end

UI.Action.SizeFrame = SizeFrame