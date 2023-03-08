---场景初始化,这是在UI编辑器里第一个节点的用户数据自动调用当前文件
---@param ui UI.Layer 当前加载的ui跟节点
return function (ui)
    
    local loop_play
    loop_play = function ()
        ui:playAction("animation0",false,loop_play)
    end
    loop_play()
end