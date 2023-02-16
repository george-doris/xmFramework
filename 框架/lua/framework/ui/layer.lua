require "framework.ui.frame"
require "framework.ui.action.action_manager"
local UIActionParser = require "framework.ui.uiactionparser"
local japi = require "framework.dzapi"

---@class UI.Layer:UI.Frame
---面板
UI.Layer = Class("Layer", UI.Frame)

---创建新实例
---@return UI.Layer
function UI.Layer.new(name,parent)
    return UI.Layer._new(name,parent)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Layer:ctor(name, parent)
    UI.Frame.ctor(self,name,parent)
    self._actionTimeline = {}
    self._actionData = nil

    --self._actionManager = UI.ActionManager.new()
end

---播放动画
---@param name string 动画名字
---@param loop boolean 是否循环
function UI.Layer:playAction(name,loop)
    if self._actionData==nil then
        return
    end
    ---@type UI.Action.ActionTimeline
    local actionTimeline = self._actionTimeline[name]
    if actionTimeline==nil then
        actionTimeline = UIActionParser.Load(self,self._actionData)
        self._actionTimeline[name] = actionTimeline
        UI.ActionManager:addAction(actionTimeline)
        actionTimeline:play(name,loop or false)
    end
end

---停止动画
---@param name string 动画名字
function UI.Layer:stopAction(name)
    ---@type UI.Action.ActionTimeline
    local actionTimeline = self._actionTimeline[name]
    if actionTimeline==nil then
        return
    end
    actionTimeline:stop()
end

---释放
function UI.Layer:destroy()
    local actionTimeline = self._actionTimeline
    self._actionTimeline = nil
    for index, value in SafePairs(actionTimeline) do
        UI.ActionManager:removeAction(actionTimeline)
    end
    UI.Frame.destroy(self)
end