require "framework.ui.backdrop"
local japi = require "framework.dzapi"

---@class UI.Button:UI.Backdrop
---按钮
UI.Button = Class("Button", UI.Backdrop)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.Button
function UI.Button.new(name,parent)
    return UI.Button._new(name,parent)
end

---comment
---@param self UI.Button
local function _updateState(self)
    self._updateButtonState = true
    UI.AddUpdate(function ()
        if self._updateButtonState then
            self._updateButtonState = false
            if self:isEnable() then
                if self._state==3 then
                    self:setTexture(self._pressedImage)
                else
                    self:setTexture(self._normalImage)
                end
            else
                self:setTexture(self._disableImage)
            end
        end
    end)
end

local function _mouseDown(self)
    self._state = self._state | 1
    _updateState(self)
end

local function _mouseUp(self)
    self._state = self._state & (~1)
    _updateState(self)
    if self._state==2 and self._mouse_click_event then
        self._mouse_click_event(self)
    end
end

local function _mouseEnter(self)
    self._state = self._state | 2
    _updateState(self)
end

local function _mouseLeave(self)
    self._state = self._state & (~2)
    _updateState(self)
end


---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Button:ctor(name, parent)
    UI.Backdrop.ctor(self, name, parent)
    self._disableImage = nil
    self._normalImage = nil
    self._pressedImage = nil
    self._state = 0
    self._mouse_left_down_event = nil
    self._mouse_left_up_event = nil
    self._mouse_enter_event = nil
    self._mouse_leave_event = nil

    self._textUI = UI.Text.new("_TEXT",self)
    UI.Inner(self._textUI)
    self._textUI._parentAnchorType = UI.AnchorType.CENTET
    self._textUI:setAnchorType(UI.AnchorType.CENTET)
    self._textUI:setTextAlignment(UI.TextAlign.CENTER|UI.TextAlign.VCENTER)
    self._textUI:setPosition(0,0)

    UI.UIBase.SetCallback_MouseLeftDown(self,function (my)
        _mouseDown(self)
        if self._mouse_left_down_event then
            self._mouse_left_down_event(my)
        end
    end)

    UI.UIBase.SetCallback_MouseLeftUp(self,function (my)
        _mouseUp(self)
        if self._mouse_left_up_event then
            self._mouse_left_up_event(my)
        end
    end)

    UI.UIBase.SetCallback_MouseEnter(self,function (my)
        _mouseEnter(self)
        if self._mouse_enter_event then
            self._mouse_enter_event(my)
        end
    end)
    
    UI.UIBase.SetCallback_MouseLeave(self,function (my)
        _mouseLeave(self)
        if self._mouse_leave_event then
            self._mouse_leave_event(my)
        end
    end)
end

---设置缺省状态图片
---@param texture string 图片
function UI.Button:setNormalImage(texture)
    if self._normalImage == texture then
        return
    end
    self._normalImage = texture
    _updateState(self)
end

---获得缺省状态图片
---@return string
function UI.Button:getNormalImage()
    return self._normalImage
end

---设置按下状态图片
---@param texture string 图片
function UI.Button:setPressedImage(texture)
    if self._pressedImage == texture then
        return
    end
    self._pressedImage = texture
    _updateState(self)
end

---获得按下状态图片
---@return string
function UI.Button:getPressedImage()
    return self._pressedImage
end

---设置禁用状态图片
---@param texture string 图片
function UI.Button:setDisableImage(texture)
    if self._disableImage == texture then
        return
    end
    self._disableImage = texture
    _updateState(self)
end

---获得禁用状态图片
---@return string
function UI.Button:getDisableImage()
    return self._disableImage
end

---启用\禁用
---@param isEnable boolean 是否启用
function UI.Button:setEnable(isEnable)
    if self._enable == isEnable then return end
    UI.UIBase.setEnable(self,isEnable)
    _updateState(self)
end


---设置文本
---@param text string
function UI.Button:setText(text)
    self._textUI:setText(text)
end

---设置文本
---@return string
function UI.Button:getText() return self._textUI:getText() end


---设置大小
---@param width number 宽度
---@param height number 高度
function UI.Button:setSize(width,height)
    UI.Backdrop.setSize(self,width,height)
    self._textUI:setSize(width,height)
end

---设置缩放
---@param scale number 0-1
function UI.Button:setScale(scale)
    if NumberEqual(self._scale,scale) then
        return
    end
    UI.Backdrop.setScale(self,scale)
    self._textUI._scale = 0.0000001
    self._textUI:setScale(1)
end

---设置字体
---@param path string 字体文件
function UI.Button:setFont(path)
    self._textUI:setFont(path)
end

---获得字体
---@return string
function UI.Button:getFont() return self._textUI:getFont() end

---设置字体大小
---@param size number 大小 小数
function UI.Button:setFontSize(size)
    self._textUI:setFontSize(size)
end

---获得字体大小
---@return number
function UI.Button:getFontSize() return self._textUI:getFontSize() end

---鼠标左键按下消息回调
function UI.Button:SetCallback_MouseLeftDown(fn)
    self._mouse_left_down_event = fn
end

---鼠标左键抬起消息回调
function UI.Button:SetCallback_MouseLeftUp(fn)
    self._mouse_left_up_event = fn
end

---鼠标单击消息回调
function UI.Button:SetCallback_MouseClick(fn)
    self._mouse_click_event = fn
end

---鼠标进入消息回调
function UI.Button:SetCallback_MouseEnter(fn)
    self._mouse_enter_event = fn
end

---鼠标离开消息回调
function UI.Button:SetCallback_MouseLeave(fn)
    self._mouse_leave_event = fn
end

---释放
function UI.Button:destroy()
    self._textUI:destroy()
    UI.Backdrop.destroy(self)
end
