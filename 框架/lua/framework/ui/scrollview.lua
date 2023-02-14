require "framework.ui.panel"
local japi = require "framework.dzapi"

---@class UI.ScrollView:UI.Panel
---面板
UI.ScrollView = Class("ScrollView", UI.Panel)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@param isClip boolean 是否裁剪
---@return UI.ScrollView
function UI.ScrollView.new(name,parent,isClip)
    return UI.ScrollView._new(name,parent,isClip)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.ScrollView:ctor(name, parent,isClip)
    UI.Panel.ctor(self,name,parent,isClip)

    local inner = UI.Panel.new("_INNER",self,false)
    UI.Inner(inner)
    inner._parentAnchorType = UI.AnchorType.LEFT_TOP
    inner:setAnchorType(UI.AnchorType.LEFT_TOP)
    inner:setPosition(0,0)
    inner:setSize(0.0000001,0.0000001)
    self._inner = inner
    self._verticalScrollbar = nil
    self._horizontalScrollbar = nil

    self._innerSize = {width=0,height=0}
end

function UI.ScrollView:setInnerSize(width,height)
    self._innerSize.width = width
    self._innerSize.height = height
end

---添加子控件,这个函数不提供给外部使用
---@param child UI.UIBase UI
function UI.ScrollView:_addChild(child)
    local name = child:getName()
    if name=="[VerticalScrollbar]" then
        --垂直滚动条
        --self:setVerticalScrollbar(child)
        return
    end
    if name=="[HorizontalScrollbar]" then
        --垂直滚动条
        --self:setHorizontalScrollbar(child)
        return
    end
    if self._children[name] ~= nil then
        print("set parent:parent ~= nil :" .. name)
        print(debug.traceback())
    end
    self._children[name] = child
    --添加顺序序列
    table.insert(self._children,child)

    if self._inner then
        local inner = self._inner
        rawset(child,"getParentFrameID",function (self)
            return inner:getFrameID()
        end)
        local innerSize = self._innerSize
        ---转换描点
        rawset(child,"getParentOffset",function (self)
            local offset = {x=0,y=0}
            if self._parentAnchorType==UI.AnchorType.TOP then
                offset.x = innerSize.width/2
            elseif self._parentAnchorType==UI.AnchorType.RIGHT_TOP then
                offset.x = innerSize.width
            elseif self._parentAnchorType==UI.AnchorType.LEFT then
                offset.y = -innerSize.height/2
            elseif self._parentAnchorType==UI.AnchorType.CENTET then
                offset.x = innerSize.width/2
                offset.y = -innerSize.height/2
            elseif self._parentAnchorType==UI.AnchorType.RIGHT then
                offset.x = innerSize.width
                offset.y = -innerSize.height/2
            elseif self._parentAnchorType==UI.AnchorType.LEFT_BOTTOM then
                offset.y = -innerSize.height
            elseif self._parentAnchorType==UI.AnchorType.BOTTOM then
                offset.x = innerSize.width/2
                offset.y = -innerSize.height
            elseif self._parentAnchorType==UI.AnchorType.RIGHT_BOTTOM then
                offset.x = innerSize.width
                offset.y = -innerSize.height
            end
            return offset
        end)
    end
end

---移除子窗口
---@param child UI.UIBase 子窗口
function UI.ScrollView:_removeChild(child)
    UI.Panel._removeChild(self,child)
    rawset(child,"getParentFrameID",nil)
    rawset(child,"getParentOffset",nil)
end

---更新内页位置
---@param self UI.ScrollView
local function _updateInnerPos(self)
    self._updateInnerPos = true
    UI.AddUpdate(function ()
        if self._updateInnerPos then
            self._updateInnerPos = false
            local pos = {x=0,y=0}

            if self._verticalScrollbar then
                local height = self._innerSize.height-self._height
                pos.y = self._verticalScrollbar:getValue()*height
            end
            if self._horizontalScrollbar then
                local width = self._innerSize.width-self._width
                pos.x = -self._horizontalScrollbar:getValue()*width
            end
            self._inner:setPosition(pos.x,pos.y)
        end
    end)
end

---设置垂直滚动条
---@param scrollbar UI.Slider
function UI.ScrollView:setVerticalScrollbar(scrollbar)
    if self._verticalScrollbar then
        self._verticalScrollbar:destroy()
        self._verticalScrollbar = nil
    end
    if scrollbar then
        self._verticalScrollbar = scrollbar
        scrollbar:setValue(0)
        scrollbar:setOnValueCallback(function (s,value)
            _updateInnerPos(self)
        end)
    end
end

---设置水平滚动条
---@param scrollbar UI.Slider
function UI.ScrollView:setHorizontalScrollbar(scrollbar)
    if self._horizontalScrollbar then
        self._horizontalScrollbar:destroy()
        self._horizontalScrollbar = nil
    end
    if scrollbar then
        self._horizontalScrollbar = scrollbar
        scrollbar:setValue(0)
        scrollbar:setOnValueCallback(function (s,value)
            _updateInnerPos(self)
        end)
    end
end