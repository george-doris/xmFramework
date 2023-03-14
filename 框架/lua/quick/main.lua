require "framework.init"
local CJ = require "jass.common"
local development = require "quick.development"
--判断是否是开发模式
if development.isDebug() then
    --加载运行时调试
    require "quick.runtime_init"

    ---设置资源目录
    development.SetResourcePath()

    
    --延迟初始化可以调试Init函数
    CJ.TimerStart(CJ.CreateTimer(), 1, false, function()
        CJ.DestroyTimer(CJ.GetExpiredTimer())
        require "main"
    end)
else
    require "main"
end
