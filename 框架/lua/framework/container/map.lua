
---有序容器
---@class Map
local Map = {}

local Dev = require "framework.dev"
if Dev.HasXMLib() then
    --内置
    local cmap = require "cmap"
    Map.new = cmap.new
else
    --lua实现
    local MapImpl = require "framework.container.map_impl"

    local function _index(tb, key)
        local map = rawget(tb,"_mapImpl")
        local iter = map:Find(key)
        if iter~=map:End() then
            return iter._value
        end
        return nil
    end

    local function _newindex(tb, key, value)
        local map = rawget(tb,"_mapImpl")
        if value~=nil then
            map:Add(key,value)
        else
            local iter = map:Find(key)
            if iter~=map:End() then
                map:Remove(iter)
            end
        end
    end

    local function _createPairs(tb, key)
        local map = rawget(tb,"_mapImpl")
        return map:Enum()
    end

    Map.new = function ()
        local instance = {}
        setmetatable(instance, {
            __index = _index,
            __newindex = _newindex,
            __pairs = _createPairs,
        })
        rawset(instance,"_mapImpl",MapImpl.new())
        return instance
    end
end

return Map