local japi = require "framework.dzapi"

local _debug = false
----------------------------------------------------------------
-- 定时器
----------------------------------------------------------------
local Time = {}

Time.Time_INTERVAL = 0.02
local _time = 0 -- 全局时间

local _start_time -- 服务器开始时间

-- 获得当前时间
if japi.XMGetTime then
    --使用内置
    Time.getTime = japi.XMGetTime
    Time.setTime = function (t)
    end
else
    Time.getTime = function ()
        return _time
    end
    Time.setTime = function (t)
        _time = t
    end
end

-- 获得开局时间
function Time.getStartTime()
    if _start_time == nil then
        _start_time = japi.DzAPI_Map_GetGameStartTime()
    end
    return _start_time
end

---获得日期
function Time.getDate() return os.date("%y%m%d", Time.GetStartTime()) end
---获得星期几
function Time.getWeek() return os.date("%w", Time.GetStartTime()) end

---转换时间格式 x小时x分钟x秒
function Time.convMinTime(time)
    local h = time // 3600
    time = time % 3600
    local m = time // 60
    time = time % 60
    local t = {}
    if h > 0 then
        table.insert(t, h)
        table.insert(t, "小时")
    end
    if m > 0 then
        table.insert(t, m)
        table.insert(t, "分钟")
    end
    table.insert(t, time)
    table.insert(t, "秒")

    return table.concat(t)
end


return Time
