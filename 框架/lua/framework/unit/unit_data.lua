
require "framework.unit.common"
local CJ = require "jass.common"
local JassHelper = require "framework.jass_helper"

---@class UI.UnitData
---@field _new function
---单位基础类
local UnitData = Class("UnitData")


---构造函数
function UnitData:ctor(player_id)
    self._player_id = player_id
    self._unit = nil
end

---创建单位
---@param x number x坐标
---@param y number y坐标
---@return unit @单位
function UnitData:CreateUnit(typeid, x, y, face)
    typeid = JassHelper.SToId(typeid)
    self:RemoveUnit()
    self.typeid = typeid
    face = face or 0
    local unit = CJ.CreateUnit(CJ.Player(self._player_id), typeid, x, y, face)
    if unit then
        self.unit = unit
        Unit.register(self)
    end

    return unit
end

function UnitData:RemoveUnit()
    if self.unit then
        Unit.unRegister(self:getHandle())
        CJ.RemoveUnit(self.unit)
        self.unit = nil
    end
end

function UnitData:getHandle()
    return self._unit
end

UI.UnitData = UnitData

return UI.UnitData