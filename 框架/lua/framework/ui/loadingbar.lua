require "framework.ui.clip_frame"
require "framework.ui.frame"
require "framework.ui.backdrop"
require "framework.ui.panel"
local japi = require "framework.dzapi"

---@class UI.LoadingBar:UI.Frame
---背景
UI.LoadingBar = Class("LoadingBar", UI.Frame)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.LoadingBar
function UI.LoadingBar.new(name,parent)
    return UI.LoadingBar._new(name,parent)
end

local function _updateProgressBar(self)
    self._updateProgressBar = true
    UI.AddUpdate(function ()
        if self._updateProgressBar then
            self._updateProgressBar = false
            if self._direction == UI.Direction.HORIZONTAL then
                local width = self._width*self._value
                if width<=0 then
                    width = 0.0000001
                end
                self._clipFrame:setSize(width, self._height)
            else
                local height = self._height*self._value
                if height<=0 then
                    height = 0.0000001
                end
                self._clipFrame:setSize(self._width, height)
            end
        end
    end)
end

local function _mouseDown()
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.LoadingBar:ctor(name, parent)
    UI.Frame.ctor(self, name, parent)
    
    self._direction = UI.Direction.HORIZONTAL
    self._value = 0

    local clipFrame = UI.ClipFrame.new("_CLIPFRAME",self)
    UI.Inner(clipFrame)
    clipFrame:setAnchorType(UI.AnchorType.LEFT_BOTTOM)
    clipFrame:setPosition(0,0)
    clipFrame:setVisible(false)
    self._clipFrame = clipFrame

    local progressBar = UI.Backdrop.new("_PROGRESSBAR",self._clipFrame)
    UI.Inner(progressBar)
    progressBar:setAnchorType(UI.AnchorType.LEFT_BOTTOM)
    progressBar:setPosition(0,0)
    self._progressBar = progressBar

    self:SetCallback_MouseLeftDown(_mouseDown)
end

---设置大小
---@param width number 宽度
---@param height number 高度
function UI.LoadingBar:setSize(width,height)
    if self._width == width and self._height == height then return end
    self._width = width
    self._height = height

    self._updateSize = true
    UI.AddUpdate(function ()
        if self._updateSize then
            self._updateSize = false
            japi.DzFrameSetSize(self:getFrameID(), self._width, self._height)
            self._progressBar:setSize(self._width, self._height)

            --设置事件窗口大小
            local event = self._event
            if event then japi.DzFrameSetSize(event.frameid, self._width, self._height) end
        end
    end)
    _updateProgressBar(self)
end

---设置缩放
---@param scale number 0-1
function UI.LoadingBar:setScale(scale)
    if NumberEqual(self._scale,scale) then
        return
    end
    UI.Frame.setScale(self,scale)
    self._progressBar._scale = 0.0000001
    self._progressBar:setScale(1)
    self._clipFrame._scale = 0.0000001
    self._clipFrame:setScale(1)
end

---设置材质
---@param texture string 材质
function UI.LoadingBar:setTexture(texture)
    if self._progressBar._texture==texture then
        return
    end
    self._progressBar:setTexture(texture,0)
    self._updateClipFrame = true
    UI.AddUpdate(function ()
        if self._updateClipFrame then
            self._updateClipFrame = false
            if self._progressBar._texture~=nil and self._progressBar._texture~="" then
                self._clipFrame:setVisible(true)
            else
                self._clipFrame:setVisible(false)
            end
        end
    end)
end

---设置材质
---@return string 材质
function UI.LoadingBar:getTexture()
    return self._progressBar:getTexture()
end

---设置值
---@param value number 0-1
function UI.LoadingBar:setValue(value)
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
function UI.LoadingBar:getValue()
    return self._value
end

---设置方向
---@param direction UI.Direction
function UI.LoadingBar:setDirection(direction)
    self._direction = direction
    if direction==UI.Direction.HORIZONTAL then
        self._clipFrame._parentAnchorType = UI.AnchorType.LEFT_BOTTOM
        self._clipFrame:setAnchorType(UI.AnchorType.LEFT_BOTTOM)
        self._progressBar._parentAnchorType = UI.AnchorType.LEFT_BOTTOM
        self._progressBar:setAnchorType(UI.AnchorType.LEFT_BOTTOM)
    else
        self._clipFrame._parentAnchorType = UI.AnchorType.LEFT_TOP
        self._clipFrame:setAnchorType(UI.AnchorType.LEFT_TOP)
        self._progressBar._parentAnchorType = UI.AnchorType.LEFT_TOP
        self._progressBar:setAnchorType(UI.AnchorType.LEFT_TOP)
    end
end

---释放
function UI.LoadingBar:destroy()
    self._progressBar:destroy()
    self._clipFrame:destroy()
    UI.Frame.destroy(self)
end