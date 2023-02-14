require "framework.ui.uibase"
local japi = require "framework.dzapi"

---@class UI.ClipFrame:UI.UIBase
---面板
UI.ClipFrame = Class("ClipFrame", UI.UIBase)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.ClipFrame
function UI.ClipFrame.new(name,parent)
    return UI.ClipFrame._new(name,parent)
end

---构造函数
---@param name string 控件名
---@param parent UI.UIBase 父控件
function UI.ClipFrame:ctor(name,parent)
    local frameid = japi.DzCreateFrameByTagName("FRAME", name, parent:getFrameID(), "CLIP_FRAME_TEMPLATE", 0)
    UI.UIBase.ctor(self,name, parent, frameid)
end
