require "framework.functions"
local Map = require "framework.container.map"

---@class EventGroup
---@field _new function
---事件组
local EventGroup = Class("EventGroup")

---创建新实例
---@return EventGroup
function EventGroup.new() return EventGroup._new() end

---构造函数
function EventGroup:ctor()
    self._do_list = {}
    self._data = Map.new()
    self._debug = {}
end

local function _no_conv(data) return data end

---添加
---@param id integer | string
---@param data any
---@param callback function | nil 转换数据函数
function EventGroup:Add(id, data, callback)
    callback = callback or _no_conv
    table.insert(self._do_list, function()
        local d = callback(data)
        if d then self._data[id]=d end
    end)
end

---查找
---@param id integer | string
---@return any
function EventGroup:Find(id)
    local data = self._data
    return data[id]
end

---移除
---@param id integer | string
---@param fn function | nil 处理数据回调
---@param err function | nil 错误回调
function EventGroup:Remove(id, fn, err)
    table.insert(self._do_list, function()
        local data = self._data
        local iter = data[id]
        if iter ~= nil then
            data[id] = nil
            if fn then fn(id, iter:GetValue()) end
        else
            if err then err() end
        end
    end)
end

---获得当前所有数据
---@return Map
---@param with boolean | nil 是否更新列表,不传默认为更新
function EventGroup:Get(with)
    -- 处理
    if with ~= false then
        for k, v in ipairs(self._do_list) do v() end
        self._do_list = {}
    end

    return self._data
end

return EventGroup
