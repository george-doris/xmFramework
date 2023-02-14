require "framework.ui.editbox"
local japi = require "framework.dzapi"

---@class UI.TextField:UI.EditBox
---编辑框
UI.TextField = Class("TextField", UI.EditBox)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.TextField
function UI.TextField.new(name,parent)
    return UI.TextField._new(name,parent)
end

---构造函数
---@param name string 控件名
---@param parent UI.UIBase 父控件
function UI.TextField:ctor(name,parent)
    UI.EditBox.ctor(self,name, parent)
end
