require "framework.ui.scrollview"
local japi = require "framework.dzapi"

---@class UI.ListView:UI.ScrollView
---翻页面板
UI.ListView = Class("ListView", UI.ScrollView)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@param isClip boolean 是否裁剪
---@return UI.ListView
function UI.ListView.new(name,parent,isClip)
    return UI.ListView._new(name,parent,isClip)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.ListView:ctor(name, parent,isClip)
    UI.ScrollView.ctor(self,name,parent,isClip)

    self._direction = UI.Direction.VERTICAL
    self._contentAlign = 0
    self._itemMargin = 0
end

---@param self UI.ListView UI
local function _updateContent(self)
    if self._inner==nil then
        return
    end
    self._updateContent = true
    UI.AddUpdate(function ()
        if self._updateContent then
            self._updateContent = false
            
            local AnchorType
            if self._direction==UI.Direction.VERTICAL then
                --垂直
                if self._contentAlign==0 then
                    AnchorType = UI.AnchorType.LEFT_TOP
                elseif self._contentAlign==1 then
                    AnchorType = UI.AnchorType.TOP
                else
                    AnchorType = UI.AnchorType.RIGHT_TOP
                end
                self._innerSize.width = self._width
                local height = 0
                ---@param value UI.UIBase
                for _, value in ipairs(self._children) do
                    value._parentAnchorType = AnchorType
                    value:setAnchorType(AnchorType)
                    value:setPosition(0,-height)
                    height = height + value:getSize().height + self._itemMargin
                end
                self._innerSize.height = height
            else
                --水平
                if self._contentAlign==0 then
                    AnchorType = UI.AnchorType.LEFT_TOP
                elseif self._contentAlign==1 then
                    AnchorType = UI.AnchorType.LEFT
                else
                    AnchorType = UI.AnchorType.LEFT_BOTTOM
                end
                self._innerSize.height = self._height
                local width = 0
                ---@param value UI.UIBase
                for _, value in ipairs(self._children) do
                    value._parentAnchorType = AnchorType
                    value:setAnchorType(AnchorType)
                    value:setPosition(width,0)
                    width = width + value:getSize().width + self._itemMargin
                   
                end
                self._innerSize.width = width
            end
        end
    end)
end

function UI.ListView:setDirectionType(direction)
    if self._direction == direction then
        return
    end
    self._direction = direction
    _updateContent(self)
end

function UI.ListView:setContentAlign(contentAlign)
    if self._contentAlign == contentAlign then
        return
    end
    self._contentAlign = contentAlign
    _updateContent(self)
end

function UI.ListView:setItemMargin(itemMargin)
    if self._itemMargin == itemMargin then
        return
    end
    self._itemMargin = itemMargin
    _updateContent(self)
end

---添加子控件,这个函数不提供给外部使用
---@param child UI.UIBase UI
function UI.ListView:_addChild(child)
    UI.ScrollView._addChild(self,child)

    local parent = self
    rawset(child,"setSize", function (self,width,height)
        local index = getmetatable(self)
        index.__index.setSize(self,width,height)
        _updateContent(parent)
    end)
    --_updateContent(self)
end

---移除子窗口
---@param child UI.UIBase 子窗口
function UI.ListView:_removeChild(child)
    UI.ScrollView._removeChild(self,child)
    rawset(child,"setSize",nil)
    _updateContent(self)
end



