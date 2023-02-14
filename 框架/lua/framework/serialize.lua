

local function serialize(obj)
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
            table.insert(lua, serialize(k))
            table.insert(lua, "]=")
            table.insert(lua, serialize(v))
            table.insert(lua, ",")
        end
        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in SafePairs(metatable.__index) do
                table.insert(lua, "[")
                table.insert(lua, serialize(k))
                table.insert(lua, "]=")
                table.insert(lua, serialize(v))
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

local function unSerialize(lua)
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

return {serialize=serialize,unSerialize=unSerialize}