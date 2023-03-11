---单位总类
---@class Unit
Unit = {}

local _units = {}

function Unit.register(unit)
    _units[unit:getHandle()] = unit
end

function Unit.unRegister(handle)
    _units[handle] = nil
end

return Unit