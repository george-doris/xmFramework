local japi = require "framework.dzapi"

---@class Development
local Development = {}

function Development.isDebug()
    return japi.XMSourcePath~=nil
end

function Development.SetResourcePath()
    --获得lua源码路径,源码路径是带lua目录的
    local path = japi.XMSourcePath()
    if path=="" then
        return
    end
    local fs = require "framework.file_system"
    --规范化路径, "/"换成"\"
    path = fs.canonicalize(path)
    --去除路径最后的 "\"
    path = fs.removeBackslash(path)
    --去除最后一个文件夹
    path = fs.removeFileSpec(path)
    
    --内置
    local fileUtils = cc.FileUtils:getInstance()
    --资源跟目录
    fileUtils:setDefaultResourceRootPath(path)
    --资源下级目录
    fileUtils:addSearchPath("map/map")
    fileUtils:addSearchPath("map/resource")
end

return Development