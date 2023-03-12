local japi = require "jass.japi"

---场景初始化,这是在UI编辑器里第一个节点的用户数据自动调用当前文件
---@param ui UI.Layer 当前加载的ui跟节点
return function (ui)
    ---@type UI.Slider
    local slider = ui:findChild({"[Vertical]_2"})
    slider:SetCallback_MouseWheel(function ()
        ---@type UI.PageView
        local v = japi.DzGetWheelDelta()
        if japi.DzGetWheelDelta() > 0 then
            slider:setValue(slider:getValue()-0.1)
        else
            slider:setValue(slider:getValue()+0.1)
        end
    end)
end