require "framework.functions"
local CJ = require "jass.common"
local japi = require "framework.dzapi"

---单位操作类
---@class Unit
local Unit = {}

Unit.SetOwner = CJ.SetUnitOwner

--------------------------------------
Unit.CreateUnit = CJ.CreateUnit
Unit.CreateCorpse = CJ.CreateCorpse
Unit.CreateBlightedGoldmine = CJ.CreateBlightedGoldmine
Unit.CreatePermanentCorpseLocBJ = CreatePermanentCorpseLocBJ
return Unit