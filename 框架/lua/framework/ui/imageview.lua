require "framework.ui.backdrop"
local japi = require "framework.dzapi"

---@class UI.ImageView:UI.Backdrop
---背景
UI.ImageView = Class("ImageView", UI.Backdrop)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.ImageView
function UI.ImageView.new(name,parent)
    return UI.ImageView._new(name,parent)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.ImageView:ctor(name, parent)
    UI.Backdrop.ctor(self, name, parent)
    self._texture = nil
end
