local japi = require "framework.dzapi"
local Time = require "framework.time"
local UpdateCallback = require "framework.update_callback"
local EventGroup = require "framework.event_group"
local Dev = require "framework.dev"

local _debug = false
----------------------------------------------------------------
-- 定时器
----------------------------------------------------------------
local TimerAsyn = {}

if Dev.HasXMLib() then
    TimerAsyn.CreateTimer = japi.XMCreateTimer
    TimerAsyn.GetExpiredTimer = japi.XMGetExpiredTimer
    TimerAsyn.TimerStart = japi.XMTimerStart
    TimerAsyn.DestroyTimer = japi.XMDestroyTimer
else

    local _time_index = 0 --定时器索引
    local _ExpiredTimer = nil -- 当前定时器
    
    local _timeGroup = EventGroup.new() -- 时间组
    
    -- 创建定时器
    function TimerAsyn.CreateTimer()
        _time_index = _time_index + 1
        return _time_index
    end
    
    -- 开始定时器(异步)
    function TimerAsyn.TimerStart(whichTimer, timeout, periodic, handlerFunc)
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
    
    -- 释放定时器
    function TimerAsyn.DestroyTimer(whichTimer)
        if whichTimer == nil then return end
        local v = _timeGroup:Find(whichTimer)
        if v ~= nil then v.isStop = true end
        _timeGroup:Remove(whichTimer)
    end
    
    -- 开始定时器(异步)
    local _debugTimerStart =
        function(whichTimer, timeout, periodic, handlerFunc)
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
    
    local _debugDestroyTimer = function(whichTimer)
        local stack = debug.traceback()
        if whichTimer == nil then return end
        local v = _timeGroup:Find(whichTimer)
        if v ~= nil then v.isStop = true end
        _timeGroup:Remove(whichTimer, nil, function()
            if type(whichTimer) == "number" then print(stack) end
        end)
    end
    
    if _debug then
        TimerAsyn.TimerStart = _debugTimerStart
        TimerAsyn.DestroyTimer = _debugDestroyTimer
    end
    
    -- 获得当前定时器
    function TimerAsyn.GetExpiredTimer() return _ExpiredTimer end
    
    local _count = 0
    local _last_time
    -- 异步全局定时器函数
    UpdateCallback.AddUpdateCallback("timer_asyn", function()
        local t = Time.getTime()
        if t==_last_time then
            return
        end
        _last_time = t
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
        --     _asyn_count = _asyn_count + 1
        --     if _asyn_count >= 30 then
        --         _asyn_count = 0
        --         print("timer asyn count:", group:GetCount())
        --         for _, v in group:Enum() do print(v.stack) end
        --     end
        -- end
    end)
end

return TimerAsyn
