
---动画时间线
---@class UI.Action.ActionTimeline
---@field _new function
local ActionTimeline = Class("ActionTimeline")

---创建新实例
---@return UI.Action.ActionTimeline
function ActionTimeline.new()
    return ActionTimeline._new()
end

---构造函数
function ActionTimeline:ctor()
    
    self._playing = false
    self._frameInternal = 1.0/60.0
    self._frameEndCallFuncs = {}
    self._lastFrameListener = nil

    self._duration = 0
    self._timeSpeed = 1
    self._timelineMap = {}
    self._animationInfos = {}
end

---设置持续时间
---@param frameNumber integer 总帧数
function ActionTimeline:setDuration(frameNumber)
    self._duration = frameNumber
end

---获得持续时间
---@return integer 总帧数
function ActionTimeline:getDuration()
    return self._duration
end

---设置速度
---@param timeSpeed number 速度
function ActionTimeline:setTimeSpeed(timeSpeed)
    self._timeSpeed = timeSpeed
end

---获得速度
---@return integer 速度
function ActionTimeline:getTimeSpeed()
    return self._timeSpeed
end

function ActionTimeline:pause()
    self._playing = false
end

function ActionTimeline:resume()
    self._playing = true
end

---添加时间线
---@param timeline UI.Action.Timeline 速度
function ActionTimeline:addTimeline(timeline)
    table.insert(self._timelineMap,timeline)
end

---添加时间线
---@param animation UI.Action.AnimationInfo
function ActionTimeline:addAnimationInfo(animation)
    self._animationInfos[animation._name] = animation
end

local function gotoFrame(self,frameIndex)
    -- if(_target == nullptr)
    --     return

    ---@param value UI.Action.Timeline
    for index, value in ipairs(self._timelineMap) do
        value:gotoFrame(frameIndex)
    end
end

---开始动画
function ActionTimeline:start()
    self:gotoFrameAndPlay(0)
end

---停止动画
function ActionTimeline:stop()
    self:pause()
end

---播放动画
---@param name string 动画名
---@param loop boolean 循环
function ActionTimeline:play(name,loop)
    local animation = self._animationInfos[name]
    if animation==nil then
        return
    end

    self:gotoFrameAndPlay(animation._startIndex, animation._endIndex,animation._startIndex, loop)
end

---跳到帧
---@param frameIndex integer 帧
function ActionTimeline:gotoFrame(frameIndex)
    gotoFrame(self,frameIndex)
end

---播放动画
function ActionTimeline:gotoFrameAndPlay(startIndex, endIndex, currentFrameIndex, loop)
    self._startFrame = startIndex
    self._endFrame = endIndex or self._duration
    self._currentFrame = currentFrameIndex or startIndex
    self._loop = loop or true
    self._time = self._currentFrame*self._frameInternal

    self:resume()
    gotoFrame(self,self._currentFrame)
end

local function stepToFrame(self,frameIndex)
    ---@param value UI.Action.Timeline
    for index, value in ipairs(self._timelineMap) do
        value:stepToFrame(frameIndex)
    end
end

local function emitFrameEndCallFuncs(self,frameIndex)
    local clipEndCalls = self._frameEndCallFuncs[frameIndex]
    if clipEndCalls then
        for index, value in SafePairs(clipEndCalls) do
            clipEndCalls()
        end
    end
end

function ActionTimeline:step(delta)
    if (not self._playing) or (#self._timelineMap == 0) or (self._duration == 0) then
        return
    end
    self._time = self._time + delta * self._timeSpeed
    local deltaCurrFrameTime = math.abs(self._time - self._currentFrame * self._frameInternal)
    if deltaCurrFrameTime < self._frameInternal then
        return
    end

    local endtoffset = self._time - self._endFrame * self._frameInternal
    if endtoffset < self._frameInternal then
        self._currentFrame = (self._time // self._frameInternal);
        stepToFrame(self,self._currentFrame);
        emitFrameEndCallFuncs(self,self._currentFrame);
        if endtoffset >= 0 and self._lastFrameListener then
            self:_lastFrameListener()
        end
    else
        self._playing = self._loop;
        if (not self._playing) then
            self._time = self._endFrame * self._frameInternal
            if (self._currentFrame ~= self._endFrame) then
                self._currentFrame = self._endFrame
                stepToFrame(self,self._currentFrame)
                emitFrameEndCallFuncs(self,self._currentFrame);
                if (self._lastFrameListener) then
                    self._lastFrameListener()
                end
            end
        else
            self:gotoFrameAndPlay(self._startFrame, self._endFrame, self._startFrame, self._loop)
        end
    end
end

UI.Action.ActionTimeline = ActionTimeline

return ActionTimeline