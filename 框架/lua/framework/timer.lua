local CJ = require "jass.common"
local japi = require "framework.dzapi"
local Time = require "framework.time"
local UpdateCallback = require "framework.update_callback"
local EventGroup = require "framework.event_group"

local _debug = false
----------------------------------------------------------------
-- 定时器
----------------------------------------------------------------
local Timer = {}

Timer.TIMER_INTERVAL = 0.02
local _time_index = 0 --定时器索引
local _ExpiredTimer = nil -- 当前定时器

local _timeGroup = EventGroup.new() -- 时间组
local _timeGroupAsyn = EventGroup.new() -- 异步时间组

-- 创建定时器
function Timer.CreateTimer()
    _time_index = _time_index + 1
    return _time_index
end

-- 开始定时器
function Timer.TimerStart(whichTimer, timeout, periodic, handlerFunc)
    _timeGroup:Add(whichTimer, {
        whichTimer = whichTimer,
        timeout = timeout,
        periodic = periodic,
        handlerFunc = handlerFunc,
        isStop = false,
        nextTime = Time.getTime() + timeout
    },function (data)
        return data
    end)
end

-- 开始定时器(异步)
function Timer.TimerStartAsyn(whichTimer, timeout, periodic, handlerFunc)
    _timeGroupAsyn:Add(whichTimer, {
        whichTimer = whichTimer,
        timeout = timeout,
        periodic = periodic,
        handlerFunc = handlerFunc,
        isStop = false,
        nextTime = Time.getTime() + timeout
    },function (data)
        return data
    end)
end

-- 释放定时器
function Timer.DestroyTimer(whichTimer)
    if whichTimer == nil then return end
    local v = _timeGroup:Find(whichTimer)
    if v ~= nil then v.isStop = true end
    _timeGroup:Remove(whichTimer)
end

function Timer.DestroyTimerAsyn(whichTimer)
    if whichTimer == nil then return end
    local v = _timeGroupAsyn:Find(whichTimer)
    if v ~= nil then v.isStop = true end
    _timeGroupAsyn:Remove(whichTimer)
end

local _debugTimerStart = function(whichTimer, timeout, periodic, handlerFunc)
    _timeGroup:Add(whichTimer, {
        whichTimer = whichTimer,
        timeout = timeout,
        periodic = periodic,
        handlerFunc = handlerFunc,
        isStop = false,
        nextTime = 0,
        stack = debug.traceback()
    })
end

-- 开始定时器(异步)
local _debugTimerStartAsyn =
    function(whichTimer, timeout, periodic, handlerFunc)
        _timeGroupAsyn:Add(whichTimer, {
            whichTimer = whichTimer,
            timeout = timeout,
            periodic = periodic,
            handlerFunc = handlerFunc,
            isStop = false,
            nextTime = 0,
            stack = debug.traceback()
        })
    end

-- 释放定时器
local _debugDestroyTimer = function(whichTimer)
    local stack = debug.traceback()
    if whichTimer == nil then return end
    local v = _timeGroup:Find(whichTimer)
    if v ~= nil then v.isStop = true end
    _timeGroup:Remove(whichTimer, nil, function()
        if type(whichTimer) == "number" then print(stack) end
    end)
end

local _debugDestroyTimerAsyn = function(whichTimer)
    local stack = debug.traceback()
    if whichTimer == nil then return end
    local v = _timeGroupAsyn:Find(whichTimer)
    if v ~= nil then v.isStop = true end
    _timeGroupAsyn:Remove(whichTimer, nil, function()
        if type(whichTimer) == "number" then print(stack) end
    end)
end

if _debug then
    Timer.TimerStart = _debugTimerStart
    Timer.TimerStartAsyn = _debugTimerStartAsyn
    Timer.DestroyTimer = _debugDestroyTimer
    Timer.DestroyTimerAsyn = _debugDestroyTimerAsyn
end

-- 获得当前定时器
function Timer.GetExpiredTimer() return _ExpiredTimer end

local _count = 0
-- 全局定时器函数
CJ.TimerStart(CJ.CreateTimer(), Timer.TIMER_INTERVAL, true, function()
    local t = Time.getTime() + Timer.TIMER_INTERVAL
    Time.setTime(t)
    local group = _timeGroup:Get()
    for _, v in SafePairs(group) do
        if (not v.isStop) and (t >= v.nextTime) then
            _ExpiredTimer = v.whichTimer
            v.handlerFunc(v.whichTimer, v.timeout, v.periodic)
            if v.periodic then
                v.nextTime = t + v.timeout
            else
                v.isStop = true
            end
        end
    end
    -- if _debug then
    --     _count = _count + 1
    --     if _count >= 30 then
    --         _count = 0
    --         print("timer count:", group:GetCount())
    --         for _, v in group:Enum() do print(v.stack) end
    --     end
    -- end
end)

local _asyn_count = 0
local _last_time
-- 异步全局定时器函数
UpdateCallback.AddUpdateCallback("timer_asyn", function()
    local t = Time.getTime()
    if t==_last_time then
        return
    end
    _last_time = t
    local group = _timeGroupAsyn:Get()
    for _, v in SafePairs(group) do
        if (not v.isStop) and (t >= v.nextTime) then
            _ExpiredTimer = v.whichTimer
            v.handlerFunc(v.whichTimer, v.timeout, v.periodic)
            if v.periodic then
                v.nextTime = t + v.timeout
            else
                v.isStop = true
            end
        end
    end

    -- if _debug then
    --     _asyn_count = _asyn_count + 1
    --     if _asyn_count >= 30 then
    --         _asyn_count = 0
    --         print("timer asyn count:", group:GetCount())
    --         for _, v in group:Enum() do print(v.stack) end
    --     end
    -- end
end)

return Timer
