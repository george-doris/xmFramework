

---动画时间线
---@class UI.Action.AlphaFrame:UI.Action.Frame
---@field _new function
AlphaFrame = Class("AlphaFrame",UI.Action.Frame)

---创建新实例
---@return UI.Action.AlphaFrame
function AlphaFrame.new()
    return AlphaFrame._new()
end

---构造函数
function AlphaFrame:ctor()
    UI.Action.Frame.ctor(self)
    self._alpha = 255
end

---设置
---@param alpha integer 
function AlphaFrame:setAlpha(alpha)
    self._alpha = alpha
    self._betweenAlpha = 0
end

---获得
---@return integer 图片
function AlphaFrame:getAlpha()
    return self._alpha
end

function AlphaFrame:onEnter(nextFrame,currentFrameIndex)
    if self._node==nil then
        return
    end
    self._node:setAlpha(self._alpha);
    if self._tween then
        self._betweenAlpha = nextFrame._alpha - self._alpha;
    end
end

function AlphaFrame:onApply(percent)
    if self._node then
        local alpha = self._alpha + self._betweenAlpha * percent;
        
        self._node:setAlpha(alpha)
    end
end

UI.Action.AlphaFrame = AlphaFrame