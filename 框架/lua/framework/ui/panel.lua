require "framework.ui.frame"
local japi = require "framework.dzapi"

---@class UI.Panel:UI.Frame
---面板
UI.Panel = Class("Panel", UI.UIBase)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@param isClip boolean 是否裁剪
---@return UI.Panel
function UI.Panel.new(name, parent, isClip)
    return UI.Panel._new(name, parent, isClip)
end

local function _mouseDown()
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Panel:ctor(name, parent, isClip)
    local frameid
    if isClip then
        frameid = japi.DzCreateFrameByTagName("FRAME", name, parent:getFrameID(), "CLIP_FRAME_TEMPLATE", 0)
    else
        frameid = japi.DzCreateFrameByTagName("FRAME", name, parent:getFrameID(), "FRAME_TEMPLATE", 0)
    end
    UI.UIBase.ctor(self, name, parent, frameid)

    self._textureSize = { width = 0, height = 0 }
    self._scale9 = nil

    local background = UI.Backdrop.new("_BACKGROUND", self)
    UI.Inner(background)
    background:setAnchorType(UI.AnchorType.CENTET)
    background._parentAnchorType = UI.AnchorType.CENTET
    background:setPosition(0, 0)
    background:setVisible(false)
    self._background = background

    self._leftEdge = nil
    self._rightEdge = nil
    self._topEdge = nil
    self._bottomEdge = nil
    self._leftTopEdge = nil
    self._rightTopEdge = nil
    self._leftBottomEdge = nil
    self._rightBottomEdge = nil

    self:SetCallback_MouseLeftDown(_mouseDown)
end

local function _updateSize(self)
    self._updateSize = true
    UI.AddUpdate(function()
        if self._updateSize then
            self._updateSize = false
            japi.DzFrameSetSize(self:getFrameID(), self._width, self._height)

            --设置事件窗口大小
            local event = self._event
            if event then japi.DzFrameSetSize(event.frameid, self._width, self._height) end
        end
    end)
    local scale9 = self._scale9
    if scale9 ~= nil then
        self._background:setSize(self._width - scale9.left.width - scale9.right.width,
            self._height - scale9.top.height - scale9.bottom.height)
        --左边
        local background = self._leftEdge
        background:setSize(scale9.left.width,
            self._height - scale9.top.height - scale9.bottom.height)
        --右边
        background = self._rightEdge
        background:setSize(scale9.right.width,
            self._height - scale9.top.height - scale9.bottom.height)
        --右边
        background = self._topEdge
        background:setSize(self._width - scale9.left.width - scale9.right.width,
            scale9.top.height)
        --下边
        background = self._bottomEdge
        background:setSize(self._width - scale9.left.width - scale9.right.width,
            scale9.bottom.height)
        --左上
        local background = self._leftTopEdge
        background:setSize(scale9.left.width, scale9.top.height)
        --右上
        local background = self._rightTopEdge
        background:setSize(scale9.right.width, scale9.top.height)
        --左下
        local background = self._leftBottomEdge
        background:setSize(scale9.left.width, scale9.bottom.height)
        --右下
        local background = self._rightBottomEdge
        background:setSize(scale9.right.width, scale9.bottom.height)
    end
end

---设置大小
---@param width number 宽度
---@param height number 高度
function UI.Panel:setSize(width, height)
    if self._width == width and self._height == height then return end
    self._width = width
    self._height = height

    _updateSize(self)
end

---设置缩放
---@param scale number 0-1
function UI.Panel:setScale(scale)
    -- if NumberEqual(self._scale,scale) then
    --     return
    -- end
    UI.UIBase.setScale(self, scale)
    self._background._scale = 0.0000001
    self._background:setScale(1)
end

local function _updateBackground(self)
    if self._background._texture == nil then
        return
    end
    self._updateTextureSize = true
    UI.AddUpdate(function()
        if self._updateTextureSize then
            self._updateTextureSize = false

            local scale9 = self._scale9
            if scale9 == nil then
                if self._background._texture == nil then
                    return
                end
                if self._scale9 then
                    self._background:setSize(self._width, self._height)
                else
                    self._background:setSize(self._textureSize.width, self._textureSize.height)
                end
            else
                --9宫格
            end
        end
    end)
end

---设置背景
---@param texture string 背景
function UI.Panel:setTexture(texture)
    if self._background._texture == texture then
        return
    end
    self._background:setTexture(texture, 0)
    if texture then
        self._background:setVisible(true)
    else
        self._background:setVisible(false)
    end
    --_updateBackground(self)
end

function UI.Panel:setTextureSize(width, height)
    if self._textureSize.width == width and self._textureSize.height == height then
        return
    end
    self._textureSize = { width = width, height = height }
    --_updateBackground(self)
end

function UI.Panel:setScale9(scale9)
    self._scale9 = scale9

    if scale9 then
        if self._leftEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.LEFT)
            background._parentAnchorType = UI.AnchorType.LEFT
            background:setPosition(0, 0)
            if scale9.left then
                background:setTexture(scale9.left.image, 0)
            else
                background:setVisible(false)
            end
            self._leftEdge = background
        end

        if self._rightEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.RIGHT)
            background._parentAnchorType = UI.AnchorType.RIGHT
            background:setPosition(0, 0)
            if scale9.right then
                background:setTexture(scale9.right.image, 0)
            else
                background:setVisible(false)
            end
            self._rightEdge = background
        end

        if self._topEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.TOP)
            background._parentAnchorType = UI.AnchorType.TOP
            background:setPosition(0, 0)
            if scale9.top then
                background:setTexture(scale9.top.image, 0)
            else
                background:setVisible(false)
            end
            self._topEdge = background
        end

        if self._bottomEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.BOTTOM)
            background._parentAnchorType = UI.AnchorType.BOTTOM
            background:setPosition(0, 0)
            if scale9.bottom then
                background:setTexture(scale9.bottom.image, 0)
            else
                background:setVisible(false)
            end
            self._bottomEdge = background
        end

        if self._leftTopEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.LEFT_TOP)
            background._parentAnchorType = UI.AnchorType.LEFT_TOP
            background:setPosition(0, 0)
            if scale9.leftTop then
                background:setTexture(scale9.leftTop.image, 0)
            else
                background:setVisible(false)
            end
            self._leftTopEdge = background
        end

        if self._rightTopEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.RIGHT_TOP)
            background._parentAnchorType = UI.AnchorType.RIGHT_TOP
            background:setPosition(0, 0)
            if scale9.rightTop then
                background:setTexture(scale9.rightTop.image, 0)
            else
                background:setVisible(false)
            end
            self._rightTopEdge = background
        end

        if self._leftBottomEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.LEFT_BOTTOM)
            background._parentAnchorType = UI.AnchorType.LEFT_BOTTOM
            background:setPosition(0, 0)
            if scale9.leftBottom then
                background:setTexture(scale9.leftBottom.image, 0)
            else
                background:setVisible(false)
            end
            self._leftBottomEdge = background
        end

        if self._rightBottomEdge == nil then
            local background = UI.Backdrop.new("_BACKGROUND", self)
            UI.Inner(background)
            background:setAnchorType(UI.AnchorType.RIGHT_BOTTOM)
            background._parentAnchorType = UI.AnchorType.RIGHT_BOTTOM
            background:setPosition(0, 0)
            if scale9.rightBottom then
                background:setTexture(scale9.rightBottom.image, 0)
            else
                background:setVisible(false)
            end
            self._rightBottomEdge = background
        end
    else
        self._leftEdge:setVisible(false)
        self._rightEdge:setVisible(false)
        self._topEdge:setVisible(false)
        self._bottomEdge:setVisible(false)
        self._leftTopEdge:setVisible(false)
        self._rightTopEdge:setVisible(false)
        self._leftBottomEdge:setVisible(false)
        self._rightBottomEdge:setVisible(false)
    end

    --_updateBackground(self)
    _updateSize(self)
end

function UI.Panel:getTexture(texture)
    return self._background:getTexture()
end

---释放
function UI.Panel:destroy()
    if self._background then
        self._background:destroy()
    end

    if self._leftEdge then
        self._leftEdge:destroy()
    end
    if self._rightEdge then
        self._rightEdge:destroy()
    end
    if self._topEdge then
        self._topEdge:destroy()
    end
    if self._bottomEdge then
        self._bottomEdge:destroy()
    end
    if self._leftTopEdge then
        self._leftTopEdge:destroy()
    end
    if self._rightTopEdge then
        self._rightTopEdge:destroy()
    end
    if self._leftBottomEdge then
        self._leftBottomEdge:destroy()
    end
    if self._rightBottomEdge then
        self._rightBottomEdge:destroy()
    end

    UI.UIBase.destroy(self)
end
