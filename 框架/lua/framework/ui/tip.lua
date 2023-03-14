local Serialize = require "framework.serialize"
require "framework.ui.layer"
local UIParser = require "framework.ui.uiparser"

---@class UI.TipUI:UI.Panel
---提示
local TipUI = Class("TipUI", UI.Layer)

local _align_group = {
    [UI.AnchorType.LEFT_TOP] = 0,
    [UI.AnchorType.TOP] = 1,
    [UI.AnchorType.RIGHT_TOP] = 2,
    [UI.AnchorType.LEFT] = 0,
    [UI.AnchorType.CENTET] = 1,
    [UI.AnchorType.RIGHT] = 2,
    [UI.AnchorType.LEFT_BOTTOM] = 0,
    [UI.AnchorType.BOTTOM] = 1,
    [UI.AnchorType.RIGHT_BOTTOM] = 2
}

local function _refresh(self)
    self._refresh = true
    local padding = self._padding
    local lines = {}
    local line = {
        left_width = 0,
        left_items = {},
        center_width = 0,
        center_items = {},
        right_width = 0,
        right_items = {},
        width = 0,
        height = 0
    }
    local tmp
    for _, v in ipairs(self._items) do
        tmp = _align_group[v.style.align]
        if tmp == 0 then
            -- 左面控件
            table.insert(line.left_items, v)
            line.left_width = line.left_width + v.ui:getWidth() +
                v.style.padding.left + v.style.padding.right
        elseif tmp == 1 then
            -- 中间控件
            table.insert(line.center_items, v)
            line.center_width = line.center_width + v.ui:getWidth() +
                v.style.padding.left + v.style.padding.right
        else
            -- 右面控件
            -- 中间控件
            table.insert(line.right_items, 1, v)
            line.right_width = line.right_width + v.ui:getWidth() +
                v.style.padding.left + v.style.padding.right
        end
        tmp = v.ui:getHeight() + v.style.padding.top +
            v.style.padding.bottom
        if line.height < tmp then line.height = tmp end
        if v.style.br then
            line.width = line.left_width + line.center_width + line.right_width
            table.insert(lines, line)
            line = {
                left_width = 0,
                left_items = {},
                center_width = 0,
                center_items = {},
                right_width = 0,
                right_items = {},
                height = 0
            }
        end
    end
    if line.height > 0 then
        line.width = line.left_width + line.center_width + line.right_width
        table.insert(lines, line)
    end
    -- 计算控件大小
    local width = 0
    local height = 0
    for _, v in ipairs(lines) do
        if width < v.width then width = v.width end
        height = height + v.height
    end
    self:setSize(width + padding.left + padding.right,
        height + padding.top + padding.bottom)
    local x
    local y = padding.top
    ---@type UI.UIBase
    local ui
    local style
    local offsetY
    for _, v in ipairs(lines) do
        x = padding.left
        for _, l_item in ipairs(v.left_items) do
            ui = l_item.ui
            style = l_item.style
            if style.align == UI.AnchorType.LEFT then
                offsetY = (v.height - ui:getHeight()) / 2
            elseif style.align == UI.AnchorType.LEFT_BOTTOM then
                offsetY = (v.height - ui:setHeight())
            else
                offsetY = style.padding.top
            end
            ui:setPoint(UI.AnchorType.LEFT_TOP,
                UI.AnchorType.LEFT_TOP, x + style.padding.left,
                -(y + offsetY))
            x = x + ui:getWidth() + style.padding.left +
                style.padding.right
        end
        x = (width / 2) - (v.center_width / 2)
        for _, l_item in ipairs(v.center_items) do
            ui = l_item.ui
            style = l_item.style
            if style.align == UI.AnchorType.LEFT then
                offsetY = (v.height - ui:getHeight()) / 2
            elseif style.align == UI.AnchorType.LEFT_BOTTOM then
                offsetY = (v.height - ui:getHeight())
            else
                offsetY = style.padding.top
            end
            ui:setPoint(UI.AnchorType.LEFT_TOP,
                UI.AnchorType.LEFT_TOP, x + style.padding.left,
                -(y + offsetY))
            x = x + ui:getWidth() + style.padding.left +
                style.padding.right
        end
        x = padding.right
        for _, l_item in ipairs(v.right_items) do
            ui = l_item.ui
            style = l_item.style
            if style.align == UI.AnchorType.RIGHT then
                offsetY = (v.height - ui:getHeight()) / 2
            elseif style.align == UI.AnchorType.RIGHT_BOTTOM then
                offsetY = (v.height - ui:getHeight())
            else
                offsetY = style.padding.top
            end
            ui:setPoint(UI.AnchorType.RIGHT_TOP,
                UI.AnchorType.RIGHT_TOP, -(x + style.padding.right),
                -(y + offsetY))
            x = x + ui:getWidth() + style.padding.left +
                style.padding.right
        end
        y = y + v.height
    end
    self._refresh = false
end

---创建新实例
---@param parent UI.UIBase
---@return UI.TipUI
function TipUI.new(name, parent, filename, template) return TipUI._new(name, parent, filename, template) end

function TipUI:ctor(name, parent, filename, template)
    UI.Layer.ctor(self, name, parent)

    local f = io.open(filename, "r")
    if f == nil then
        error("TIP模板文件不存在:" .. filename)
    end
    local buffer = f:read("a")
    f:close()
    local data = Serialize.unSerialize(buffer)
    local children = data.children
    if children == nil then
        error("TIP模板文件不包含任何界面")
    end
    local uidata
    for index, value in ipairs(children) do
        if template == value.name then
            uidata = value
            break
        end
    end
    if uidata == nil then
        error("模板不存在:" .. template)
    end
    self._data = data


    UIParser.LoadNode(uidata, nil, nil, self)
    self._refresh = false
    self._padding = {
        left = 0,
        top = 0,
        right = 0,
        bottom = 0
    }
    self._items = {}
end

function TipUI:setPadding(left, top, right, bottom)
    self._padding = {
        left = left,
        top = top,
        right = right,
        bottom = bottom
    }
end

local function _updateContent(self)
    self._updateContent = true
    UI.AddUpdate(function()
        if self._updateContent then
            self._updateContent = false

            _refresh(self)
        end
    end)
end

local function hookUI(self, ui)
    local oldSetSize = ui.setSize
    ui.setSize = function(s, width, height)
        oldSetSize(s, width, height)
        if self._refresh == false then
            _updateContent(self)
        end
    end

    if IsKindOf(ui, "Text") then
        local oldSetText = ui.setText
        ui.setText = function(s, text)
            oldSetText(s, text)
            if ui._autoSize==false then
                ui:refreshAutoSize()
            end
            _updateContent(self)
        end
    end
end

function TipUI:addItem(name, template, align, br, left, top, right, bottom)
    local children = self._data.children
    local uidata
    for index, value in ipairs(children) do
        if template == value.name then
            uidata = value
            break
        end
    end
    local ui = UIParser.LoadNode(uidata, self, name)
    table.insert(self._items, {
        ui = ui,
        style = {
            padding = {
                left = left,
                top = top,
                right = right,
                bottom = bottom,
            },
            align = align,
            br = br
        }
    })

    hookUI(self, ui)
    _updateContent(self)

    return ui
end

function TipUI:destroy()
    local items = self._items
    self._items = nil
    for index, value in ipairs(items) do
        value.ui:destroy()
    end
    UI.Layer.destroy(self)
end

UI.TipUI = TipUI

return UI.TipUI
