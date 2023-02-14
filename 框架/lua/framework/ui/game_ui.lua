local japi = require "framework.dzapi"
require "framework.ui.uibase"

---画板,就是DzGetGameUI
---@class GameUI:UI.UIBase
local GameUI = Class("GameUI", UI.UIBase)

---创建新实例
---@return GameUI
function GameUI.new()
    return GameUI._new()
end

---构造函数
function GameUI:ctor()
    self._name = "GameUI"
    self._frameid = japi.DzGetGameUI()
    self._width = 0.8
    self._height = 0.6
    self._tag = 0
    self._anchorType = UI.AnchorType.LEFT_BOTTOM
    self._parentAnchorType = UI.AnchorType.LEFT_BOTTOM
    self._scale = 1
    self._x = 0
    self._y = 0
    self._alpha = 255
    self._visible = true
    self._enable = false
    self._parent = nil
    self._children = {}
    self._event = nil
end

UI.GameUI = GameUI.new()

return UI.GameUI