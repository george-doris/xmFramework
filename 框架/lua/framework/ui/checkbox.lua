require "framework.ui.backdrop"
local japi = require "framework.dzapi"

---@class UI.CheckBox:UI.Backdrop
---按钮
UI.CheckBox = Class("CheckBox", UI.Backdrop)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.CheckBox
function UI.CheckBox.new(name,parent)
    return UI.CheckBox._new(name,parent)
end

---comment
---@param self UI.CheckBox
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
                if self._checkState then
                    self._node:setTexture(self._nodeNormalImage)
                    self._node:setVisible(true)
                else
                    self._node:setVisible(false)
                end
            else
                self:setTexture(self._disableImage)
                if self._checkState then
                    self._node:setTexture(self._nodeDisableImage)
                    self._node:setVisible(true)
                else
                    self._node:setVisible(false)
                end
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
    if self._state==2 then
        self._checkState = not self._checkState
        if self._mouse_click_event then
            self._mouse_click_event(self)
        end
    end
    _updateState(self)
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
function UI.CheckBox:ctor(name, parent)
    UI.Backdrop.ctor(self, name, parent)
    self._disableImage = nil
    self._normalImage = nil
    self._pressedImage = nil
    self._nodeDisableImage = nil
    self._nodeNormalImage = nil
    self._state = 0
    self._mouse_left_down_event = nil
    self._mouse_left_up_event = nil
    self._mouse_enter_event = nil
    self._mouse_leave_event = nil
    self._checkState = false

    local node = UI.Backdrop.new("_NODE", self)
    UI.Inner(node)
    node._parentAnchorType = UI.AnchorType.CENTET
    node:setAnchorType(UI.AnchorType.CENTET)
    self._node = node

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

---设置禁用图片
---@param texture string 材质
function UI.CheckBox:setNormalImage(texture)
    if self._normalImage == texture then
        return
    end
    self._normalImage = texture
    _updateState(self)
end

---获得禁用图片
---@return string
function UI.CheckBox:getNormalImage()
    return self._normalImage
end

---设置按下图片
---@param texture string 材质
function UI.CheckBox:setPressedImage(texture)
    if self._pressedImage == texture then
        return
    end
    self._pressedImage = texture
    _updateState(self)
end

---获得按下图片
---@return string
function UI.CheckBox:getPressedImage()
    return self._pressedImage
end

---设置禁用图片
---@param texture string 材质
function UI.CheckBox:setDisableImage(texture)
    if self._disableImage == texture then
        return
    end
    self._disableImage = texture
    _updateState(self)
end

---获得禁用图片
---@return string
function UI.CheckBox:getDisableImage()
    return self._disableImage
end

---设置选中禁用图片
---@param texture string 材质
function UI.CheckBox:setNodeDisableImage(texture)
    if self._nodeDisableImage == texture then
        return
    end
    self._nodeDisableImage = texture
    _updateState(self)
end

---获得选中禁用图片
---@return string
function UI.CheckBox:getNodeDisableImage()
    return self._nodeDisableImage
end

---设置选中禁用图片
---@param texture string 材质
function UI.CheckBox:setNodeNormalImage(texture)
    if self._nodeNormalImage == texture then
        return
    end
    self._nodeNormalImage = texture
    _updateState(self)
end

---获得选中禁用图片
---@return string
function UI.CheckBox:getNodeNormalImage()
    return self._nodeNormalImage
end

---启用\禁用
---@param isEnable boolean 是否启用
function UI.CheckBox:setEnable(isEnable)
    if self._enable == isEnable then return end
    UI.UIBase.setEnable(self,isEnable)
    _updateState(self)
end

---设置选中状态
---@param state boolean 是否启用
function UI.CheckBox:setCheckState(state)
    if self._checkState == state then return end
    _updateState(self)
end

---获取选择状态
---@return boolean
function UI.CheckBox:getCheckState()
    return self._checkState
end

---设置大小
---@param width number 宽度
---@param height number 高度
function UI.CheckBox:setSize(width,height)
    UI.Backdrop.setSize(self,width,height)
    self._node:setSize(width,height)
end


---鼠标左键按下消息回调
function UI.CheckBox:SetCallback_MouseLeftDown(fn)
    self._mouse_left_down_event = fn
end

---鼠标左键抬起消息回调
function UI.CheckBox:SetCallback_MouseLeftUp(fn)
    self._mouse_left_up_event = fn
end

---鼠标单击消息回调
function UI.CheckBox:SetCallback_MouseClick(fn)
    self._mouse_click_event = fn
end