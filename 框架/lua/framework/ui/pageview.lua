require "framework.ui.scrollview"
local japi = require "framework.dzapi"

---@class UI.PageView:UI.ScrollView
---翻页面板
UI.PageView = Class("PageView", UI.ScrollView)

---创建新实例
---@param name string 名字
---@param parent UI.UIBase
---@param isClip boolean 是否裁剪
---@return UI.PageView
function UI.PageView.new(name,parent,isClip)
    return UI.PageView._new(name,parent,isClip)
end

---构造函数
---@param name string 名字
---@param parent UI.UIBase 父控件
function UI.PageView:ctor(name, parent,isClip)
    UI.ScrollView.ctor(self,name,parent,isClip)

    self._cur_index = 1
    self._index = 1
end

-- ---添加页
-- ---@param page UI.Panel
-- function UI.PageView:addPage(page)
--     -- if page.__class ~= "Panel" then
--     --     error("PageView只能添加Panel控件")
--     -- end
--     local name = page:getName()
--     if self._children[name] ~= nil then
--         print("set parent:parent ~= nil :" .. name)
--         print(debug.traceback())
--     end
--     self._children[name] = page
--     --添加顺序序列
--     table.insert(self._children,page)
-- end

-- ---添加页
-- ---@param name string
-- function UI.PageView:removePage(name)
--     local child = self._children[name]
--     if child then
--         self._children[name] = nil
--         child:destroy()
--     end
-- end

-- ---添加页
-- ---@param index integer
-- function UI.PageView:removePageAtIndex(index)
--     local child = self._children[index]
--     if child then
--         self._children[child:getName()] = nil
--         table.removebyvalue(self._children,child)
--         child:destroy()
--     end
-- end

-- function UI.PageView:removeAllPages()
--     local children = self._children
--     self._children = {}
--     for index, child in SafePairs(children) do child:destroy() end
-- end

---获得页
---@param index integer
---@return UI.Panel
function UI.PageView:getPage(index)
    return self._children[index]
end

---添加子控件,这个函数不提供给外部使用
---@param child UI.UIBase UI
function UI.PageView:_addChild(child)
    if self._innerSize then
        self._innerSize.width = self._width*(#self._children+1)
        self._innerSize.height = self._height
    end
    UI.ScrollView._addChild(self,child)
end

---移除子窗口
---@param child UI.UIBase 子窗口
function UI.PageView:_removeChild(child)
    UI.ScrollView._removeChild(self,child)
    self._innerSize.width = self._width*#self._children
end

---获得页数
function UI.PageView:getPageNumber()
    return #self._children
end



-- ---移除所有子窗口
-- function UI.PageView:removeAllChild()
--     self:removeAllPages()
-- end

---更新内页位置
---@param self UI.PageView
local function _updateInnerPos(self)
    self._updateInnerPos = true
    UI.AddUpdate(function ()
        if self._updateInnerPos then
            self._updateInnerPos = false

            local x = -(self._index-1)*self._width
            self._inner:setPosition(x,0)
        end
    end)
end

---移动到页
function UI.PageView:scrollToPage(index)
    if self._index == index then
        return
    end
    if self._children[index]==nil then
        return
    end
    self._index = index
    _updateInnerPos(self)
end

---移动到页
function UI.PageView:getCurrentPageIndex()
    return self._index
end
