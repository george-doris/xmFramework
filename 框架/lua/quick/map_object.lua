require "framework.functions"

---单位
---@class MapObject
---@field _new function
local MapObject = Class('MapObject')

---创建新实例
---@param datas table 数据
---@return EventGroup
function MapObject.new(datas) return MapObject._new(datas) end

---构造函数
---@param datas table 数据
function MapObject:ctor(datas)
   
end


return MapObject