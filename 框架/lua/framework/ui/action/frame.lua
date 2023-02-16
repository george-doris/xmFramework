require "framework.ui.common"
local tweenfunc = require "framework.ui.action.tweenfunc"
---动画时间线
---@class UI.Action.Frame
---@field _new function
local Frame = Class("Frame")

---创建新实例
function Frame.new()
    return Frame._new()
end

---构造函数
function Frame:ctor()
    self._frameIndex = 0
    self._tween = false
    self._tweenType = 0
    self._enterWhenPassed = false
    self._node = nil
end


---设置帧索引
---@param frameIndex integer 帧索引
function Frame:setFrameIndex(frameIndex)
    self._frameIndex = frameIndex
end

---获得持续时间
---@return integer 总帧数
function Frame:getFrameIndex()
    return self._frameIndex
end

---设置ui
---@param ui UI.UIBase 帧索引
function Frame:setNode(ui)
    self._node = ui
end

---设置补间动画
---@param tween boolean 补间动画
function Frame:setTween(tween)
    self._tween = tween
end

---获得补间动画
---@return boolean 总帧数
function Frame:getTween()
    return self._tween
end

---设置补间动画类型
---@param tweenType integer 补间动画类型
function Frame:setTweenType(tweenType)
    self._tweenType = tweenType
end

---获得补间动画类型
---@return integer 总帧数
function Frame:getTweenType()
    return self._tweenType
end


function Frame:isEnterWhenPassed() 
    return self._enterWhenPassed
end

function Frame:onApply(tweenpercent)
end

local function _tweenPercent(self,percent)
    return tweenfunc.tweenTo(percent, self._tweenType, self._easingParam.data());
end

function Frame:apply(percent)
    if not self._tween then
        return
    end
    
    local tweenpercent = percent;
    -- if self._tweenType ~= tweenfunc.TweenType.TWEEN_EASING_MAX and self._tweenType ~= tweenfunc.TweenType.Linear)
    --     tweenpercent = _tweenPercent(self,tweenpercent);
    -- end
    self:onApply(tweenpercent)
end

UI.Action.Frame = Frame