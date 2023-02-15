local GameUI = require "framework.ui.game_ui"

---@type UI.Button
local bt1 = GameUI:findChild("Button_36")
bt1:SetCallback_MouseClick(function ()
    ---@type UI.PageView
    local page = GameUI:findChild("PageView_4")
    page:scrollToPage(page:getCurrentPageIndex()-1)
end)

---@type UI.Button
local bt1 = GameUI:findChild("Button_36_0")
bt1:SetCallback_MouseClick(function ()
    ---@type UI.PageView
    local page = GameUI:findChild("PageView_4")
    page:scrollToPage(page:getCurrentPageIndex()+1)
end)

---@type UI.Panel
local panel = GameUI:findChild("Panel_8")
---@type UI.Slider
local slider = panel:findChild("Slider_13")
slider:setCallback_OnValue(function (ui,v)
    ---@type UI.LoadingBar
    local loadingBar = panel:findChild({"Image_27","LoadingBar_5"})
    loadingBar:setValue(v)
end)