---动画时间线
---@class UI.Action.FrameEvent:UI.Action.Frame
---@field _new function
FrameEvent = Class("FrameEvent", UI.Action.Frame)

---创建新实例
---@return UI.Action.FrameEvent
function FrameEvent.new()
    return FrameEvent._new()
end

---构造函数
function FrameEvent:ctor()
    UI.Action.Frame.ctor(self)
    self._event = nil
end

---设置
---@param event string
function FrameEvent:setEvent(event)
    self._event = event
end

---获得
---@return string 事件
function FrameEvent:getEvent()
    return self._event
end

function FrameEvent:onEnter(nextFrame, currentFrameIndex, actionTimeline)
    if self._node == nil then
        return
    end
    if (self._frameIndex < actionTimeline._startFrame or self._frameIndex > actionTimeline._endFrame) then
        return
    end

    if currentFrameIndex >= self._frameIndex then
        if self._event and self._event ~= "" then
            local fn = require(self._event)
            fn(actionTimeline._node, self._node)
        end
    end
end

UI.Action.FrameEvent = FrameEvent
