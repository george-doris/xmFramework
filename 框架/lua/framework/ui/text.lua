require "framework.ui.uibase"
local japi = require "framework.dzapi"
local UTF8 = require "framework.utf8"
local WindowCallback = require "framework.window"

---@class UI.Text:UI.Backdrop
---背景
UI.Text = Class("Text", UI.UIBase)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.Text
function UI.Text.new(name, parent)
    return UI.Text._new(name, parent)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Text:ctor(name, parent)
    local frameid = japi.DzCreateFrameByTagName("TEXT", name,
        parent:getFrameID(), "", 0)
    UI.UIBase.ctor(self, name, parent, frameid)
    self._text = ""
    self._font = { path="", size = 0, style = 0 }
    self._align = 0
    self._outlineEnabled = false
    self._shadow = nil
    self._shadowEnabled = false
    self._shadowColor = { r = 0, g = 0, b = 0, a = 0 }
    self._font_scale = 1
    self._autoSize = false

    -- japi.DzFrameSetEnable(frameid, false)
    -- WindowCallback.AddResizeCallback(tostring(self),function (delayTime)
    --     self:UpdateSize(delayTime)
    -- end)
end

local function _updateShadowText(self)
    self._updateShadowText = true
    UI.AddUpdate(function()
        if self._updateShadowText then
            self._updateShadowText = false
            if self._shadow == nil then return end
            japi.DzFrameSetText(self._shadow,
                UI.SetTextColor(UI.ClearTextColor(self._text),
                    self._shadowColor.r, self._shadowColor.g, self._shadowColor.b, self._shadowColor.a))
        end
    end)
end

---comment
function UI.Text:refreshAutoSize()
    self._updateAutoSize = true
    UI.AddUpdate(function()
        if self._updateAutoSize then
            self._updateAutoSize = false
            local width
            if self._autoSize==false then
                width = self:getWidth()
            end
            self:AutoSize(width)
        end
    end)
end


function UI.Text:setAutoSize(b)
    if self._autoSize == b then
        return
    end
    self._autoSize = b

    self:refreshAutoSize()
end

---设置文本
---@param text string
function UI.Text:setText(text)
    if self._text == text then
        return
    end
    self._text = text

    self._updateText = true
    UI.AddUpdate(function()
        if self._updateText then
            self._updateText = false
            japi.DzFrameSetText(self:getFrameID(), self._text)
        end
    end)
    
    if self._autoSize then
        self:refreshAutoSize()
    end
    _updateShadowText(self)
end

---设置文本
---@return string
function UI.Text:getText() return self._text end

local function _updateFont(self)
    self._updateFont = true
    UI.AddUpdate(function()
        if self._updateFont then
            self._updateFont = false

            local width = japi.DzGetClientWidth() / 800
            local height = japi.DzGetClientHeight() / 800

            local scale = 1
            if width < height then
                scale = width / 800
            else
                scale = height / 600
            end
            local font_scale = (72 / 96) * (self._font.size * scale)
            font_scale = math.floor(font_scale * 100) * 0.01
            self._font_scale = font_scale
            if font_scale<0.001 then
                return
            end

            japi.DzFrameSetFont(self:getFrameID(), self._font.path, self._font_scale * self:getWorldScale(),
            self._font.style)
            if self._shadow == nil then return end
            japi.DzFrameSetFont(self._shadow, self._font.path, self._font_scale * self:getWorldScale(), 0)
        end
    end)
end


---设置大小
---@param width number 宽度
---@param height number 高度
function UI.Text:setSize(width, height)
    if self._width == width and self._height == height then return end
    UI.UIBase.setSize(self, width, height)
    _updateFont(self)
    if self._shadow == nil then return end

    self._updateShadowSize = true
    UI.AddUpdate(function()
        if self._updateShadowSize then
            self._updateShadowSize = false
            japi.DzFrameSetSize(self._shadow, self._width, self._height)
        end
    end)
end

---设置透明度
---@param alpha integer 透明度0-255
function UI.Text:setAlpha(alpha)
    if self._alpha == alpha then
        return
    end
    UI.UIBase.setAlpha(self, alpha)
    if self._shadow == nil then return end
    self._updateShadowAlpha = true
    UI.AddUpdate(function()
        if self._updateShadowAlpha then
            self._updateShadowAlpha = false
            japi.DzFrameSetAlpha(self._shadow, self._alpha)
        end
    end)
end

---设置缩放
---@param scale number 0-1
function UI.Text:setScale(scale)
    -- if NumberEqual(self._scale,scale) then
    --     return
    -- end
    UI.UIBase.setScale(self, scale)
    _updateFont(self)
    if self._shadow == nil then return end
    self._updateShadowScale = true
    UI.AddUpdate(function()
        if self._updateShadowScale then
            self._updateShadowScale = false
            japi.DzFrameSetScale(self._shadow, self:getWorldScale())
        end
    end)
end

---显示\隐藏
---@param isShow boolean 是否显示
function UI.Text:setVisible(isShow)
    if self._visible == isShow then return end
    UI.UIBase.setVisible(self, isShow)
    if self._shadow == nil then return end
    self._updateShadowVisible = true
    UI.AddUpdate(function()
        if self._updateShadowVisible then
            self._updateShadowVisible = false
            japi.DzFrameShow(self._shadow, self._visible)
        end
    end)
end

---设置位置
---@param anchorType UI.AnchorType 描点
function UI.Text:setAnchorType(anchorType)
    if self._anchorType == anchorType then
        return
    end
    UI.UIBase.setAnchorType(self, anchorType)
    if self._shadow == nil then return end
    self._updateShadowPos = true
    UI.AddUpdate(function()
        if self._updateShadowPos then
            self._updateShadowPos = false
            japi.DzFrameClearAllPoints(self._shadow)
            local offset = self:getParentOffset()
            japi.DzFrameSetPoint(self._shadow, self._anchorType, self:getParentFrameID(),
                UI.AnchorType.LEFT_BOTTOM, self._x + offset.x, self._y + offset.y)
        end
    end)
end

---设置位置
---@param x number x坐标
---@param y number y坐标
function UI.Text:setPosition(x, y)
    if self._x == x and self._y == y then
        return
    end
    UI.UIBase.setPosition(self, x, y)
    if self._shadow == nil then return end
    self._updateShadowPos = true
    UI.AddUpdate(function()
        if self._updateShadowPos then
            self._updateShadowPos = false
            japi.DzFrameClearAllPoints(self._shadow)
            local offset = self:getParentOffset()
            japi.DzFrameSetPoint(self._shadow, self._anchorType, self:getParentFrameID(),
                UI.AnchorType.LEFT_BOTTOM, self._x + offset.x, self._y + offset.y)
        end
    end)
end

---设置顶点颜色
---@param r integer 0-255
---@param g integer 0-255
---@param b integer 0-255
---@param a integer 0-255
function UI.Text:setVertexColor(r, g, b, a)
end

-- ---设置文本颜色
-- ---@param r integer 红色 0-255
-- ---@param g integer 绿色 0-255
-- ---@param b integer 蓝色 0-255
-- ---@param a integer 透明度 0-255
-- function UI.Text:setTextColor(r,g,b,a)
--     self._textColor = {r=r,g=g,b=b,a=a}
--     _updateText(self)
-- end

-- ---设置文本
-- ---@return string
-- function UI.Text:getTextColor() return self._textColor end


local function _updateShadow(self)
    local shadow = self._shadow
    if self._shadowEnabled then
        if shadow == nil then
            shadow = japi.DzCreateFrameByTagName("TEXT", "_SHADOW", self:getParentFrameID(), "", 0)
            japi.DzFrameSetPriority(shadow, 1)
            japi.DzFrameSetPriority(self:getFrameID(), 2)
            self._shadow = shadow
            japi.DzFrameSetEnable(self._shadow, false)
        end

        japi.DzFrameSetSize(self._shadow, self._width, self._height)
        japi.DzFrameSetAlpha(self._shadow, self._alpha)
        japi.DzFrameSetScale(self._shadow, self.getWorldScale())
        japi.DzFrameShow(self._shadow, self._visible)
        local offset = self:getParentOffset()
        japi.DzFrameSetPoint(self._shadow, self._anchorType, self:getParentFrameID(),
            UI.AnchorType.LEFT_BOTTOM, self._x + self._shadowOffset.x + offset.x, self._y + self._shadowOffset.y +
            offset.y)


        japi.DzFrameSetText(self._shadow,
        UI.SetTextColor(UI.ClearTextColor(self._text), self._shadowColor.r, self._shadowColor.g, self._shadowColor.b,
        self._shadowColor.a))
        japi.DzFrameSetTextAlignment(self._shadow, self._align)
        japi.DzFrameSetFont(self._shadow, self._font.path, self._font.size * self._font_scale, 0)
    else
        if shadow then
            japi.DzDestroyFrame(self._shadow)
            self._shadow = nil
        end
    end
end

---设置字体
---@param path string 字体文件
function UI.Text:setFont(path)
    if self._font.path == path then
        return
    end
    self._font.path = path
    _updateFont(self)
end

---获得字体
---@return string
function UI.Text:getFont() return self._font.path end

---设置字体大小
---@param size number 大小 小数
function UI.Text:setFontSize(size)
    if self._font.size == size then
        return
    end
    self._font.size = size
    _updateFont(self)
end

---获得字体大小
---@return number
function UI.Text:getFontSize() return self._font.size end

---设置字体
---@param style integer 字体样式
function UI.Text:setFontStyle(style)
    if self._font.style == style then
        return
    end
    self._font.style = style
    _updateFont(self)
end

---获得字体样式
---@return integer
function UI.Text:getFontStyle() return self._font.style end

function UI.Text:setOutlineEnabled(isEnable)
    self._outlineEnabled = isEnable
end

function UI.Text:isOutlineEnabled()
    return self._outlineEnabled
end

---设置对齐方式
---@param align integer
function UI.Text:setTextAlignment(align)
    if self._align == align then
        return
    end
    self._align = align
    self._updateAlign = true
    UI.AddUpdate(function()
        if self._updateAlign then
            self._updateAlign = false

            japi.DzFrameSetTextAlignment(self:getFrameID(), self._align)
            if self._shadow == nil then return end
            japi.DzFrameSetTextAlignment(self._shadow, self._align)
        end
    end)
end

---获得字体样式
---@return UI.TextAlign
function UI.Text:getTextAlignment() return self._font._align end

local _font_size_com
---comment
---@param str string 内容
---@param font string 字体
function UI.Text.GetStringExtent(str, font, h, flag)
    if _font_size_com == nil then
        _font_size_com = japi.DzCreateFrameByTagName("TEXT", "_font_size_com",
            japi.DzGetGameUI(), "", 0)
        japi.DzFrameSetEnable(_font_size_com, false)
        japi.DzFrameShow(_font_size_com, false)
    end
    japi.DzFrameSetFont(_font_size_com, font, h, flag)
    local t = UTF8.utf8toarray(str)
    local width = 0
    local height = 0
    local line_width = 0
    for index, line in ipairs(t) do
        for index1, value in ipairs(line) do
            japi.DzFrameSetText(_font_size_com, value)
            line_width = line_width + japi.XMFrameGetTextWidth(_font_size_com)
        end
        if line_width > 0 then
            if line_width > width then width = line_width end
            height = height + japi.XMFrameGetTextHeight(_font_size_com)
            line_width = 0
        end
    end
    return width+0.005, height
end

local function _addUpdate(fn)
    fn()
end

---根据内容自动调整大小(需要内置)
---@param max_width number 限制宽度
function UI.Text:AutoSize(max_width)
    if max_width == nil then
        local width, height = UI.Text.GetStringExtent(self:getText(),
            self:getFont(), self._font_scale * self:getWorldScale(), self:getFontStyle())
        self:setSize(width, height)
        return
    end

    local addUpdate = UI.AddUpdate
    UI.AddUpdate = _addUpdate
    
    self:setSize(max_width, 0)
    self:setSize(max_width, japi.XMFrameGetTextHeight(self:getFrameID()))

    UI.AddUpdate = addUpdate
end

function UI.Text:setShadowEnabled(isEnable)
    if self._shadowEnabled == isEnable then
        return
    end
    self._shadowEnabled = isEnable

    self._updateShadow = true
    UI.AddUpdate(function()
        if self._updateShadow then
            self._updateShadow = false
            _updateShadow(self)
        end
    end)
end

function UI.Text:isShadowEnabled()
    return self._shadowEnabled
end

---设置影子颜色
---@param r integer 红色 0-255
---@param g integer 绿色 0-255
---@param b integer 蓝色 0-255
---@param a integer 透明度 0-255
function UI.Text:setShadowColor(r, g, b, a)
    self._shadowColor = { r = r, g = g, b = b, a = a }

    _updateShadowText(self)
end

---设置影子文本
---@return table
function UI.Text:getShadowColor()
    return self._shadowColor
end

---设置影子偏移
---@param x number
---@param y number
function UI.Text:setShadowOffset(x, y)
    self._shadowOffset = { x = x, y = y }


    self._updateShadowOffset = true
    UI.AddUpdate(function()
        if self._updateShadowOffset then
            self._updateShadowOffset = false
            if self._shadow == nil then return end
            japi.DzFrameClearAllPoints(self._shadow)
            local offset = self:getParentOffset()
            japi.DzFrameSetPoint(self._shadow, self._anchorType, self:getParentFrameID(),
                UI.AnchorType.LEFT_BOTTOM, self._x + self._shadowOffset.x + offset.x,
                self._y + self._shadowOffset.y + offset.y)
        end
    end)
end

---设置影子文本
---@return table
function UI.Text:getShadowOffset()
    return self._shadowOffset
end

---释放
function UI.Text:destroy()
    WindowCallback.RemoveResizeCallback(tostring(self))
    if self._shadow then
        japi.DzDestroyFrame(self._shadow)
        self._shadow = nil
    end
    UI.UIBase.destroy(self)
end

local function _alignmentToAnchorType(self)
    local align = self._align
    if align == 0 then
        return UI.AnchorType.LEFT_TOP
    end
    if align == 16 then
        return UI.AnchorType.TOP
    end
    if align == 32 then
        return UI.AnchorType.RIGHT_TOP
    end
    if align == 2 then
        return UI.AnchorType.LEFT
    end
    if align == 18 then
        return UI.AnchorType.CENTET
    end
    if align == 34 then
        return UI.AnchorType.RIGHT
    end
    if align == 4 then
        return UI.AnchorType.LEFT_BOTTOM
    end
    if align == 20 then
        return UI.AnchorType.BOTTOM
    end
    if align == 36 then
        return UI.AnchorType.RIGHT_BOTTOM
    end
end

---更新
function UI.Text:UpdateSize(delayTime)
    local width = japi.DzGetClientWidth() / 800
    local height = japi.DzGetClientHeight() / 800

    local scale = 1
    if width < height then
        scale = width / 800
    else
        scale = height / 600
    end
    local font_scale = (72 / 96 / 1.4) * scale * self._font.size
    self._font_scale = font_scale

    japi.DzFrameSetFont(self:getFrameID(), self._font.path, self._font_scale * self:getWorldScale(), self._font.style)
    if self._shadow == nil then return end
    japi.DzFrameSetFont(self._shadow, self._font.path, self._font_scale * self:getWorldScale(), 0)
end
