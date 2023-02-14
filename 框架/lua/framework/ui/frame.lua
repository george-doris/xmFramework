require "framework.ui.uibase"
local japi = require "framework.dzapi"

---@class UI.Frame:UI.UIBase
---面板
UI.Frame = Class("Frame", UI.UIBase)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@return UI.Frame
function UI.Frame.new(name,parent)
    return UI.Frame._new(name,parent)
end

---构造函数
---@param name string 控件名
---@param parent UI.UIBase 父控件
function UI.Frame:ctor(name,parent)
    local frameid = japi.DzCreateFrameByTagName("FRAME", name, parent:getFrameID(), "FRAME_TEMPLATE", 0)
    UI.UIBase.ctor(self,name, parent, frameid)
end

-- ---启用\禁用
-- ---@param isEnable boolean 是否启用
-- function UI.Frame:Enable(isEnable)
--     if self._enable == isEnable then return end
--     japi.DzFrameSetEnable(self:getFrameID(), isEnable)
--     UI.UIBase.setEnable(self,isEnable)
-- end

-- ---设置大小
-- ---@param width number 宽度
-- ---@param height number 高度
-- function UI.Frame:SetSize(width, height)
--     if self._width == width and self._height == height then return end
--     self._width = width
--     self._height = height
--     japi.DzFrameSetSize(self:GetFrame(), width, height)
-- end

-- ---注册事件
-- ---@param eventId UI.Event 事件id
-- ---@param fn function 回调函数
-- function UI.Frame:RegisterEvent(eventId, fn)
--     local event = self._event
--     if event == nil then
--         event = {events = {}}
--         self._event = event
--         if self._enable == false then
--             japi.DzFrameSetEnable(self:GetFrame(), false)
--         end
--     end
--     if event.events[eventId] == nil then
--         event.events[eventId] = fn
--         if eventId < 100 then
--             japi.DzFrameSetScript(self:GetFrame(), eventId,
--                                   UI.MOUSE_EVENT_INDEX[eventId], false)
--         end
--     end
-- end

-- ---注销事件
-- ---@param eventId UI.Event 事件id
-- function UI.Frame:UnregisterEvent(eventId)
--     local event = self._event
--     if event.events[eventId] then
--         event.events[eventId] = nil
--         if eventId < 100 then
--             japi.DzFrameSetScript(self:GetFrame(), eventId, nil, false)
--         end
--         if table.nums(event.events) == 0 then
--             self._event = nil
--         end
--     end
-- end