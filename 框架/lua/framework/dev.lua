local japi = require "framework.dzapi"

function debug.isDebug()
    return japi.XMSourcePath~=nil
end

return debug