require "framework.ui.uibase"
local japi = require "framework.dzapi"

---@class UI.Backdrop:UI.UIBase
---背景
UI.Backdrop = Class("Backdrop", UI.UIBase)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.Backdrop
function UI.Backdrop.new(name,parent)
    return UI.Backdrop._new(name,parent)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Backdrop:ctor(name, parent)
    local frameid = japi.DzCreateFrameByTagName("BACKDROP", name, parent:getFrameID(), "", 0)
    UI.UIBase.ctor(self, name, parent, frameid)
    self._texture = nil
    self._textureFlag = 0
end


---设置图片
---@param texture string 图片
---@param flag UI.TextFlag|nil 
function UI.Backdrop:setTexture(texture, flag)
    if self._texture == texture and self._textureFlag == flag then
        return
    end
    self._textureFlag = flag or 0
    self._texture = texture

    self._updateTexture = true
    UI.AddUpdate(function ()
        if self._updateTexture then
            self._updateTexture = false
            japi.DzFrameSetTexture(self:getFrameID(), self._texture, self._textureFlag)
        end
    end)
end

---获得图片
---@return string
function UI.Backdrop:getTexture()
    return self._texture
end