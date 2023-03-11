local japi = require "framework.dzapi"
local Mouse = require "framework.mouse"
require "framework.ui.common"
-- require "component.event"

---@class UI.UIBase
---@field _new function
---UI基础类
UI.UIBase = Class("UIBase")

---添加子控件,这个函数不提供给外部使用
---@param child UI.UIBase UI
function UI.UIBase:_addChild(child)
    local name = child:getName()
    if self._children[name] ~= nil then
        print("set parent:parent ~= nil :" .. name)
        print(debug.traceback())
    end
    self._children[name] = child
    --添加顺序序列
    table.insert(self._children,child)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
---@param frameid framehandle 游戏窗口句柄
function UI.UIBase:ctor(name, parent, frameid)
    self._name = name
    self._frameid = frameid
    self._width = 0
    self._height = 0
    self._tag = 0
    self._actionTag = nil
    self._anchorType = UI.AnchorType.LEFT_BOTTOM
    self._parentAnchorType = UI.AnchorType.LEFT_BOTTOM
    self._scale = 1
    self._x = 0.0000001
    self._y = 0.0000001
    self._alpha = 255
    self._visible = true
    self._enable = false
    self._parent = parent
    self._children = {}
    self._event = nil
    self._worldScale = nil
    UI.register(self,frameid)

    parent:_addChild(self)
end

---返回war3ui句柄
---@return framehandle
function UI.UIBase:getFrameID()
    return self._frameid
end

---获得名字
---@return string 名字
function UI.UIBase:getName() return self._name end

---移除子窗口
---@param child UI.UIBase 子窗口
function UI.UIBase:_removeChild(child)
    local name = child:getName()
    local node =  self._children[name]
    if node then
        self._children[name] = nil
        table.removebyvalue(self._children,child)
    end
end

local function _updatePos(self)
    self._updatePos = true
    UI.AddUpdate(function ()
        if self._updatePos then
            self._updatePos = false
            japi.DzFrameClearAllPoints(self:getFrameID())
            local x = self._x/self._scale
            local y = self._y/self._scale
            --裁剪窗口特殊需求,y不能是0,不然不显示
            if x==0 then
                x = 0.0000001
            end
            if y==0 then
                y = 0.0000001
            end
            local offset = self:getParentOffset()
            japi.DzFrameSetPoint(self:getFrameID(), self._anchorType, self:getParentFrameID(),
                self._parentAnchorType, x+offset.x, y+offset.y)
        end
    end)
end

---设置父类组件
---@param parent UI.UIBase 父控件
function UI.UIBase:setParent(parent)
    error("UI设置父类不可用,会造成不可预知的bug")
    self._parent:_removeChild(self)
    self._parent = parent
    japi.DzFrameSetParent(self:getFrameID(),parent:getFrameID())
    parent:_addChild(self)
    _updatePos(self)
end

---获得父类UI
---@return UI.UIBase @父控件
function UI.UIBase:getParent() return self._parent end

local _offset = {x=0,y=0}
function UI.UIBase:getParentOffset()
    return _offset
end

---设置大小
---@param width number 宽度
---@param height number 高度
function UI.UIBase:setSize(width,height)
    if self._width == width and self._height == height then return end
    self._width = width
    self._height = height
    
    self._updateSize = true
    UI.AddUpdate(function ()
        if self._updateSize then
            self._updateSize = false
            japi.DzFrameSetSize(self:getFrameID(), self._width, self._height)
            --设置事件窗口大小
            local event = self._event
            if event then japi.DzFrameSetSize(event.frameid, self._width, self._height) end
        end
    end)
end

---获得宽高
---@return table {width,height}
function UI.UIBase:getSize()
    return {width=self._width,height=self._height}
end

---获得宽度
---@return number
function UI.UIBase:getWidth()
    return self._width
end

---获得高度
---@return number
function UI.UIBase:getHeight()
    return self._height
end

---设置tag
---@param tag integer 标志
function UI.UIBase:setTag(tag)
    self._tag = tag
end

---获得tag
---@return integer 标志
function UI.UIBase:getTag()
    return self._tag
end

---设置tag
---@param tag integer 标志
function UI.UIBase:setActionTag(tag)
    self._actionTag = tag
end


---设置透明度
---@param alpha integer 透明度0-255
function UI.UIBase:setAlpha(alpha)
    if self._alpha==alpha then
        return
    end
    self._alpha=alpha
    self._updateAlpha = true
    UI.AddUpdate(function ()
        if self._updateAlpha then
            self._updateAlpha = false
            japi.DzFrameSetAlpha(self:getFrameID(), self._alpha)
        end
    end)
end

---获得透明度
---@return integer 透明度0-255
function UI.UIBase:getAlpha()
    return self._alpha
end

--强行更新缩放比
function UI.UIBase:updateScale(scale)
    self._scale = scale
    self._worldScale = nil
    self._updateScale = true
    UI.AddUpdate(function ()
        if self._updateScale then
            self._updateScale = false
            japi.DzFrameSetScale(self:getFrameID(), self:getWorldScale())
            --设置事件窗口大小
            local event = self._event
            if event then japi.DzFrameSetScale(event.frameid, self:getWorldScale()) end
        end
    end)
    local scale
    for index, value in ipairs(self._children) do
        scale = value:getScale()
        value._scale = 0.0000001
        value:setScale(scale)
    end
end

---设置缩放
---@param scale number 0-1
function UI.UIBase:setScale(scale)
    -- if NumberEqual(self._scale,scale) then
    --     return
    -- end
    self:updateScale(scale)
end

---获得缩放比
---@return number
function UI.UIBase:getScale()
    return self._scale
end

---获得全局缩放比
function UI.UIBase:getWorldScale()
    if self._worldScale==nil then
        local scale = self._scale
        local node = self:getParent()
        while node do
            scale = scale*node._scale
            node = node:getParent()
        end
        self._worldScale = scale
    end
    return self._worldScale
end

---启用\禁用
---@param isEnable boolean 是否启用
function UI.UIBase:setEnable(isEnable)
    if self._enable == isEnable then return end
    self._enable = isEnable

    self._updateEnable = true
    UI.AddUpdate(function ()
        if self._updateEnable then
            self._updateEnable = false
            local event = self._event
            if event then japi.DzFrameSetEnable(event.frameid, self._enable) end
        end
    end)
end

---是否启用
---@return boolean
function UI.UIBase:isEnable()
    return self._enable 
end


---设置顶点颜色
---@param r integer 0-255
---@param g integer 0-255
---@param b integer 0-255
---@param a integer 0-255
function UI.UIBase:setVertexColor(r, g, b, a)
    japi.DzFrameSetVertexColor(self:getFrameID(), japi.DzGetColor(a,r, g, b))
end

---显示\隐藏
---@param isShow boolean 是否显示
function UI.UIBase:setVisible(isShow)
    if self._visible == isShow then return end
    self._visible = isShow

    self._updateVisible = true
    UI.AddUpdate(function ()
        if self._updateVisible then
            self._updateVisible = false
            japi.DzFrameShow(self:getFrameID(), self._visible)
        end
    end)
end

function UI.UIBase:isVisible()
    return self._visible
end

---设置位置
---@param anchorType UI.AnchorType 描点
function UI.UIBase:setAnchorType(anchorType)
    if self._anchorType == anchorType then
        return
    end
    self._anchorType = anchorType
    _updatePos(self)
end

---设置位置
---@param x number x坐标
---@param y number y坐标
function UI.UIBase:setPosition(x, y)
    if self._x == x and self._y == y then
        return
    end
    self._x = x
    self._y = y

    _updatePos(self)
end

function UI.UIBase:getParentFrameID()
    return self:getParent():getFrameID()
end

---获得位置
---@return table{x:number|y:number}
function UI.UIBase:getPosition()
   return {x=self._x,y=self._y}
end

---设置优先事件
---@param priority integer 优先级
function UI.UIBase:SetPriority(priority)
    japi.DzFrameSetPriority(self:getFrameID(), priority)
end

---注册事件
---@param self UI.UIBase
---@param eventId UI.MouseEvent 事件id
---@param fn function 回调函数
local function _registerEvent(self,eventId, fn)
    local event = self._event
    if event == nil then
        event = { events = {} }
        local frameid = japi.DzCreateFrameByTagName("BUTTON", "_BUTTON",
            self:getFrameID(), "", 0)
        japi.DzFrameSetPoint(frameid, UI.AnchorType.CENTET, self:getFrameID(),
            UI.AnchorType.CENTET, 0, 0)
        japi.DzFrameSetSize(frameid, self._width, self._height)
        event.frameid = frameid
        self._event = event
        if self._enable == false then
            japi.DzFrameSetEnable(event.frameid, false)
        end
        UI.register(self,frameid)
    end
    if event.events[eventId] == nil then
        event.events[eventId] = fn
        if eventId < 100 then
            japi.DzFrameSetScriptByCode(event.frameid, eventId,
                UI.MOUSE_EVENT_INDEX[eventId], false)
        end
    end
end

---注销事件
---@param eventId UI.MouseEvent 事件id
local function _unregisterEvent(self,eventId)
    local event = self._event
    if event.events[eventId] then
        event.events[eventId] = nil
        if eventId < 100 then
            japi.DzFrameSetScript(event.frameid, eventId, nil, false)
        end
        if table.nums(event.events) == 0 then
            self._event = nil
            UI.unRegister(event.frameid)
            japi.DzDestroyFrame(event.frameid)
        end
    end
end

---鼠标进入消息回调
function UI.UIBase:SetCallback_MouseEnter(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_ENTER,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_ENTER)
    end
end

---鼠标离开消息回调
function UI.UIBase:SetCallback_MouseLeave(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_LEAVE,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_LEAVE)
    end
end

---鼠标左键按下消息回调
function UI.UIBase:SetCallback_MouseLeftDown(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_LEFT_DOWN,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_LEFT_DOWN)
    end
end

---鼠标左键抬起消息回调
function UI.UIBase:SetCallback_MouseLeftUp(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_LEFT_UP,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_LEFT_UP)
    end
end

---鼠标左键按下消息回调
function UI.UIBase:SetCallback_MouseRightDown(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_RIGHT_DOWN,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_RIGHT_DOWN)
    end
end

---鼠标左键抬起消息回调
function UI.UIBase:SetCallback_MouseRightUp(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_RIGHT_UP,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_RIGHT_UP)
    end
end

---鼠标移动消息回调
function UI.UIBase:SetCallback_MouseMove(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_MOVE,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_MOVE)
    end
end

---鼠标齿轮消息回调
function UI.UIBase:SetCallback_MouseWheel(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_WHEEL,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_WHEEL)
    end
end

---鼠标单击消息回调
function UI.UIBase:SetCallback_MouseClick(fn)
    if fn then
        _registerEvent(self,UI.MouseEvent.MOUSE_CLICK,fn)
    else
        _unregisterEvent(self,UI.MouseEvent.MOUSE_CLICK)
    end
end

---查找子窗口
---多级查找,参数为table类型
---@param name string|table 子窗口名称
---@return UI.UIBase|nil
function UI.UIBase:findChild(name)
    if type(name)=="table" then
        local ui = self
        for index, value in ipairs(name) do
            ui = ui:findChild(value)
            if ui==nil then
                return nil
            end
        end
        return ui
    end
    return self._children[name]
end

---移除子窗口
---@param name string 子窗口名称
function UI.UIBase:removeChild(name)
    local child = self._children[name]
    if child then
        self._children[name] = nil
        table.removebyvalue(self._children,child)
        child:destroy()
    end
end

---移除所有子窗口
function UI.UIBase:removeAllChild()
    local children = self._children[1]
    while children do
        children:destroy()
        children = self._children[1]
    end
end

---枚举处理一级子界面
---@param fn function 函数
function UI.UIBase:EnumChild(fn)
    for index, value in ipairs(self._children) do
        fn(value)
    end
end

---释放所有监听事件
local function _unregisterAllEvent(self)
    local event = self._event
    if event == nil then return end
    self._event = nil
    for k, v in SafePairs(event.events) do
        if k < 100 then japi.DzFrameSetScript(event.frameid, k, nil, false) end
    end

    UI.unRegister(event.frameid)
    japi.DzDestroyFrame(event.frameid)
end

---释放
function UI.UIBase:destroy()
    self.tag = nil
    _unregisterAllEvent(self)
    self._parent:_removeChild(self)
    self:removeAllChild()
    if self._frameid then
        UI.unRegister(self._frameid)
        if not IsKindOf(self, "GameUI") then
            japi.DzDestroyFrame(self._frameid)
        end
        self._frameid = nil
    end
end


local _cur_ui
local _cur_button
-- 鼠标左键按下
Mouse.AddMouseButtonEvent("ui_mouse_left_down", Mouse.LEFT, Mouse.DWON, function()
    if _cur_button ~= nil and _cur_button ~= Mouse.LEFT then return end
    --记录当前按钮为左键
    _cur_button = Mouse.LEFT
    --获得当前窗口
    local frameid = japi.DzGetMouseFocus()
    if frameid == 0 then return end
    --给窗口发消息
    local ui = UI.findFromFrameID(frameid)
    if ui == nil then return end
    local event = ui._event
    if event == nil then return end
    local fn = event.events[UI.MouseEvent.MOUSE_LEFT_DOWN]
    if fn then
        _cur_ui = ui
        fn(ui)
    end
end)

-- 鼠标左键弹起
Mouse.AddMouseButtonEvent("ui_mouse_left_up", Mouse.LEFT, Mouse.UP, function()
    if _cur_button ~= nil and _cur_button ~= Mouse.LEFT then return end
    _cur_button = nil
    local ui = _cur_ui
    if ui then
        _cur_ui = nil
    else
        local frameid = japi.DzGetMouseFocus()
        if frameid == 0 then return end
        ui = UI.findFromFrameID(frameid)
    end
    if ui == nil then return end
    local event = ui._event
    if event == nil then return end
    local fn = event.events[UI.MouseEvent.MOUSE_LEFT_UP]
    if fn then fn(ui) end
end)

-- 鼠标右键按下
Mouse.AddMouseButtonEvent("ui_mouse_right_down", Mouse.RIGHT, Mouse.DWON,
    function()
        if _cur_button ~= nil and _cur_button ~= Mouse.RIGHT then return end
        _cur_button = Mouse.RIGHT
        --获得当前ui
        local frameid = japi.DzGetMouseFocus()
        if frameid == 0 then return end
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then return end
        local event = ui._event
        if event == nil then return end
        local fn = event.events[UI.MouseEvent.MOUSE_RIGHT_DOWN]
        if fn then
            _cur_ui = ui
            fn(ui)
        end
    end)

-- 鼠标右键弹起
Mouse.AddMouseButtonEvent("ui_mouse_right_up", Mouse.RIGHT, Mouse.UP, function()
    if _cur_button ~= nil and _cur_button ~= Mouse.RIGHT then return end
    _cur_button = nil
    local ui = _cur_ui
    if ui == nil then
        local frameid = japi.DzGetMouseFocus()
        if frameid == 0 then return end
        ui = UI.findFromFrameID(frameid)
    end
    if ui == nil then return end
    local event = ui._event
    if event == nil then return end
    local fn = event.events[UI.MouseEvent.MOUSE_RIGHT_UP]
    if fn then fn(ui) end
end)

-- 鼠标移动
Mouse.AddMouseMoveEvent("ui_mouse_move", function()
    local ui = _cur_ui
    if ui == nil then
        local frameid = japi.DzGetMouseFocus()
        if frameid == 0 then return end
        ui = UI.findFromFrameID(frameid)
    end
    if ui == nil then return end
    local event = ui._event
    if event == nil then return end
    local fn = event.events[UI.MouseEvent.MOUSE_MOVE]
    if fn then fn(ui) end
end)

-- 鼠标滚轮
-- Mouse.AddMouseWheelEvent("ui_mouse_wheel", function()
--     local frameid = japi.DzGetMouseFocus()
--     if frameid == 0 then return end
--     local ui = UI.findFromFrameID(frameid)
--     if ui == nil then return end
--     local event = ui._event
--     if event == nil then return end
--     local fn = event.events[UI.MouseEvent.MOUSE_WHEEL]
--     if fn then fn(ui) end
-- end)


return UI.UIBase