require "framework.ui.frame"
local japi = require "framework.dzapi"

---@class UI.Panel:UI.Frame
---面板
UI.Panel = Class("Panel", UI.Frame)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@param isClip boolean 是否裁剪
---@return UI.Panel
function UI.Panel.new(name,parent,isClip)
    return UI.Panel._new(name,parent,isClip)
end

local function _mouseDown()
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Panel:ctor(name, parent,isClip)
    local frameid
    if isClip then
        frameid = japi.DzCreateFrameByTagName("FRAME", name, parent:getFrameID(), "CLIP_FRAME_TEMPLATE", 0)
    else
        frameid = japi.DzCreateFrameByTagName("FRAME", name, parent:getFrameID(), "FRAME_TEMPLATE", 0)
    end
    UI.UIBase.ctor(self,name, parent, frameid)

    self._background = UI.Backdrop.new("_BACKGROUND",self)
    UI.Inner(self._background)
    self._background:setAnchorType(UI.AnchorType.CENTET)
    self._background._parentAnchorType = UI.AnchorType.CENTET
    self._background:setPosition(0,0)
    self._background:setVisible(false)

    self._textureSize = {width=0,height=0}
    self._scale9 = false
    self:SetCallback_MouseLeftDown(_mouseDown)
end

---设置大小
---@param width number 宽度
---@param height number 高度
function UI.Panel:setSize(width,height)
    if self._width == width and self._height == height then return end
    self._width = width
    self._height = height

    self._updateSize = true
    UI.AddUpdate(function ()
        if self._updateSize then
            self._updateSize = false
            japi.DzFrameSetSize(self:getFrameID(), self._width, self._height)
            self._background:setSize(self._width, self._height)

            --设置事件窗口大小
            local event = self._event
            if event then japi.DzFrameSetSize(event.frameid, self._width, self._height) end
        end
    end)
end

local function _updateBackground(self)
    if self._background._texture==nil then
        return
    end
    self._updateTextureSize = true
    UI.AddUpdate(function ()
        if self._updateTextureSize then
            self._updateTextureSize = false
        
            if self._background._texture==nil then
                return
            end
            if self._scale9 then
                self._background:setSize(self._width,self._height)
            else
                self._background:setSize(self._textureSize.width,self._textureSize.height)
            end
        end
    end)
end

---设置背景
---@param texture string 背景
function UI.Panel:setTexture(texture)
    if self._background._texture==texture then
        return
    end
    self._background:setTexture(texture,0)
    if texture then
        self._background:setVisible(true)
    else
        self._background:setVisible(false)
    end
    _updateBackground(self)
end

function UI.Panel:setTextureSize(width,height)
    if self._textureSize.width == width and self._textureSize.height == height then
        return
    end
    self._textureSize = {width=width,height=height}
    _updateBackground(self)
end

function UI.Panel:setScale9(v)
    if self._scale9==v then
        return
    end
    self._scale9 = v
    _updateBackground(self)
end

function UI.Panel:getTexture(texture)
    return self._background:getTexture()
end

---释放
function UI.Panel:destroy()
    if self._background then
        self._background:destroy()
    end
    UI.Frame.destroy(self)
end