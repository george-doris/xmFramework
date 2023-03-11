SafePairs = pairs

local function dump_value_(v)
    if type(v) == "string" then v = "\"" .. v .. "\"" end
    return tostring(v)
end

function Dump(value, desciption, nesting)
    if type(nesting) ~= "number" then nesting = 3 end

    local lookupTable = {}
    local result = {}

    local traceback = string.split(debug.traceback("", 2), "\n")
    print("dump from: " .. string.trim(traceback[3]))

    local function dump_(value, desciption, indent, nest, keylen)
        desciption = desciption or "<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
        end
        if type(value) ~= "table" then
            result[#result + 1] = string.format("%s%s%s = %s", indent,
                dump_value_(desciption), spc,
                dump_value_(value))
        elseif lookupTable[tostring(value)] then
            result[#result + 1] = string.format("%s%s%s = *REF*", indent,
                dump_value_(desciption), spc)
        else
            lookupTable[tostring(value)] = true
            if nest > nesting then
                result[#result + 1] = string.format("%s%s = *MAX NESTING*",
                    indent,
                    dump_value_(desciption))
            else
                result[#result + 1] = string.format("%s%s = {", indent,
                    dump_value_(desciption))
                local indent2 = indent .. "    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in SafePairs(value) do
                    keys[#keys + 1] = k
                    local vk = dump_value_(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    dump_(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result + 1] = string.format("%s}", indent)
            end
        end
    end

    dump_(value, desciption, "- ", 1)

    for i, line in ipairs(result) do print(line) end
end

local setmetatableindex_
setmetatableindex_ = function(t, index)
    local mt = getmetatable(t)
    if not mt then mt = {} end
    if not mt.__index then
        mt.__index = index
        setmetatable(t, mt)
    elseif mt.__index ~= index then
        setmetatableindex_(mt, index)
    end
end
SetMetatableIndex = setmetatableindex_

---定义类
---comment
---@param classname string 类名
---@param ... any 父类,父类,父类....
---@return any 类实例
function Class(classname, ...)
    local cls = { __cname = classname }

    local supers = { ... }
    for _, super in ipairs(supers) do
        local superType = type(super)
        assert(superType == "nil" or superType == "table" or superType == "function",
            string.format("class() - create class \"%s\" with invalid super class type \"%s\"",
                classname, superType))

        if superType == "function" then
            assert(cls.__create == nil,
                string.format("class() - create class \"%s\" with more than one creating function",
                    classname));
            -- if super is function, set it to __create
            cls.__create = super
        elseif superType == "table" then
            if super[".isclass"] then
                -- super is native class
                assert(cls.__create == nil,
                    string.format("class() - create class \"%s\" with more than one creating function or native class",
                        classname));
                cls.__create = function() return super:create() end
            else
                -- super is pure lua class
                cls.__supers = cls.__supers or {}
                cls.__supers[#cls.__supers + 1] = super
                if not cls.super then
                    -- set first super pure lua class as class.super
                    cls.super = super
                end
            end
        else
            error(string.format("class() - create class \"%s\" with invalid super type",
                classname), 0)
        end
    end

    cls.__index = cls
    if not cls.__supers or #cls.__supers == 1 then
        setmetatable(cls, { __index = cls.super })
    else
        setmetatable(cls, {
            __index = function(_, key)
                local supers = cls.__supers
                for i = 1, #supers do
                    local super = supers[i]
                    if super[key] then return super[key] end
                end
            end
        })
    end

    if not cls.ctor then
        -- add default constructor
        cls.ctor = function()
        end
    end
    cls._new = function(...)
        local instance
        if cls.__create then
            instance = cls.__create(...)
        else
            instance = {}
        end
        SetMetatableIndex(instance, cls)
        instance.class = cls
        instance:ctor(...)
        return instance
    end
    cls.new = cls._new
    cls.create = function(_, ...)
        return cls._new(...)
    end

    return cls
end

function ClassQ()
    local cls = {}

    cls._new = function(...)
        local instance = {}
        SetMetatableIndex(instance, cls)
        instance:ctor(...)
        return instance
    end
    cls.new = cls._new

    return cls
end

local iskindof_
iskindof_ = function(cls, name)
    local __index = rawget(cls, "__index")
    if type(__index) == "table" and rawget(__index, "__cname") == name then return true end

    if rawget(cls, "__cname") == name then return true end
    local __supers = rawget(__index, "__supers")
    if not __supers then return false end
    for _, super in ipairs(__supers) do
        if iskindof_(super, name) then return true end
    end
    return false
end

---检索是否继承类
---@param obj any 类
---@param classname string 类名
---@return boolean 是否继承
function IsKindOf(obj, classname)
    local t = type(obj)
    if t ~= "table" and t ~= "userdata" then return false end

    local mt= getmetatable(obj)
    if mt then
        return iskindof_(mt, classname)
    end
    return false
end

local function checknumber(value, base) return tonumber(value, base) or 0 end

function math.round(value)
    value = checknumber(value)
    return math.floor(value + 0.5)
end

local function checkint(value) return math.round(checknumber(value)) end

function table.clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local newObject = {}
        lookup_table[object] = newObject
        for key, value in SafePairs(object) do
            newObject[_copy(key)] = _copy(value)
        end
        return setmetatable(newObject, getmetatable(object))
    end

    return _copy(object)
end

-- function table.clone(object)
--     local lookup_table = {}
--     local function _copy(object)
--         if type(object) ~= "table" then
--             return object
--         elseif lookup_table[object] then
--             return lookup_table[object]
--         end
--         local newObject = {}
--         lookup_table[object] = newObject
--         for key, value in SafePairs(object) do
--             newObject[_copy(key)] = _copy(value)
--         end
--         return setmetatable(newObject, getmetatable(object))
--     end
--     return _copy(object)
-- end

function table.merge(dest, src) for k, v in SafePairs(src) do dest[k] = v end end

-- table.insert = function (t,v,begin)
--     begin = checkint(begin)
--     if begin <= 0 then begin = #t + 1 end
--     t[begin] = v
-- end

function table.insertto(dest, src, begin)
    begin = checkint(begin)
    if begin <= 0 then begin = #dest + 1 end

    local len = #src
    for i = 0, len - 1 do dest[i + begin] = src[i + 1] end
end

function table.indexof(array, value, begin)
    for i = begin or 1, #array do if array[i] == value then return i end end
    return nil
end

function table.find(array, fn, begin)
    for i = begin or 1, #array do if fn(i, array[i]) then return i end end
    return nil
end

-- function table.keyof(hashtable, value)
--     for k, v in SafePairs(hashtable) do
--         if v == value then return k end
--     end
--     return nil
-- end

function table.removebyvalue(array, value, removeall)
    local c, i, max = 0, 1, #array
    while i <= max do
        if array[i] == value then
            table.remove(array, i)
            c = c + 1
            i = i - 1
            max = max - 1
            if not removeall then break end
        end
        i = i + 1
    end
    return c
end

function table.nums(t)
    local count = 0
    for _, _ in SafePairs(t) do count = count + 1 end
    return count
end

function table.shuffle(t)
    local total = #t
    local i
    local ret = {}

    while total > 0 do
        i = math.random(1, total)
        table.insert(ret, t[i])
        t[i] = t[total]
        total = total - 1
    end
    return ret
end

function table.shufflea(t)
    local total = #t
    local i
    local ret = {}

    while total > 0 do
        i = math.randoma(1, total)
        table.insert(ret, t[i])
        t[i] = t[total]
        total = total - 1
    end
    return ret
end

--[[------------------------------------------------------------------------------
-** 设置table只读 出现改写会抛出lua error
-- 用法 local cfg_proxy = read_only(cfg) retur cfg_proxy
-- 增加了防重置设置read_only的机制
-- lua5.3支持 1）table库支持调用元方法，所以table.remove table.insert 也会抛出错误，
--  2）不用定义__ipairs 5.3 ipairs迭代器支持访问元方法__index，pairs迭代器next不支持故需要元方法__pairs
-- 低版本lua此函数不能完全按照预期工作
*]]
function table.read_only(inputTable)
    local travelled_tables = {}
    local function __read_only(tbl)
        if not travelled_tables[tbl] then
            local tbl_mt = getmetatable(tbl)
            if not tbl_mt then
                tbl_mt = {}
                setmetatable(tbl, tbl_mt)
            end

            local proxy = tbl_mt.__read_only_proxy
            if not proxy then
                proxy = {}
                tbl_mt.__read_only_proxy = proxy
                local proxy_mt = {
                    __index = tbl,
                    __newindex = function(t, k, v)
                        error("error write to a read-only table with key = " ..
                            tostring(k))
                    end,
                    __pairs = function(t) return SafePairs(tbl) end,
                    -- __ipairs = function (t) return ipairs(tbl) end, 5.3版本不需要此方法
                    __len = function(t) return #tbl end,
                    __read_only_proxy = proxy
                }
                setmetatable(proxy, proxy_mt)
            end
            travelled_tables[tbl] = proxy
            for k, v in SafePairs(tbl) do
                if type(v) == "table" then
                    tbl[k] = __read_only(v)
                end
            end
        end
        return travelled_tables[tbl]
    end

    return __read_only(inputTable)
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == '') then return false end
    local pos, arr = 0, {}
    -- for each divider found
    for st, sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

function string.utf8len(input)
    local len = string.len(input)
    local left = len
    local cnt = 0
    local arr = { 0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc }
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

function string.trim(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

Path = {}
-- 获取路径
function Path.Directory(filename)
    return string.match(filename, "(.+)[/\\][^/\\]*%.%w+$") -- *nix system
end

-- 获取文件名
function Path.Filename(filename)
    return string.match(filename, ".-[/\\]-([^/\\]*%.%w+)$") -- *nix system
end

-- 去除扩展名
function Path.RemoveExtension(filename)
    local idx = filename:match(".+()%.%w+$")
    if (idx) then
        return filename:sub(1, idx - 1)
    else
        return filename
    end
end

-- 获取扩展名
function Path.Extension(filename) return filename:match(".+%.(%w+)$") end

function Serialize(obj)
    local lua = {}
    local t = type(obj)
    if t == "number" then
        table.insert(lua, obj)
    elseif t == "boolean" then
        table.insert(lua, tostring(obj))
    elseif t == "string" then
        table.insert(lua, string.format("%q", obj))
    elseif t == "table" then
        table.insert(lua, "{")
        for k, v in SafePairs(obj) do
            table.insert(lua, "[")
            table.insert(lua, Serialize(k))
            table.insert(lua, "]=")
            table.insert(lua, Serialize(v))
            table.insert(lua, ",")
        end
        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in SafePairs(metatable.__index) do
                table.insert(lua, "[")
                table.insert(lua, Serialize(k))
                table.insert(lua, "]=")
                table.insert(lua, Serialize(v))
                table.insert(lua, ",")
            end
        end
        table.insert(lua, "}")
    elseif t == "nil" then
        return nil
    else
        error("can not serialize a " .. t .. " type.")
    end
    return table.concat(lua)
end

function UnSerialize(lua)
    local t = type(lua)
    if t == "nil" or lua == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        lua = tostring(lua)
    else
        error("can not unserialize a " .. t .. " type.")
    end
    lua = "return " .. lua
    local func = load(lua)
    if func == nil then return nil end
    return func()
end

function NumberEqual(a, b)
    return math.abs(a - b) < 0.0000001
end
