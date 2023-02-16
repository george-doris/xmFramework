---场景初始化,这是在UI编辑器里第一个节点的用户数据自动调用当前文件
---@param ui UI.Layer 当前加载的ui跟节点
return function (ui)
    ---@type UI.Panel
    local panel = ui:findChild({"Panel_8"})
    ---@type UI.Slider
    local slider = panel:findChild("Slider_13")
    slider:setCallback_OnValue(function (ui,v)
        ---@type UI.LoadingBar
        local loadingBar = panel:findChild({"Image_27","LoadingBar_5"})
        loadingBar:setValue(v)
    end)
end