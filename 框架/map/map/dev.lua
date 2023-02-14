        local japi = require "jass.japi"
        if japi.XMSourcePath then
            local path = japi.XMSourcePath()
            if path~='' then
                package.path = package.path..';'..path..'/?.lua;'
            else
                local console = require "jass.console"
                console.enable = true
                for i=1,10 do
                    console.write('没有找到工程路径')
                end
            end
        end
    