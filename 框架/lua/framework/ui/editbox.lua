require "framework.ui.uibase"
local japi = require "framework.dzapi"
local WindowCallback = require "framework.window"

local _updateWindowSize

---@class UI.EditBox:UI.UIBase
---面板
UI.EditBox = Class("EditBox", UI.UIBase)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.EditBox
function UI.EditBox.new(name,parent)
    return UI.EditBox._new(name,parent)
end



---构造函数
---@param name string 控件名
---@param parent UI.UIBase 父控件
function UI.EditBox:ctor(name,parent)
    local frameid = japi.DzCreateFrameByTagName("EDITBOX", name, parent:getFrameID(), "EDITBOX_TEMPLATE", 0)
    UI.UIBase.ctor(self,name, parent, frameid)

    self._text = ""
    self._font = {size=0,style=0}
    self._align = 0
    self._maxLength = 120
    self._font_scale = 1
    japi.DzFrameSetTextSizeLimit(self:getFrameID(), self._maxLength)

    WindowCallback.AddResizeCallback(tostring(self),function (delayTime)
        _updateWindowSize(self)
    end)
    _updateWindowSize(self)
end

---设置文本
---@param text string
function UI.EditBox:setText(text)
    if self._text == text then
        return
    end
    self._text = text

    self._updateText = true
    UI.AddUpdate(function ()
        if self._updateText then
            self._updateText = false
            japi.DzFrameSetText(self:getFrameID(), self._text)
        end
    end)
end

---设置文本
---@return string
function UI.EditBox:getText() return self._text end


local function _updateFont(self)
    self._updateFont = true
    UI.AddUpdate(function ()
        if self._updateFont then
            self._updateFont = false
            japi.DzFrameSetFont(self:getFrameID(), self._font.path, self._font.size*self._font_scale, self._font.style)
        end
    end)
end


---设置字体
---@param path string 字体文件
function UI.EditBox:setFont(path)
    if self._font.path == path then
        return
    end
    self._font.path = path
    _updateFont(self)
end

---设置字体大小
---@param size number 大小 小数
function UI.EditBox:setFontSize(size)
    if self._font.size==size then
        return
    end
    self._font.size=size
    _updateFont(self)
end

---获得字体大小
---@return number
function UI.EditBox:getFontSize() return self._font.size end


---设置字体
---@param style integer 字体样式
function UI.EditBox:setFontStyle(style)
    if self._font.style==style then
        return
    end
    self._font.style=style
    _updateFont(self)
end

---获得字体样式
---@return integer
function UI.EditBox:getFontStyle() return self._font.style end


---设置对齐方式
---@param align integer
function UI.EditBox:setTextAlignment(align)
    if self._align == align then
        return
    end
    self._align = align

    self._updateAlign = true
    UI.AddUpdate(function ()
        if self._updateAlign then
            self._updateAlign = false
            
            japi.DzFrameSetTextAlignment(self:getFrameID(), self._updateAlign)
        end
    end)
end

---设置对齐方式
---@param maxLength integer 默认为50
function UI.EditBox:setMaxLength(maxLength)
    if self._maxLength == maxLength then
        return
    end
    self._maxLength = maxLength

    self._updateMaxLength = true
    UI.AddUpdate(function ()
        if self._updateMaxLength then
            self._updateMaxLength = false
            
            japi.DzFrameSetTextSizeLimit(self:getFrameID(), self._maxLength)
        end
    end)
end

---获得字体样式
---@return UI.TextAlign
function UI.EditBox:getTextAlignment() return self._font._align end

---设置顶点颜色
---@param r integer 0-255
---@param g integer 0-255
---@param b integer 0-255
---@param a integer 0-255
function UI.EditBox:setVertexColor(r, g, b, a)
end

---更新
_updateWindowSize = function(self)
    local width = japi.DzGetClientWidth()/800
    local height = japi.DzGetClientHeight()/600

    local scale = 1
    if width<height then
        scale = width/800
    else
        scale = height/600
    end
    local font_scale = (72/96/2)*scale
    if NumberEqual(self._font_scale,font_scale) then
        return
    end
    self._font_scale = font_scale

        
    _updateFont(self)
end