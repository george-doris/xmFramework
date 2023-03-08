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
        path = path .. [[\]]
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

function fs.pathAppend(path,file)
    if string.sub(path,-1)~=[[\]] then
        path = path .. [[\]]
    end
    return path..file
end

function fs.pathFileExists(path)
    local f,err=io.open(path,"rb")
    if f~=nil then 
        io.close(f) 
    end
    return string.find(err or "","such")~=nil
end

function fs.fileExists(file)
    local f=io.open(file,"rb")
    if f~=nil then io.close(f) return true else return false end
end

function fs.directoryExists(directory)
    local filename = fs.removeBackslash(directory)
    local f,err=io.open(filename,"rb")
    if f~=nil then
        f:close()
        return false
    end
    if string.find(err or "","such")~=nil then
        return false
    end
    return true
end

function fs.createDirectory(directory)
    if not fs.directoryExists(directory) then
        fs.createDirectory(fs.removeFileSpec(fs.removeBackslash(directory)))
        os.execute("mkdir ".. directory)
    end
end

function fs.copyFile(src,dest)
    local rf = io.open(src,"rb") --使用“rb”打开二进制文件，如果是“r”的话，是使用文本方式打开，遇到‘0’时会结束读取
    if rf==nil then
        return
    end
    local len = rf:seek("end")  --获取文件长度
    rf:seek("set",0)--重新设置文件索引为0的位置
    local data = rf:read(len)  --根据文件长度读取文件数据
    rf:close()
    local wf = io.open(dest,"wb")  --用“wb”方法写入二进制文件
    if wf==nil then
        return
    end
    wf:write(data,len)
    wf:close()
end

return fs