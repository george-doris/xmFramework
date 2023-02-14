--操作文件和路径类

local fs = {}

--规范化路径 将所有/换成\
function fs.canonicalize(path)
    return string.gsub(path, [[/]], [[\]])
end

--去除路径最后的反斜杠“\”
function fs.removeBackslash(path)
    if string.sub(path,-1)==[[\]] then
        path = string.sub(path,1,-2)
    end
    return path
end

--在路径最后加上反斜杠“\”
function fs.addBackslash(path)
    if string.sub(path,-1)~=[[\]] then
        path = path + [[\]]
    end
    return path
end

--去除文件名，得到目录
function fs.removeFileSpec(path)
    local tmp = string.reverse(path)
    path = string.sub(path,1,-string.find(tmp,[[\]],1,true))
    return path
end

--去除后缀名
function fs.removeExtension(path)
    local tmp = string.reverse(path)
    local pos = string.find(tmp,[[.]],1,true)
    if pos>0 then
        path = string.sub(path,1,-pos-1)
    end
    return path
end

--去除后缀名
function fs.renameExtension(path,ext)
    local tmp = string.reverse(path)
    local pos = string.find(tmp,[[.]],1,true)
    if pos>0 then
        path = string.sub(path,1,-pos-1)..ext
    end
    return path
end

return fs