local Serialize = require "framework.serialize"
local UIActionParser = require "framework.ui.uiactionparser"
require "framework.ui.action.action_data_cache"
require "framework.ui.backdrop"
require "framework.ui.imageview"
require "framework.ui.button"
require "framework.ui.text"
require "framework.ui.panel"
require "framework.ui.pageview"
require "framework.ui.loadingbar"
require "framework.ui.slider"
require "framework.ui.textfield"
require "framework.ui.scrollview"
require "framework.ui.listview"
require "framework.ui.checkbox"

local UIParser = {}

---设置基础属性
---@param ui UI.UIBase
---@param root table
local function setBaseProperty(ui, root)
    ui:setSize(root.width, root.height)
    ui:setTag(root.tag)
    ui:setActionTag(root.actionTag)
    if root.alpha < 255 then
        ui:setAlpha(root.alpha)
    end
    if root.color.r < 255 or root.color.g < 255 or root.color.b < 255 or root.color.a < 255 then
        ui:setVertexColor(root.color.r, root.color.g, root.color.b, root.color.a)
    end
    ui:setScale(root.scale.scaleX)
    ui:setVisible(root.visible)
    ui:setAnchorType(root.anchorType)
    ui:setPosition(root.x, root.y)
end

---设置Widget属性
local function setWidgetProperty(ui, root)
    ui:setEnable(root.touchEnable)
end

---设置精灵属性
local function SpriteObjectData(root, parent, name, sui)
    local ui = sui or UI.Backdrop.new(name or root.name, parent)
    setBaseProperty(ui, root)

    ui:setTexture(root.image)
    return ui
end

---设置图片属性
local function ImageViewObjectData(root, parent, name, sui)
    local ui = sui or UI.Backdrop.new(name or root.name, parent)
    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)
    ui:setTexture(root.image)
    return ui
end

---设置按钮属性
local function ButtonObjectData(root, parent, name, sui)
    local ui = sui or UI.Button.new(name or root.name, parent)
    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)

    ui:setDisableImage(root.disableImage)
    ui:setPressedImage(root.pressedImage)
    ui:setNormalImage(root.normalImage)

    ui:setFont(root.font)
    ui:setFontSize(root.fontSize)
    ui:setText(UI.SetTextColor(root.text, root.textColor.r, root.textColor.g, root.textColor.b, root.textColor.a))
    return ui
end

---设置复选框属性
local function CheckBoxObjectData(root, parent, name, sui)
    local ui = sui or UI.CheckBox.new(name or root.name, parent)
    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)

    ui:setDisableImage(root.disableBackImage)
    ui:setPressedImage(root.pressedBackImage)
    ui:setNormalImage(root.normalBackImage)

    ui:setNodeDisableImage(root.nodeDisableImage)
    ui:setNodeNormalImage(root.nodeNormalImage)

    ui:setCheckState(root.checkState)

    return ui
end



---设置文字属性
local function TextObjectData(root, parent, name, sui)
    local ui = sui or UI.Text.new(name or root.name, parent)
    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)

    ui:setText(UI.SetTextColor(root.text, root.textColor.r, root.textColor.g, root.textColor.b, root.textColor.a))
    ui:setFont(root.font)
    ui:setFontSize(root.fontSize)
    ui:setTextAlignment(root.alignmentType)
    ui:setFontStyle(0)
    ui:setOutlineEnabled(root.outlineSize)

    if root.autoSize then
        ui:setAutoSize(0)
    end

    ui:setShadowColor(root.shadowColor.r, root.shadowColor.g, root.shadowColor.b, root.shadowColor.a)
    ui:setShadowOffset(root.shadowOffset.x, root.shadowOffset.y)
    ui:setShadowEnabled(root.shadowEnabled)
    return ui
end

---设置进度条属性
local function LoadingBarObjectData(root, parent, name, sui)
    local ui = sui or UI.LoadingBar.new(name or root.name, parent)
    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)

    ui:setDirection(root.direction)
    ui:setProgressType(root.progressType)

    ui:setTexture(root.image)
    ui:setValue(root.progress / 100)
    return ui
end

---设置滑动条属性
---@param root table
---@param parent UI.UIBase
---@return UI.Slider|nil
local function SliderObjectData(root, parent, name, sui)
    local ui = sui or UI.Slider.new(name or root.name, parent)
    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)

    ui:setDirection(root.direction)
    ui:setTexture(root.backGround)
    ui:setProgressBarImage(root.progressBar)
    ui:setButtonNormal(root.ballNormal)
    ui:setButtonPressed(root.ballPressed)
    ui:setButtonDisabled(root.ballDisabled)
    ui:setValue(root.value / 100)

    if string.sub(ui:getName(), 1, 10) == "[Vertical]" then
        UI.AddUpdate(function()
            --垂直滚动条
            ---@type UI.ScrollView
            local pui = parent:findChild(root.callBackName)
            if pui then
                pui:setVerticalScrollbar(ui)
            end
        end)
    end
    if string.sub(ui:getName(), 1, 12) == "[Horizontal]" then
        UI.AddUpdate(function()
            --水平滚动条
            ---@type UI.ScrollView
            local pui = parent:findChild(root.callBackName)
            if pui then
                pui:setHorizontalScrollbar(ui)
            end
        end)
    end

    return ui
end

---设置面板属性
local function TextFieldObjectData(root, parent, name, sui)
    local ui = sui or UI.TextField.new(name or root.name, parent)
    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)

    ui:setText(root.text)
    ui:setFont(root.font)
    ui:setFontSize(root.fontSize)
    ui:setTextAlignment(UI.TextAlign.LEFT|UI.TextAlign.TOP)
    ui:setFontStyle(root.outlineSize)

    if root.maxLengthEnable then
        ui:setMaxLength(root.maxLengthText)
    end
    return ui
end

---设置面板属性
local function PanelObjectData(root, parent, name, sui)
    local ui = sui or UI.Panel.new(name or root.name, parent, root.clip)

    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)
    if root.scale9 then
        ui:setScale9(root.scale9)
    end
    if root.image then
        ui:setTextureSize(root.image_width, root.image_height)
        ui:setTexture(root.image)
    end

    return ui
end

---设置面板属性
local function ScrollViewObjectData(root, parent, name, sui)
    local ui = sui or UI.ScrollView.new(name or root.name, parent, root.clip)

    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)
    ui:setTextureSize(root.image_width, root.image_height)
    ui:setScale9(root.scale9)
    if root.image then
        ui:setTexture(root.image)
    end

    ui:setInnerSize(root.innerNodeSize.width, root.innerNodeSize.height)
    return ui
end

---设置翻页面板属性
local function PageViewObjectData(root, parent, name, sui)
    local ui = sui or UI.PageView.new(name or root.name, parent, root.clip)

    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)
    ui:setTextureSize(root.image_width, root.image_height)
    ui:setScale9(root.scale9)
    if root.image then
        ui:setTexture(root.image)
    end
    return ui
end

---设置列表面板属性
local function ListViewObjectData(root, parent, name, sui)
    local ui = sui or UI.ListView.new(name or root.name, parent, root.clip)

    setBaseProperty(ui, root)
    setWidgetProperty(ui, root)
    ui:setTextureSize(root.image_width, root.image_height)
    ui:setScale9(root.scale9)
    if root.image then
        ui:setTexture(root.image)
    end

    ui:setDirectionType(root.directionType)
    ui:setContentAlign(root.contentAlign)
    ui:setItemMargin(root.itemMargin)
    return ui
end

local function ProjectNodeObjectData(root, parent)
    local f = io.open(root.file, "r")
    if f == nil then
        if f == nil then
            error("层文件不存在:" .. root.file)
            return 0
        end
    end
    local buffer = f:read("a")
    f:close()
    local data = Serialize.unSerialize(buffer)

    local ui = UI.Layer.new(root.name, parent)
    UIParser.LoadChildren(data.children, ui)
    setBaseProperty(ui, root)

    local actionData = UI.Action.ActionDataCache:Load(root.file, data)
    ui._actionData = actionData
    --UIActionParser.Load(ui,actionData)

    if data.userData then
        local fn = require(data.userData)
        fn(ui)
    end

    return ui
end

local _factory = {
    SpriteObjectData = SpriteObjectData,
    ImageViewObjectData = ImageViewObjectData,
    ButtonObjectData = ButtonObjectData,
    CheckBoxObjectData = CheckBoxObjectData,
    TextObjectData = TextObjectData,
    LoadingBarObjectData = LoadingBarObjectData,
    SliderObjectData = SliderObjectData,
    TextFieldObjectData = TextFieldObjectData,
    PanelObjectData = PanelObjectData,
    ScrollViewObjectData = ScrollViewObjectData,
    PageViewObjectData = PageViewObjectData,
    ListViewObjectData = ListViewObjectData,
    ProjectNodeObjectData = ProjectNodeObjectData,
}

---查找解析工厂
local function getFactory(ctype)
    return _factory[ctype]
end

local function loadChildren(children, parent)
    local ui
    for index, value in ipairs(children) do
        local fn = getFactory(value.ctype)
        if fn then
            ui = fn(value, parent)
            if ui ~= nil and value.children ~= nil then
                UIParser.LoadChildren(value.children, ui)
            end
        else
            error("未知UI类型" .. value.ctype)
        end
    end
end

local function LoadNode(data, parent, name, ui)
    local fn = getFactory(data.ctype)
    if fn then
        ui = fn(data, parent, name, ui)
        if ui ~= nil and data.children ~= nil then
            loadChildren(data.children, ui)
        end
    else
        error("未知UI类型" .. data.ctype)
    end
    return ui
end

UIParser.LoadChildren = loadChildren
UIParser.LoadNode = LoadNode

return UIParser
