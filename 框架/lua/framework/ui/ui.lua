local japi = require "framework.dzapi"
local Serialize = require "framework.serialize"
local GameUI = require "framework.ui.game_ui"
local UIParser = require "framework.ui.uiparser"
local UpdateCallback = require "framework.update_callback"
local TimerAsyn = require "framework.timer_asyn"
local Timer = require "framework.timer"
local Dev = require "framework.dev"
require "framework.ui.layer"

function UI.LoadScene(filename, parent, name)
    local f = io.open(filename, "r")
    if f==nil then
        error("场景文件不存在:"..filename)
        return 0
    end
    local buffer = f:read("a")
    f:close()
    local data = Serialize.unSerialize(buffer)

    local ui = UI.Layer.new(name or data.name, parent or GameUI)
    UIParser.LoadChildren(data.children, ui)
    ui:setAnchorType(UI.AnchorType.LEFT_BOTTOM)
    ui:setPosition(0, 0)
    ui:setSize(0.8, 0.6)

    local actionData = UI.Action.ActionDataCache:Load(filename, data)
    ui._actionData = actionData
    -- UIActionParser.Load(ui,actionData)
    if data.userData then
        local fn = require(data.userData)
        fn(ui)
    end
    return ui
end

---获得鼠标在窗口位置
---@return table
function UI.GetMousePos()
    local x = japi.DzGetMouseXRelative()
    local y = japi.DzGetMouseYRelative()

    local width = japi.DzGetClientWidth()
    local height = japi.DzGetClientHeight()
    return { x = x / width * 0.8, y = 0.6 - (y / height * 0.6) }
end

---设置成内部控件
---@param ui UI.UIBase
function UI.Inner(ui)
    local parent = ui:getParent()
    parent._children[ui:getName()] = nil
    table.removebyvalue(parent._children, ui)
    local frameid = parent:getFrameID()
    rawset(ui, "getParentFrameID", function(self)
        return frameid
    end)
end

---更新列表
local _updateList = {}

local function ImmMode(fn)
    fn()
end

local function DelayMode(fn)
    table.insert(_updateList, fn)
end

UI.AddUpdate = DelayMode

function UI.SetMode(mode)
    if mode == 0 then
        UI.AddUpdate = DelayMode
    else
        UI.AddUpdate = ImmMode
    end
end

if Dev.HasXMLib() then
    --内置-异步定时器
    TimerAsyn.TimerStart(TimerAsyn.CreateTimer(), 0.02, true, function()
        local updateList = _updateList
        _updateList = {}
        for index, value in ipairs(updateList) do
            value()
        end
    end)
else
    --没有内置只能这样了
    Timer.TimerStart(TimerAsyn.CreateTimer(), 0.02, true, function()
        local updateList = _updateList
        _updateList = {}
        for index, value in ipairs(updateList) do
            value()
        end
    end)
end

return UI
