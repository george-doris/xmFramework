require "framework.ui.action.frame"

---动画时间线
---@class UI.Action.Timeline
---@field _new function
local Timeline = Class("Timeline")

---创建新实例
---@return UI.Action.Timeline
function Timeline.new()
    return Timeline._new()
end

---构造函数
function Timeline:ctor()
    self._frames = {}
    self._fromIndex = 0
    self._toIndex = 0
    self._currentKeyFrameIndex = 0
    self._currentKeyFrame = nil
    self._betweenDuration = false
end

---添加帧
---@param frame UI.Action.Frame 帧
function Timeline:addFrame(frame)
    table.insert(self._frames,frame)
end

local function _binarySearchKeyFrame(self,frameIndex,actionTimeline)
    local from
    local to

    local frames = self._frames
    local length = #frames
    local needEnterFrame = false

    while true do 
        if frameIndex < frames[1]:getFrameIndex() then
            if self._currentKeyFrameIndex >= frames[1]:getFrameIndex() then
                needEnterFrame = true
            end

            self._fromIndex = 0
            self._toIndex = 0
            
            to = frames[1]
            from = to
            self._currentKeyFrameIndex = 0
            self._betweenDuration = frames[1]:getFrameIndex()
            break
        elseif frameIndex >= frames[length]:getFrameIndex() then
            self._fromIndex = length-1
            self._toIndex = 0
            
            to = frames[length] 
            from = to
            if from:isEnterWhenPassed() then
                needEnterFrame = true
            end

            self._currentKeyFrameIndex = frames[length]:getFrameIndex()
            self._betweenDuration = 0
            break
        end

        local target = -1
        local low=0
        local high=length-1
        local mid=0
        while low<=high do 
            mid=(low+high)//2
            if frameIndex >= frames[mid+1]:getFrameIndex() and frameIndex < frames[mid+2]:getFrameIndex() then
                target = mid
                break
            end
            if frames[mid+1]:getFrameIndex()>frameIndex then
                high=mid-1 
            else
                low=mid+1
            end
        end
        
        self._fromIndex = target

        if length > 1 then
            self._toIndex = (target + 1)
        else
            self._toIndex = target
        end

        from = frames[self._fromIndex+1]
        to   = frames[self._toIndex+1]

        if target == 0 and self._currentKeyFrameIndex<from:getFrameIndex() then
            needEnterFrame = true
        end

        self._currentKeyFrameIndex = from:getFrameIndex()
        self._betweenDuration = to:getFrameIndex() - from:getFrameIndex()

        break
    end

    if needEnterFrame or self._currentKeyFrame ~= from then
        self._currentKeyFrame = from
        self._currentKeyFrame:onEnter(to, frameIndex, actionTimeline)
    end
end

local function _apply(self,frameIndex)
    if self._currentKeyFrame then
        local currentPercent = self._betweenDuration == 0 and 0 or (frameIndex - self._currentKeyFrameIndex) / self._betweenDuration
        self._currentKeyFrame:apply(currentPercent)
    end
end

function Timeline:gotoFrame(frameIndex,actionTimeline)
    if #self._frames == 0 then
        return
    end

    _binarySearchKeyFrame(self,frameIndex,actionTimeline)
    _apply(self,frameIndex)
end

local function _updateCurrentKeyFrame(self,frameIndex,actionTimeline)
    --! If play to current frame's front or back, then find current frame again
    if (frameIndex < self._currentKeyFrameIndex or frameIndex >= self._currentKeyFrameIndex + self._betweenDuration) then
        local from
        local to

        while true do
            local length = #self._frames

            if (frameIndex < self._frames[1]:getFrameIndex()) then
                to = self._frames[1]
                from = to
                self._currentKeyFrameIndex = 0
                self._betweenDuration = self._frames[1]:getFrameIndex()
                break
            elseif(frameIndex >= self._frames[length]:getFrameIndex()) then
				local lastFrameIndex = self._frames[length]:getFrameIndex()
                if(self._currentKeyFrameIndex >= lastFrameIndex) then
                    return
                end
                frameIndex = lastFrameIndex
            end

            while true do
                self._fromIndex = self._toIndex
                from = self._frames[self._fromIndex+1]
                self._currentKeyFrameIndex  = from:getFrameIndex()

                self._toIndex = self._fromIndex + 1
                if (self._toIndex >= length) then
                    self._toIndex = 0
                end

                to = self._frames[self._toIndex+1]

                if(frameIndex == from:getFrameIndex()) then
                    break
                end
                if(frameIndex > from:getFrameIndex() and frameIndex < to:getFrameIndex()) then
                    break
                end
                if(from:isEnterWhenPassed()) then
                    from:onEnter(to, from:getFrameIndex(), actionTimeline)
                end
                break
            end

            if(self._fromIndex == length-1) then
                to = from
            end
            
            self._betweenDuration = to:getFrameIndex() - from:getFrameIndex()
            break
        end

        self._currentKeyFrame = from
        self. _currentKeyFrame:onEnter(to, frameIndex, actionTimeline)
        
    end
end

function Timeline:stepToFrame(frameIndex,actionTimeline)
    if #self._frames == 0 then
        return
    end

    _updateCurrentKeyFrame(self,frameIndex,actionTimeline)
    _apply(self,frameIndex)
end

function Timeline:destroy()
    self._frames = nil
end

UI.Action.Timeline = Timeline

return Timeline