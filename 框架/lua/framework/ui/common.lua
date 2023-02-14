local japi = require "framework.dzapi"
local UTF8 = require "framework.utf8"
require "framework.functions"

---UI总类
---@class UI
UI = {}

---@class UI.AnchorType
UI.AnchorType = {
    LEFT_TOP = 0,  --左上
    TOP = 1,   --上
    RIGHT_TOP = 2,  --右上
    LEFT = 3,  --左中
    CENTET = 4,  --中心
    RIGHT = 5,  --右中
    LEFT_BOTTOM = 6,  --左下
    BOTTOM = 7,  --下中
    RIGHT_BOTTOM = 8  --右下
}

---@class UI.MouseEvent
UI.MouseEvent = {
    MOUSE_DOWN = 0,  --按下
    MOUSE_CLICK = 1,  --点击
    MOUSE_ENTER = 2, --进入
    MOUSE_LEAVE = 3,  --离开
    MOUSE_UP = 4,  --抬起
    MOUSE_WHEEL = 6,  --滚轮
    MOUSE_DBCLICK = 12,  --双击
    MOUSE_MOVE = 100,  --移动
    MOUSE_LEFT_DOWN = 101,  --左键按下
    MOUSE_LEFT_UP = 102,  --左键抬起
    MOUSE_RIGHT_DOWN = 103,  --右键按下
    MOUSE_RIGHT_UP = 104  --右键抬起
}

---@class UI.TextAlign
UI.TextAlign = 
{
    TOP = 0, --顶
    VCENTER = 2, --中
    BOTTOM = 4, --下
    LEFT = 0, --左
    CENTER = 16, --中
    RIGHT = 32, --又
}

---@class UI.Direction
UI.Direction = {
    VERTICAL = 0, --垂直
    HORIZONTAL = 1  --水平
}

---@class UI.TextFlag
UI.TextFlag = 
{
    STRETCH = 0, --拉伸
    TILE = 1, --平铺
    SINGLE = 2, --单张
}

---获得颜色
---@param r integer 红色 0-255
---@param g integer 绿色 0-255
---@param b integer 蓝色 0-255
---@param a integer 透明度 0-255
function UI.GetTextColor(r, g, b, a)
    return string.format("|c%02x%02x%02x%02x", a, r, g, b)
end

---设置颜色
---@param r integer 红色 0-255
---@param g integer 绿色 0-255
---@param b integer 蓝色 0-255
---@param a integer 透明度 0-255
function UI.SetTextColor(text, r, g, b, a)
    local color = UI.GetTextColor(r, g, b, a)
    local t = {color, text}
    return table.concat(t)
end

function UI.ClearTextColor(input)
    if input == nil then return {} end
    local line = {}
    local len = string.len(input)
    local left = len
    local arr = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    local skip
    local str
    while left ~= 0 do
        skip = false
        local tmp = string.byte(input, -left)
        if tmp == 124 then
            local tmp1 = string.byte(input, -left + 1)
            if tmp1 == 99 then
                left = left - 10
                skip = true
            end
        end
        if not skip then
            local i = #arr
            while arr[i] do
                if tmp >= arr[i] then
                    left = left - i
                    break
                end
                i = i - 1
            end

            str = string.sub(input, -left - i, -left - 1)
            table.insert(line, str)
        end
    end
    return table.concat(line)
end

local function _mouse_event(event_id)
    return function ()
        local frameid = japi.DzGetTriggerUIEventFrame()
        local ui = UI.findFromFrameID(frameid)
        if ui ~= nil then
            local group = ui._event
            if group then
                local event = group.events[event_id]
                if event ~= nil then event(ui) end
            end
        end
    end
end

---鼠标事件回调函数名
UI.MOUSE_EVENT_INDEX = {}
for i=1,12 do 
    table.insert(UI.MOUSE_EVENT_INDEX,_mouse_event(i))
end

local _components = {}

--注册ui
function UI.register(ui,frameid)
    _components[frameid or ui:getFrameID()] = ui
end

--注销ui
function UI.unRegister(frameid)
    _components[frameid] = nil
end

--war3窗口句柄查找ui
function UI.findFromFrameID(frameid)
    return _components[frameid]
end

japi.DzLoadToc("fdf\\UI.toc")

return UI