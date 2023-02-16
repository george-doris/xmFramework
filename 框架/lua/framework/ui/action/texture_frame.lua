

---动画时间线
---@class UI.Action.TextureFrame:UI.Action.Frame
---@field _new function
TextureFrame = Class("TextureFrame",UI.Action.Frame)

---创建新实例
---@return UI.Action.TextureFrame
function TextureFrame.new()
    return TextureFrame._new()
end

---构造函数
function TextureFrame:ctor()
    UI.Action.Frame.ctor(self)
    self._textureName = nil
end

---设置图片
---@param textureName string 图片
function TextureFrame:setTextureName(textureName)
    self._textureName = textureName
end

---获得图片
---@return string 图片
function TextureFrame:getTextureName()
    return self._textureName
end

function TextureFrame:onEnter(nextFrame,currentFrameIndex)
    ---@type UI.Backdrop
    local node = self._node
    if node==nil then
        return
    end
    node:setTexture(self._textureName);
end

UI.Action.TextureFrame = TextureFrame