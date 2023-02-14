---@class MapNode
---@field _Isnil boolean
---@field _Right MapNode
---@field _Parent MapNode
---@field _Left MapNode
local MapNode = {}

---创建
---@param key string | integer | nil key
---@param value any 值
---@return MapNode
function MapNode.new(key, value)
    local instance = {}
    setmetatable(instance, {
        __index = MapNode
    })
    instance:ctor(key, value)
    return instance
end

---构造函数
---@param key string | integer key
---@param value any 值
function MapNode:ctor(key, value)
    self._key = key
    self._value = value
end

---获得key
---@return string|integer
function MapNode:GetKey()
    return self._key
end

---获得值
---@return any
function MapNode:GetValue()
    return self._value
end

local function _Max(_Pnode)
    while (not _Pnode._Right._Isnil) do
        _Pnode = _Pnode._Right
    end
    return (_Pnode)
end

local function _Min(_Pnode)
    while (not _Pnode._Left._Isnil) do
        _Pnode = _Pnode._Left
    end
    return (_Pnode)
end

---下一个元素
---@return MapNode
function MapNode:Next()
    local iter = self
    if (iter._Right._Isnil) then
        -- climb looking for right subtree
        local _Pnode = iter._Parent
        while (not _Pnode._Isnil and iter == _Pnode._Right) do
            iter = _Pnode -- ==> parent while right subtree
            _Pnode = iter._Parent
        end
        iter = _Pnode -- ==> parent (head if end())
    else
        iter = _Min(iter._Right) -- ==> smallest of right subtree
    end
    return iter
end

---上一个元素
---@return MapNode
function MapNode:Prev()
    local iter = self
    if (iter._Isnil) then
        iter = iter._Right -- end() ==> rightmost
    elseif (iter._Left._Isnil) then
        -- climb looking for left subtree
        local _Pnode = iter._Parent
        while (not _Pnode._Isnil and iter == _Pnode._Left) do
            iter = _Pnode -- ==> parent while left subtree
            _Pnode = iter._Parent
        end

        if (not iter._Isnil) then
            -- decrement non-begin()
            iter = _Pnode -- ==> parent if not head
        end
    else
        iter = _Max(self._Left) -- ==> largest of left subtree
    end

    return iter
end

return MapNode