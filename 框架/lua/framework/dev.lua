local japi = require "framework.dzapi"

function debug.isDebug()
    return japi.XMSourcePath~=nil
end

function debug.HasXMLib()
    return japi.XMAddLocalEffect~=nil
end

return debug