--扩展到T,但需要内置

require "framework.ui.layer"
require "framework.ui.ui"
local code = require "code"
local japi = require "jass.japi"

local _global_ui

code["XMUILoadScene"] = function(file,name,frameid)
    local ui = UI.LoadScene(file,UI.findFromFrameID(frameid),name)
    return ui:getFrameID()
end

code["XMUIFindChild"] = function(frameid,name)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    local names = string.split(name,",")
    for _, n in ipairs(names) do
        ui = ui:findChild(n)
        if ui==nil then
            return 0
        end
    end
    return ui:getFrameID()
end

code["XMUIPlayAction"] = function(frameid,name,loop,trig)
    ---@type UI.Layer
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    ui:playAction(name,loop,function ()
        _global_ui = ui
        japi.XMExecuteTrigger(trig)
        _global_ui = nil
    end)
end

code["XMUIStopAction"] = function(frameid,name)
    ---@type UI.Layer
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    ui:stopAction(name)
end

code["XMUIGetTriggerUI"] = function()
    if _global_ui then
        return _global_ui:getFrameID()
    end
    return 0
end

code["XMUISetMouseEvent"] = function(frameid,e,trig)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    if e==UI.MouseEvent.MOUSE_CLICK then
        ui:SetCallback_MouseClick(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_ENTER then
        ui:SetCallback_MouseEnter(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_LEAVE then
        ui:SetCallback_MouseLeave(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_WHEEL then
        ui:SetCallback_MouseWheel(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_MOVE then
        ui:SetCallback_MouseMove(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_LEFT_DOWN then
        ui:SetCallback_MouseLeftDown(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_LEFT_UP then
        ui:SetCallback_MouseLeftUp(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_RIGHT_DOWN then
        ui:SetCallback_MouseRightDown(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    elseif e==UI.MouseEvent.MOUSE_RIGHT_UP then
        ui:SetCallback_MouseRightUp(function ()
            _global_ui = ui
            japi.XMExecuteTrigger(trig)
            _global_ui = nil
        end)
    end
end

code["XMUIClearMouseEvent"] = function(frameid,e)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    if e==UI.MouseEvent.MOUSE_CLICK then
        ui:SetCallback_MouseClick()
    elseif e==UI.MouseEvent.MOUSE_ENTER then
        ui:SetCallback_MouseEnter()
    elseif e==UI.MouseEvent.MOUSE_LEAVE then
        ui:SetCallback_MouseLeave()
    elseif e==UI.MouseEvent.MOUSE_WHEEL then
        ui:SetCallback_MouseWheel()
    elseif e==UI.MouseEvent.MOUSE_MOVE then
        ui:SetCallback_MouseMove()
    elseif e==UI.MouseEvent.MOUSE_LEFT_DOWN then
        ui:SetCallback_MouseLeftDown()
    elseif e==UI.MouseEvent.MOUSE_LEFT_UP then
        ui:SetCallback_MouseLeftUp()
    elseif e==UI.MouseEvent.MOUSE_RIGHT_DOWN then
        ui:SetCallback_MouseRightDown()
    elseif e==UI.MouseEvent.MOUSE_RIGHT_UP then
        ui:SetCallback_MouseRightUp()
    end
end

code["XMUIGetName"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return ""
    end
    return ui:getName()
end

code["XMUIGetTag"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return ""
    end
    return ui:getTag()
end

code["XMUISetSize"] = function(frameid,width,height)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return ""
    end
    return ui:setSize(width,height)
end

code["XMUIGetWidth"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getWidth()
end

code["XMUIGetHeight"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getHeight()
end

code["XMUISetAlpha"] = function(frameid,v)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setAlpha(v)
end

code["XMUIGetAlpha"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getAlpha()
end

code["XMUISetScale"] = function(frameid,v)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setScale(v)
end

code["XMUIGetScale"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getScale()
end

code["XMUISetEnable"] = function(frameid,v)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setEnable(v)
end

code["XMUIGetEnable"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getScale()
end

code["XMUISetVisible"] = function(frameid,v)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setVisible(v)
end

code["XMUIGetVisible"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:isVisible()
end

code["XMUISetPosition"] = function(frameid,x,y)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setPosition(x,y)
end

code["XMUIGetX"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getPosition().x
end

code["XMUIGetY"] = function(frameid)
    ---@type UI.UIBase
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getPosition().y
end

code["XMUISetTexture"] = function(frameid,v)
    ---@type UI.Backdrop
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setTexture(v)
end

code["XMUIGetTexture"] = function(frameid)
    ---@type UI.Backdrop
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getTexture()
end

code["XMUISetNormalImage"] = function(frameid,v)
    ---@type UI.Button
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setNormalImage(v)
end

code["XMUIGetNormalImage"] = function(frameid)
    ---@type UI.Button
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getNormalImage()
end

code["XMUISetPressedImage"] = function(frameid,v)
    ---@type UI.Button
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setPressedImage(v)
end

code["XMUIGetPressedImage"] = function(frameid)
    ---@type UI.Button
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getPressedImage()
end

code["XMUISetDisableImage"] = function(frameid,v)
    ---@type UI.Button
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setDisableImage(v)
end

code["XMUIGetDisableImage"] = function(frameid)
    ---@type UI.Button
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getDisableImage()
end

code["XMUISetText"] = function(frameid,v)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setText(v)
end

code["XMUIGetText"] = function(frameid)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getText()
end

code["XMUISetFont"] = function(frameid,v)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setFont(v)
end

code["XMUIGetFont"] = function(frameid)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getFont()
end

code["XMUISetFontSize"] = function(frameid,v)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setFontSize(v)
end

code["XMUIGetFontSize"] = function(frameid)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getFontSize()
end

code["XMUISetNodeNormalImage"] = function(frameid,v)
    ---@type UI.CheckBox
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setNodeNormalImage(v)
end

code["XMUIGetNodeNormalImage"] = function(frameid)
    ---@type UI.CheckBox
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getNodeNormalImage()
end

code["XMUISetCheckState"] = function(frameid,v)
    ---@type UI.CheckBox
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setCheckState(v)
end

code["XMUIGetCheckState"] = function(frameid)
    ---@type UI.CheckBox
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getCheckState()
end

code["XMUISetFontStyle"] = function(frameid,v)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setFontStyle(v)
end

code["XMUIGetFontStyle"] = function(frameid)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getFontStyle()
end

code["XMUISetTextAlignment"] = function(frameid,v)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setTextAlignment(v)
end

code["XMUIGetTextAlignment"] = function(frameid)
    ---@type UI.Text
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getTextAlignment()
end

code["XMUISetValue"] = function(frameid,v)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setValue(v)
end

code["XMUIGetValue"] = function(frameid)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getValue()
end

code["XMUISetProgressBarImage"] = function(frameid,v)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setProgressBarImage(v)
end

code["XMUIGetProgressBarImage"] = function(frameid)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getProgressBarImage()
end

code["XMUISetButtonDisabled"] = function(frameid,v)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setButtonDisabled(v)
end

code["XMUIGetButtonDisabled"] = function(frameid)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getButtonDisabled()
end

code["XMUISetButtonNormal"] = function(frameid,v)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setButtonNormal(v)
end

code["XMUIGetButtonNormal"] = function(frameid)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getButtonNormal()
end

code["XMUISetButtonPressed"] = function(frameid,v)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setButtonPressed(v)
end

code["XMUIGetButtonPressed"] = function(frameid)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:getButtonPressed()
end

code["XMUISetValueCallback"] = function(frameid,trig)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setCallback_OnValue(function ()
        _global_ui = ui
        japi.XMExecuteTrigger(trig)
        _global_ui = nil
    end)
end

code["XMUIClearValueCallback"] = function(frameid)
    ---@type UI.Slider
    local ui = UI.findFromFrameID(frameid)
    if ui==nil then
        return 0
    end
    return ui:setCallback_OnValue()
end