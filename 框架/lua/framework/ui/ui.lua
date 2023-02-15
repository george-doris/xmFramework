local japi = require "framework.dzapi"
local Serialize = require "framework.serialize"
local GameUI = require "framework.ui.game_ui"
local UIParser = require "framework.ui.uiparser"
local UpdateCallback = require "framework.update_callback"



function UI.LoadScene(filename)
    local f = io.open(filename, "r")
    local buffer = f:read("a")
    f:close()
    local data = Serialize.unSerialize(buffer)
    UIParser.LoadChildren(data.children,GameUI)
    if data.userData  then
        require(data.userData)
    end
end

---获得鼠标在窗口位置
---@return table
function UI.GetMousePos()
    local x = japi.DzGetMouseXRelative()
    local y = japi.DzGetMouseYRelative()

    local width = japi.DzGetClientWidth()
    local height = japi.DzGetClientHeight()
    return {x = x / width, y = y / height}
end

---设置成内部控件
---@param ui UI.UIBase
function UI.Inner(ui)
    local parent = ui:getParent()
    parent._children[ui:getName()] = nil
    table.removebyvalue(parent._children,ui)
    local frameid = parent:getFrameID()
    rawset(ui,"getParentFrameID", function (self)
        return frameid
    end)
end

---更新列表
local _updateList = {}
function UI.AddUpdate(fn)
   fn() --调试用
   --table.insert(_updateList,fn)
end

UpdateCallback.AddUpdateCallback("UIUpdate",function (delayTime)
    local updateList = _updateList
    _updateList = {}
    for index, value in ipairs(updateList) do
        value(delayTime)
    end
end)

return UI