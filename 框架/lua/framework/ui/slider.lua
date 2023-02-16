require "framework.ui.loadingbar"
local japi = require "framework.dzapi"

---@class UI.Slider:UI.Backdrop
---背景
UI.Slider = Class("Slider", UI.Backdrop)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.Slider
function UI.Slider.new(name,parent)
    return UI.Slider._new(name,parent)
end

local function _mouseDown(self)
    self._sliderState = 1
    self._old_value = self:getValue()
    self._mouse_pos = UI.GetMousePos()
end
local function _mouseUp(self)
    self._sliderState = 0
end
local function _mouseMove(self)
    if self._sliderState == 1 then
        local pos = UI.GetMousePos()
        --这里判断是否超过区域
        -- if math.abs(pos.x - self._mouse_pos.x) >
        --     (self:GetWidth() / 2 + 0.03) then
        --     self:SetValue(self._old_value)
        --     return
        -- end
        local scale = self:getWorldScale()
        local value
        local slider = self._slider
        if self._direction==UI.Direction.HORIZONTAL then
            local x = pos.x - self._mouse_pos.x
            value = self._old_value + x*slider._factor/scale
        else
            local y = pos.y - self._mouse_pos.y
            value = self._old_value + y*slider._factor/scale
        end
        if self._value ==value then
            return
        end
        self:setValue(value)
        if self._onValueCallback then
            self._onValueCallback(self,value)
        end
    end
end

-- 计算滑块区域
local function _calc_slider_region(self)
    local slider = self._slider
    if self._direction==UI.Direction.HORIZONTAL then
        local width = self:getWidth()-- - slider:getWidth()
        slider._factor = 0.8 / (width)
    else
        local height = self:getHeight()
        slider._factor = 0.6 / (height)
    end
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Slider:ctor(name, parent)
    UI.Backdrop.ctor(self, name, parent)
    
    self._sliderState = 0
    self._old_value = 0
    self._mouse_pos = nil
    self._value = 0
    self._factor = 0
    self._direction = UI.Direction.HORIZONTAL
    self._onValueCallback = nil

    local progressBar = UI.LoadingBar.new("_PROGRESSBAR",self)
    UI.Inner(progressBar)
    progressBar:setAnchorType(UI.AnchorType.LEFT_BOTTOM)
    progressBar:setPosition(0,0)
    self._progressBar = progressBar

    local slider = UI.Button.new("_CHUNK",self)
    UI.Inner(slider)
    slider:SetCallback_MouseLeftDown(function () _mouseDown(self) end)
    slider:SetCallback_MouseLeftUp(function () _mouseUp(self) end )
    slider:SetCallback_MouseMove(function () _mouseMove(self) end )
    slider:setEnable(true)
    slider._parentAnchorType = UI.AnchorType.CENTET
    slider:setAnchorType(UI.AnchorType.CENTET)
    self._slider = slider

    self:setValue(0)
    --_calc_slider_region(self)
end

local function _updateProgressBar(self)
    self._updateProgressBar = true
    UI.AddUpdate(function ()
        if self._updateProgressBar then
            self._updateProgressBar = false
            if self._direction==UI.Direction.HORIZONTAL then
                self._slider:setPosition(self._width*self._value-self._width/2, 0)
            else
                self._slider:setPosition(0, self._height/2-self._height*self._value)
            end
            self._progressBar:setValue(self._value)
        end
    end)
end

local function _updateSize(self)
    self._updateSize = true
    UI.AddUpdate(function ()
        if self._updateSize then
            self._updateSize = false
            japi.DzFrameSetSize(self:getFrameID(), self._width, self._height)
            self._progressBar:setSize(self._width, self._height)
            local w
            if self._width<self._height then
                w = self._width
            else
                w = self._height
            end
            self._slider:setSize(w,w)
            _calc_slider_region(self)
            --设置事件窗口大小
            local event = self._event
            if event then japi.DzFrameSetSize(event.frameid, self._width, self._height) end
        end
    end)
    _updateProgressBar(self)
end

---设置大小
---@param width number 宽度
---@param height number 高度
function UI.Slider:setSize(width,height)
    if self._width == width and self._height == height then return end
    self._width = width
    self._height = height

    _updateSize(self)
end

---设置缩放
---@param scale number 0-1
function UI.Slider:setScale(scale)
    if NumberEqual(self._scale,scale) then
        return
    end
    UI.Backdrop.setScale(self,scale)

    self._progressBar._scale = 0.0000001
    self._progressBar:setScale(1)
    self._slider._scale = 0.0000001
    self._slider:setScale(1)
end

---设置值
---@param value number 0-100
function UI.Slider:setValue(value)
    if self._value ==value then
        return
    end
    if value<0 then
        value = 0
    elseif value>1 then
        value = 1
    end
    self._value = value
    _updateProgressBar(self)
end

---获取值
function UI.Slider:getValue()
    return self._value
end

---设置材质
---@param texture string 材质
function UI.Slider:setProgressBarImage(texture)
    self._progressBar:setTexture(texture)
end

---按钮禁用图片
---@param texture string 材质
function UI.Slider:setButtonDisabled(texture)
    self._slider:setDisableImage(texture)
end

---按钮图片
---@param texture string 材质
function UI.Slider:setButtonNormal(texture)
    self._slider:setNormalImage(texture)
end

---按钮按下图片
---@param texture string 材质
function UI.Slider:setButtonPressed(texture)
    self._slider:setPressedImage(texture)
end

---值改变回调
---@param fn function 2个参数:第一个位触发的Slider,第二个位值
function UI.Slider:setCallback_OnValue(fn)
    self._onValueCallback = fn
end

---设置方向
---@param direction UI.Direction
function UI.Slider:setDirection(direction)
    self._direction = direction
    self._progressBar:setDirection(direction)
    _updateSize(self)
end

---释放
function UI.Slider:destroy()
    self._slider:destroy()
    self._progressBar:destroy()
    UI.Backdrop.destroy(self)
end