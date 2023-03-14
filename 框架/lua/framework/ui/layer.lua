require "framework.ui.panel"
require "framework.ui.action.action_manager"
local UIActionParser = require "framework.ui.uiactionparser"
local japi = require "framework.dzapi"

---@class UI.Layer:UI.Panel
---面板
UI.Layer = Class("Layer", UI.Panel)

---创建新实例
---@return UI.Layer
function UI.Layer.new(name,parent)
    return UI.Layer._new(name,parent)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.Layer:ctor(name, parent)
    UI.Panel.ctor(self,name,parent)
    self._actionTimeline = {}
    self._actionData = nil

    --self._actionManager = UI.ActionManager.new()
end

---播放动画
---@param name string 动画名字
---@param loop boolean 是否循环
---@param fn function|nil 结束回调
---@return UI.Action.ActionTimeline|nil
function UI.Layer:playAction(name,loop,fn)
    if self._actionData==nil then
        return
    end
    ---@type UI.Action.ActionTimeline
    local actionTimeline = self._actionTimeline[name]
    if actionTimeline==nil then
        local animationList = self._actionData.animationList
        if animationList==nil then
            return
        end
        local c = animationList[name]
        if c==nil then
            return
        end
        actionTimeline = UIActionParser.Load(self,self._actionData)
        self._actionTimeline[name] = actionTimeline
        UI.ActionManager:addAction(actionTimeline)
    end
    actionTimeline:setLastFrameCallFunc(fn)
    actionTimeline:play(name,loop)

    return actionTimeline
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

function UI.Layer:stopAllAction()
    ---@type UI.Action.ActionTimeline
    local actionTimeline = self._actionTimeline
    self._actionTimeline = {}
    for index, value in SafePairs(actionTimeline) do
        value:stop()
    end
end

---释放
function UI.Layer:destroy()
    local actionTimeline = self._actionTimeline
    self._actionTimeline = nil
    for index, value in SafePairs(actionTimeline) do
        UI.ActionManager:removeAction(value)
    end
    UI.Panel.destroy(self)
end