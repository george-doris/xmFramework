require "framework.ui.action.action_timeline"
require "framework.ui.action.timeline"
require "framework.ui.action.position_frame"
require "framework.ui.action.scale_frame"
require "framework.ui.action.texture_frame"
require "framework.ui.action.visible_frame"
require "framework.ui.action.alpha_frame"
require "framework.ui.action.frame_event"

---@class UIActionParser
local UIActionParser = {}

---设置位置动画
local function Position(root,node)
    local timeline = UI.Action.Timeline.new()

    for _, value in ipairs(root.frames) do
        local frame = UI.Action.PositionFrame.new()
        frame:setNode(node)
        frame:setFrameIndex(value.frameIndex)
        frame:setTween(value.tween)
        frame:setTweenType(value.easingData)
        frame:setX(value.x)
        frame:setY(value.y)
        timeline:addFrame(frame)
    end
    return timeline
end

---设置缩放动画
local function Scale(root,node)
    local timeline = UI.Action.Timeline.new()

    for _, value in ipairs(root.frames) do
        local frame = UI.Action.ScaleFrame.new()
        frame:setNode(node)
        frame:setFrameIndex(value.frameIndex)
        frame:setTween(value.tween)
        frame:setTweenType(value.easingData)
        frame:setScaleX(value.x)
        frame:setScaleY(value.y)
        timeline:addFrame(frame)
    end
    return timeline
end

---设置材质动画
local function FileData(root,node)
    local timeline = UI.Action.Timeline.new()

    for _, value in ipairs(root.frames) do
        local frame = UI.Action.TextureFrame.new()
        frame:setNode(node)
        frame:setFrameIndex(value.frameIndex)
        frame:setTween(value.tween)
        frame:setTextureName(value.file)
        timeline:addFrame(frame)
    end
    return timeline
end

---设置显示动画
local function VisibleForFrame(root,node)
    local timeline = UI.Action.Timeline.new()

    for _, value in ipairs(root.frames) do
        local frame = UI.Action.VisibleFrame.new()
        frame:setNode(node)
        frame:setFrameIndex(value.frameIndex)
        frame:setTween(value.tween)
        frame:setVisible(value.value)
        timeline:addFrame(frame)
    end
    return timeline
end

---设置显示动画
local function Alpha(root,node)
    local timeline = UI.Action.Timeline.new()

    for _, value in ipairs(root.frames) do
        local frame = UI.Action.AlphaFrame.new()
        frame:setNode(node)
        frame:setFrameIndex(value.frameIndex)
        frame:setTween(value.tween)
        frame:setAlpha(value.value)
        timeline:addFrame(frame)
    end
    return timeline
end

---设置帧事件
local function FrameEvent(root,node)
    local timeline = UI.Action.Timeline.new()

    for _, value in ipairs(root.frames) do
        local frame = UI.Action.FrameEvent.new()
        frame:setNode(node)
        frame:setFrameIndex(value.frameIndex)
        frame:setTween(value.tween)
        frame:setEvent(value.value)
        timeline:addFrame(frame)
    end
    return timeline
end

local _factory = {
    Position = Position,
    Scale = Scale,
    FileData = FileData,
    VisibleForFrame = VisibleForFrame,
    Alpha = Alpha,
    FrameEvent = FrameEvent,
}

---comment
---@param ui UI.UIBase
---@param actionTag string
local function _findNode(ui,actionTag)
    local node
    if ui._actionTag==actionTag then
        return ui
    end
    for index, value in ipairs(ui._children) do
        node = _findNode(value,actionTag)
        if node then
            return node
        end
    end
end

---comment
---@param ui UI.Layer
---@param root table
function UIActionParser.Load(ui,root)
    local nodeIndexs = {}
    local animation = root.animation

    local actionTimeline = UI.Action.ActionTimeline.new()
    actionTimeline:setDuration(animation.duration)
    actionTimeline:setTimeSpeed(animation.speed)
    actionTimeline:setNode(ui)

    if animation.timeline then
        for index, value in ipairs(animation.timeline) do
            local node = nodeIndexs[value.actionTag]
            if node==nil then
                node = _findNode(ui,value.actionTag)
            end
            if node then
                local fn = _factory[value.property]
                ---@type UI.Action.Timeline
                local timeline = fn(value,node)
                actionTimeline:addTimeline(timeline)
            end
        end
    end

    for index, value in SafePairs(root.animationList) do
        actionTimeline:addAnimationInfo({_name=value.name,_startIndex=value.startIndex,_endIndex=value.endIndex})
    end
    return actionTimeline
end

return UIActionParser