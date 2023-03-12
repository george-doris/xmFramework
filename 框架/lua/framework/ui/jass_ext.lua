--扩展到T,但需要内置
local code

local Dev = require "framework.dev"
if Dev.HasXMLib() then
    code = require "code"
else
    local r,e = pcall(function ()
        return require("jass.code")
    end)
    if r then
        code = require("jass.code")
    end
end
if code ~= nil then
    require "framework.ui.layer"
    require "framework.ui.ui"
    local japi = require "jass.japi"
    local jass = require "jass.common"
    local UpdateCallback = require "framework.update_callback"

    local _global_ui
    local _executeTrigger

    if japi.XMExecuteTrigger then
        _executeTrigger = japi.XMExecuteTrigger
    else
        _executeTrigger = jass.TriggerExecute
    end

    code["XMUILoadScene"] = function(file, name, frameid)
        local ui = UI.LoadScene(file, UI.findFromFrameID(frameid), name)
        return ui:getFrameID()
    end

    code["XMUIFindChild"] = function(frameid, name)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[查找下级界面]传入参数不是xm界面,传入handle为"..frameid)
        end
        local names = string.split(name, ",")
        for _, n in ipairs(names) do
            ui = ui:findChild(n)
            if ui == nil then
                return 0
            end
        end
        return ui:getFrameID()
    end

    code["XMUIEnumChild"] = function(frameid, trig)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[所有下级界面并运行触发器]传入参数不是xm界面,传入handle为"..frameid)
        end
        ui:EnumChild(function(cui)
            _global_ui = cui
            _executeTrigger(trig)
            _global_ui = nil
        end)
    end

    code["XMUIEnumChildCode"] = function(frameid, c)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[所有下级界面并做动作]传入参数不是xm界面,传入handle为"..frameid)
        end
        ui:EnumChild(function(cui)
            _global_ui = cui
            c()
            _global_ui = nil
        end)
    end

    code["XMUIPlayAction"] = function(frameid, name, loop, trig)
        ---@type UI.Layer
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[播放动画]传入参数不是xm界面,传入handle为"..frameid)
        end
        ui:playAction(name, loop, function()
            _global_ui = ui
            _executeTrigger(trig)
            _global_ui = nil
        end)
    end

    code["XMUIPlayActionCode"] = function(frameid, name, loop, c)
        ---@type UI.Layer
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[播放动画,完成后做动作]传入参数不是xm界面,传入handle为"..frameid)
        end
        ui:playAction(name, loop, function()
            _global_ui = ui
            c()
            _global_ui = nil
        end)
    end

    code["XMUIStopAction"] = function(frameid, name)
        ---@type UI.Layer
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[停止动画]传入参数不是xm界面,传入handle为"..frameid)
        end
        ui:stopAction(name)
    end

    code["XMUIGetTriggerUI"] = function()
        if _global_ui then
            return _global_ui:getFrameID()
        end
        return 0
    end

    code["XMUISetMouseEvent"] = function(frameid, e, trig)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[鼠标事件]传入参数不是xm界面,传入handle为"..frameid)
        end
        if e == UI.MouseEvent.MOUSE_CLICK then
            ui:SetCallback_MouseClick(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_ENTER then
            ui:SetCallback_MouseEnter(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_LEAVE then
            ui:SetCallback_MouseLeave(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_WHEEL then
            ui:SetCallback_MouseWheel(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_MOVE then
            ui:SetCallback_MouseMove(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_LEFT_DOWN then
            ui:SetCallback_MouseLeftDown(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_LEFT_UP then
            ui:SetCallback_MouseLeftUp(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_RIGHT_DOWN then
            ui:SetCallback_MouseRightDown(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_RIGHT_UP then
            ui:SetCallback_MouseRightUp(function()
                _global_ui = ui
                _executeTrigger(trig)
                _global_ui = nil
            end)
        end
    end

    code["XMUISetMouseEventCode"] = function(frameid, e, c)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[鼠标事件做动作]传入参数不是xm界面,传入handle为"..frameid)
        end
        if e == UI.MouseEvent.MOUSE_CLICK then
            ui:SetCallback_MouseClick(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_ENTER then
            ui:SetCallback_MouseEnter(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_LEAVE then
            ui:SetCallback_MouseLeave(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_WHEEL then
            ui:SetCallback_MouseWheel(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_MOVE then
            ui:SetCallback_MouseMove(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_LEFT_DOWN then
            ui:SetCallback_MouseLeftDown(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_LEFT_UP then
            ui:SetCallback_MouseLeftUp(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_RIGHT_DOWN then
            ui:SetCallback_MouseRightDown(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        elseif e == UI.MouseEvent.MOUSE_RIGHT_UP then
            ui:SetCallback_MouseRightUp(function()
                _global_ui = ui
                c()
                _global_ui = nil
            end)
        end
    end

    code["XMUIClearMouseEvent"] = function(frameid, e)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[清除鼠标事件]传入参数不是xm界面,传入handle为"..frameid)
        end
        if e == UI.MouseEvent.MOUSE_CLICK then
            ui:SetCallback_MouseClick()
        elseif e == UI.MouseEvent.MOUSE_ENTER then
            ui:SetCallback_MouseEnter()
        elseif e == UI.MouseEvent.MOUSE_LEAVE then
            ui:SetCallback_MouseLeave()
        elseif e == UI.MouseEvent.MOUSE_WHEEL then
            ui:SetCallback_MouseWheel()
        elseif e == UI.MouseEvent.MOUSE_MOVE then
            ui:SetCallback_MouseMove()
        elseif e == UI.MouseEvent.MOUSE_LEFT_DOWN then
            ui:SetCallback_MouseLeftDown()
        elseif e == UI.MouseEvent.MOUSE_LEFT_UP then
            ui:SetCallback_MouseLeftUp()
        elseif e == UI.MouseEvent.MOUSE_RIGHT_DOWN then
            ui:SetCallback_MouseRightDown()
        elseif e == UI.MouseEvent.MOUSE_RIGHT_UP then
            ui:SetCallback_MouseRightUp()
        end
    end

    code["XMUIGetName"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面名字]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getName()
    end

    code["XMUIGetTag"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面标记]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getTag()
    end

    code["XMUISetSize"] = function(frameid, width, height)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面大小]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setSize(width, height)
    end

    code["XMUIGetWidth"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面宽度]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getWidth()
    end

    code["XMUIGetHeight"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面高度]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getHeight()
    end

    code["XMUISetAlpha"] = function(frameid, v)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面透明度]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setAlpha(v)
    end

    code["XMUIGetAlpha"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面透明度]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getAlpha()
    end

    code["XMUISetScale"] = function(frameid, v)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面缩放]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setScale(v)
    end

    code["XMUIGetScale"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面缩放]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getScale()
    end

    code["XMUISetEnable"] = function(frameid, v)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面启用/禁用]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setEnable(v)
    end

    code["XMUIGetEnable"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面启用/禁用]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getScale()
    end

    code["XMUISetVisible"] = function(frameid, v)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面显示/隐藏]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setVisible(v)
    end

    code["XMUIGetVisible"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面显示/隐藏]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:isVisible()
    end

    code["XMUISetPosition"] = function(frameid, x, y)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面位置]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setPosition(x, y)
    end

    code["XMUIGetX"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面x]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getPosition().x
    end

    code["XMUIGetY"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面y]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getPosition().y
    end

    code["XMUISetTexture"] = function(frameid, v)
        ---@type UI.Backdrop
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setTexture(v)
    end

    code["XMUIGetTexture"] = function(frameid)
        ---@type UI.Backdrop
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getTexture()
    end

    code["XMUISetNormalImage"] = function(frameid, v)
        ---@type UI.Button
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面普通状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setNormalImage(v)
    end

    code["XMUIGetNormalImage"] = function(frameid)
        ---@type UI.Button
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面普通状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getNormalImage()
    end

    code["XMUISetPressedImage"] = function(frameid, v)
        ---@type UI.Button
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面按下状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setPressedImage(v)
    end

    code["XMUIGetPressedImage"] = function(frameid)
        ---@type UI.Button
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面按下状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getPressedImage()
    end

    code["XMUISetDisableImage"] = function(frameid, v)
        ---@type UI.Button
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面禁用状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setDisableImage(v)
    end

    code["XMUIGetDisableImage"] = function(frameid)
        ---@type UI.Button
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面禁用状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getDisableImage()
    end

    code["XMUISetButtonStateImage"] = function(frameid, state,v)
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置按钮状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        if IsKindOf(ui,"Button") then
            ---@type UI.Button
            local cui = ui
            if state==0 then
                return cui:setNormalImage(v)
            elseif state==1 then
                return cui:setPressedImage(v)
            elseif state==2 then
                return cui:setDisableImage(v)
            end
        elseif IsKindOf(ui,"CheckBox") then
            ---@type UI.CheckBox
            local cui = ui
            if state==0 then
                return cui:setNormalImage(v)
            elseif state==1 then
                return cui:setPressedImage(v)
            elseif state==2 then
                return cui:setDisableImage(v)
            end
        elseif IsKindOf(ui,"Slider") then
            ---@type UI.Slider
            local cui = ui
            if state==0 then
                return cui:setButtonNormal(v)
            elseif state==1 then
                return cui:setButtonPressed(v)
            elseif state==2 then
                return cui:setButtonDisabled(v)
            end
        end
    end

    code["XMUIGetButtonStateImage"] = function(frameid,state)
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得按钮状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        if IsKindOf(ui,"Button") then
            ---@type UI.Button
            local cui = ui
            if state==0 then
                return cui:getNormalImage()
            elseif state==1 then
                return cui:getPressedImage()
            elseif state==2 then
                return cui:getDisableImage()
            end
        elseif IsKindOf(ui,"CheckBox") then
            ---@type UI.CheckBox
            local cui = ui
            if state==0 then
                return cui:getNormalImage()
            elseif state==1 then
                return cui:getPressedImage()
            elseif state==2 then
                return cui:getDisableImage()
            end
        elseif IsKindOf(ui,"Slider") then
            ---@type UI.Slider
            local cui = ui
            if state==0 then
                return cui:getButtonNormal()
            elseif state==1 then
                return cui:getButtonPressed()
            elseif state==2 then
                return cui:getButtonDisabled()
            end
        end
        return ""
    end

    code["XMUISetText"] = function(frameid, v)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面文字]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setText(v)
    end

    code["XMUIGetText"] = function(frameid)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面文字]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getText()
    end

    code["XMUIAutoSize"] = function(frameid, width)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[根据文本内容自动调整大小]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:AutoSize(width)
    end

    code["XMUISetFont"] = function(frameid, v)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面字体]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setFont(v)
    end

    code["XMUIGetFont"] = function(frameid)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面字体]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getFont()
    end

    code["XMUISetFontSize"] = function(frameid, v)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面字体大小]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setFontSize(v)
    end

    code["XMUIGetFontSize"] = function(frameid)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面字体大小]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getFontSize()
    end

    code["XMUISetNodeNormalImage"] = function(frameid, v)
        ---@type UI.CheckBox
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置复选框选中图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setNodeNormalImage(v)
    end

    code["XMUIGetNodeNormalImage"] = function(frameid)
        ---@type UI.CheckBox
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得复选框选中图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getNodeNormalImage()
    end

    code["XMUISetCheckState"] = function(frameid, v)
        ---@type UI.CheckBox
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置复选框选中状态]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setCheckState(v)
    end

    code["XMUIGetCheckState"] = function(frameid)
        ---@type UI.CheckBox
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得复选框选中状态]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getCheckState()
    end

    code["XMUISetFontStyle"] = function(frameid, v)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面字体样式]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setFontStyle(v)
    end

    code["XMUIGetFontStyle"] = function(frameid)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面字体样式]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getFontStyle()
    end

    code["XMUISetTextAlignment"] = function(frameid, v)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面文字对齐方式]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setTextAlignment(v)
    end

    code["XMUIGetTextAlignment"] = function(frameid)
        ---@type UI.Text
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面文字对齐方式]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getTextAlignment()
    end

    code["XMUISetValue"] = function(frameid, v)
        ---@type UI.Slider
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置界面值]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setValue(v)
    end

    code["XMUIGetValue"] = function(frameid)
        ---@type UI.Slider
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[获得界面值]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getValue()
    end

    code["XMUISetProgressBarImage"] = function(frameid, v)
        ---@type UI.Slider
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置按钮状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setProgressBarImage(v)
    end

    code["XMUIGetProgressBarImage"] = function(frameid)
        ---@type UI.Slider
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置按钮状态图片]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:getProgressBarImage()
    end

    code["XMUISetValueCallback"] = function(frameid, trig)
        ---@type UI.Slider
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置滑动条值改变运行触发]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setCallback_OnValue(function()
            _global_ui = ui
            _executeTrigger(trig)
            _global_ui = nil
        end)
    end

    code["XMUISetValueCallbackCode"] = function(frameid, c)
        ---@type UI.Slider
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[设置滑动条值改变时做动作]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setCallback_OnValue(function()
            _global_ui = ui
            c()
            _global_ui = nil
        end)
    end

    code["XMUIClearValueCallback"] = function(frameid)
        ---@type UI.Slider
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[清除界面值改变运行触发]传入参数不是xm界面,传入handle为"..frameid)
        end
        return ui:setCallback_OnValue()
    end

    code["XMUIDestroy"] = function(frameid)
        ---@type UI.UIBase
        local ui = UI.findFromFrameID(frameid)
        if ui == nil then
            error("调用[释放界面]传入参数不是xm界面,传入handle为"..frameid)
        end
        ui:destroy()
    end

    code["XMUIDestroyAll"] = function()
        UI.GameUI:removeAllChild()
    end

    code["XMUIUpdateCallback"] = function(tag, trig)
        UpdateCallback.AddUpdateCallback(tag, function()
            _executeTrigger(trig)
        end)
    end

    code["XMUIClearUpdateCallback"] = function(tag)
        UpdateCallback.RemoveUpdateCallback(tag)
    end
end
