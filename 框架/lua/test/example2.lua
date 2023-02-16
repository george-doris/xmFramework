---场景初始化,这是在UI编辑器里第一个节点的用户数据自动调用当前文件
---@param ui UI.Layer 当前加载的ui跟节点
return function (ui)
    ---@type UI.Button
    local bt1 = ui:findChild({"Button_36"})
    bt1:SetCallback_MouseClick(function ()
        ---@type UI.PageView
        local page = ui:findChild({"PageView_4"})
        page:scrollToPage(page:getCurrentPageIndex()-1)
    end)

    ---@type UI.Button
    local bt1 = ui:findChild({"Button_36_0"})
    bt1:SetCallback_MouseClick(function ()
        ---@type UI.PageView
        local page = ui:findChild({"PageView_4"})
        page:scrollToPage(page:getCurrentPageIndex()+1)
    end)
end