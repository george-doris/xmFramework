local MapNode = require "framework.container.map_node"

---@class MapImpl
---红黑树
local MapImpl = {}

local _Red = 0
local _Black = 1

local _comp = function(_Left, _Right)
    local t1 = type(_Left)
    local t2 = type(_Right)
    if t1 ~= t2 then
        if t1 == "string" then
            return true
        end
        return false
    end
    return _Left < _Right
end

local function _Max(_Pnode)
    while (not _Pnode._Right._Isnil) do
        _Pnode = _Pnode._Right
    end
    return (_Pnode)
end

local function _Min(_Pnode)
    while (not _Pnode._Left._Isnil) do
        _Pnode = _Pnode._Left
    end
    return (_Pnode)
end

---创建
---@return MapImpl
function MapImpl.new()
    local instance = {}
    setmetatable(instance, {
        __index = MapImpl
    })
    instance:ctor()
    return instance
end

---构造函数
function MapImpl:ctor()
    self._Comp = _comp
    local head = MapNode.new()
    head._Left = head
    head._Parent = head
    head._Right = head

    head._Color = _Black
    head._Isnil = true
    self._Myhead = head
    self._Mysize = 0

    self._end = head
end

---第一个元素
---@return MapNode
function MapImpl:Begin()
    return self._Myhead._Left
end

---结束元素
---@return MapNode
function MapImpl:End()
    return self._end
end

local function _Lrotate(self, _Wherenode)
    local _Pnode = _Wherenode._Right
    _Wherenode._Right = _Pnode._Left

    if (not _Pnode._Left._Isnil) then
        _Pnode._Left._Parent = _Wherenode
    end
    _Pnode._Parent = _Wherenode._Parent

    if (_Wherenode == self._Parent) then
        self._Parent = _Pnode
    elseif (_Wherenode == _Wherenode._Parent._Left) then
        _Wherenode._Parent._Left = _Pnode
    else
        _Wherenode._Parent._Right = _Pnode
    end

    _Pnode._Left = _Wherenode
    _Wherenode._Parent = _Pnode
end

local function _Rrotate(self, _Wherenode)
    local _Pnode = _Wherenode._Left
    _Wherenode._Left = _Pnode._Right

    if not _Pnode._Right._Isnil then
        _Pnode._Right._Parent = _Wherenode
    end
    _Pnode._Parent = _Wherenode._Parent

    if (_Wherenode == self._Parent) then
        self._Parent = _Pnode
    elseif (_Wherenode == _Wherenode._Parent._Right) then
        _Wherenode._Parent._Right = _Pnode
    else
        _Wherenode._Parent._Left = _Pnode
    end

    _Pnode._Right = _Wherenode
    _Wherenode._Parent = _Pnode
end

local function _Insert_at(self, _Addleft, _Wherenode, _Node)
    local _Newnode = _Node
    self._Mysize = self._Mysize + 1
    _Newnode._Parent = _Wherenode
    if (_Wherenode == self._Myhead) then
        self._Myhead._Parent = _Newnode
        self._Myhead._Left = _Newnode
        self._Myhead._Right = _Newnode
    elseif _Addleft then
        _Wherenode._Left = _Newnode
        if _Wherenode == self._Myhead._Left then
            self._Myhead._Left = _Newnode
        end
    else
        _Wherenode._Right = _Newnode
        if _Wherenode == self._Myhead._Right then
            self._Myhead._Right = _Newnode
        end
    end

    local _Pnode = _Newnode
    while _Pnode._Parent._Color == _Red do
        if _Pnode._Parent == _Pnode._Parent._Parent._Left then
            _Wherenode = _Pnode._Parent._Parent._Right
            if (_Wherenode._Color == _Red) then
                -- parent has two red children, blacken both
                _Pnode._Parent._Color = _Black
                _Wherenode._Color = _Black
                _Pnode._Parent._Parent._Color = _Red
                _Pnode = _Pnode._Parent._Parent
            else
                --	 parent has red and black children
                if (_Pnode == _Pnode._Parent._Right) then
                    -- rotate right child to left
                    _Pnode = _Pnode._Parent
                    _Lrotate(self._Myhead, _Pnode)
                end

                _Pnode._Parent._Color = _Black -- propagate red up
                _Pnode._Parent._Parent._Color = _Red
                _Rrotate(self._Myhead, _Pnode._Parent._Parent)
            end
        else
            _Wherenode = _Pnode._Parent._Parent._Left
            if (_Wherenode._Color == _Red) then
                _Pnode._Parent._Color = _Black
                _Wherenode._Color = _Black
                _Pnode._Parent._Parent._Color = _Red
                _Pnode = _Pnode._Parent._Parent
            else
                if (_Pnode == _Pnode._Parent._Left) then
                    -- rotate left child to right
                    _Pnode = _Pnode._Parent
                    _Rrotate(self._Myhead, _Pnode)
                end
                _Pnode._Parent._Color = _Black -- propagate red up
                _Pnode._Parent._Parent._Color = _Red
                _Lrotate(self._Myhead, _Pnode._Parent._Parent)
            end
        end
    end
    self._Myhead._Parent._Color = _Black
    return _Newnode
end

local function _Insert_nohint(self, _Leftish, _Newnode)
    local _Wherenode = self._Myhead
    local _Trynode = _Wherenode._Parent
    local _Addleft = true
    while (not _Trynode._Isnil) do
        _Wherenode = _Trynode
        if _Leftish then
            _Addleft = self._Comp(_Trynode._key, _Newnode._key)
        else
            _Addleft = self._Comp(_Newnode._key, _Trynode._key)
        end
        if _Addleft then
            _Trynode = _Trynode._Left
        else
            _Trynode = _Trynode._Right
        end
    end

    local _Where = _Wherenode
    if not _Addleft then
    elseif _Where == self._Myhead._Left then
        return _Insert_at(self, true, _Wherenode, _Newnode)
    else
        _Where = _Where:Prev()
    end

    if self._Comp(_Where._key, _Newnode._key) then
        return _Insert_at(self, _Addleft, _Wherenode, _Newnode)
    else
        return nil
    end
end

local function lower_bound(self, _Keyval)
    local _Wherenode = self._Myhead
    local _Pnode = _Wherenode._Parent

    while (not _Pnode._Isnil) do
        if (self._Comp(_Pnode._key, _Keyval)) then
            _Pnode = _Pnode._Right -- descend right subtree
        else
            -- _Pnode not less than _Keyval, remember it
            _Wherenode = _Pnode
            _Pnode = _Pnode._Left -- descend left subtree
        end
    end

    return _Wherenode
end

---添加元素
---@param key string | integer key
---@param value any 值
---@return MapNode|nil
function MapImpl:Add(key, value)
    local t = type(key)
    if t ~= "number" and t ~= "string" then
        error("MapImpl Add not a number or string")
    end

    local node = MapNode.new(key, value)
    node._Left = self._Myhead
    node._Parent = self._Myhead
    node._Right = self._Myhead

    node._Color = _Red
    node._Isnil = false

    ----------------------------------------------------------------
    return _Insert_nohint(self, false, node)
end

---移除元素
---@param _Where MapNode
---@return MapNode|nil
function MapImpl:Remove(_Where)
    if _Where==nil or _Where._Isnil then
        return
    end
    local _Myhead = self._Myhead
    local _Erasednode = _Where
    local _Fixnode
    local _Fixnodeparent
    _Where = _Where:Next()
    local _Pnode = _Erasednode
    if (_Pnode._Left._Isnil) then
        _Fixnode = _Pnode._Right -- stitch up right subtree
    elseif (_Pnode._Right._Isnil) then
        _Fixnode = _Pnode._Left -- stitch up left subtree
    else
        -- two subtrees, must lift successor node to replace erased
        _Pnode = _Where -- _Pnode is successor node
        _Fixnode = _Pnode._Right -- _Fixnode is only subtree
    end

    if (_Pnode == _Erasednode) then
        -- at most one subtree, relink it
        _Fixnodeparent = _Erasednode._Parent
        if (not _Fixnode._Isnil) then
            _Fixnode._Parent = _Fixnodeparent -- link up
        end
        if (_Myhead._Parent == _Erasednode) then
            _Myhead._Parent = _Fixnode -- link down from root
        elseif (_Fixnodeparent._Left == _Erasednode) then
            _Fixnodeparent._Left = _Fixnode -- link down to left
        else
            _Fixnodeparent._Right = _Fixnode -- link down to right
        end

        if (_Myhead._Left == _Erasednode) then
            _Myhead._Left = _Fixnode._Isnil and _Fixnodeparent -- smallest is parent of erased node
            or _Min(_Fixnode) -- smallest in relinked subtree
        end

        if (_Myhead._Right == _Erasednode) then
            _Myhead._Right = _Fixnode._Isnil and _Fixnodeparent -- largest is parent of erased node
            or _Max(_Fixnode) -- largest in relinked subtree
        end
    else
        -- erased has two subtrees, _Pnode is successor to erased
        _Erasednode._Left._Parent = _Pnode -- link left up
        _Pnode._Left = _Erasednode._Left -- link successor down

        if (_Pnode == _Erasednode._Right) then
            _Fixnodeparent = _Pnode -- successor is next to erased
        else
            -- successor further down, link in place of erased
            _Fixnodeparent = _Pnode._Parent -- parent is successor's
            if (not _Fixnode._Isnil) then
                _Fixnode._Parent = _Fixnodeparent -- link fix up
            end

            _Fixnodeparent._Left = _Fixnode -- link fix down
            _Pnode._Right = _Erasednode._Right -- link next down
            _Erasednode._Right._Parent = _Pnode -- right up
        end

        if (_Myhead._Parent == _Erasednode) then
            _Myhead._Parent = _Pnode -- link down from root
        elseif (_Erasednode._Parent._Left == _Erasednode) then
            _Erasednode._Parent._Left = _Pnode -- link down to left
        else
            _Erasednode._Parent._Right = _Pnode -- link down to right
        end

        _Pnode._Parent = _Erasednode._Parent -- link successor up
        -- recolor it
        local tmp = _Pnode._Color
        _Pnode._Color = _Erasednode._Color
        _Erasednode._Color = tmp
    end

    if (_Erasednode._Color == _Black) then
        -- erasing black link, must recolor/rebalance tree
        while (_Fixnode ~= _Myhead._Parent and _Fixnode._Color == _Black) do
            if (_Fixnode == _Fixnodeparent._Left) then
                -- fixup left subtree
                _Pnode = _Fixnodeparent._Right
                if (_Pnode._Color == _Red) then
                    -- rotate red up from right subtree
                    _Pnode._Color = _Black
                    _Fixnodeparent._Color = _Red
                    _Lrotate(self._Myhead, _Fixnodeparent)
                    _Pnode = _Fixnodeparent._Right
                end

                if (_Pnode._Isnil) then
                    _Fixnode = _Fixnodeparent -- shouldn't happen
                elseif (_Pnode._Left._Color == _Black and _Pnode._Right._Color == _Black) then
                    -- redden right subtree with black children
                    _Pnode._Color = _Red
                    _Fixnode = _Fixnodeparent
                else
                    -- must rearrange right subtree
                    if (_Pnode._Right._Color == _Black) then
                        -- rotate red up from left sub-subtree
                        _Pnode._Left._Color = _Black
                        _Pnode._Color = _Red
                        _Rrotate(self._Myhead, _Pnode)
                        _Pnode = _Fixnodeparent._Right
                    end

                    _Pnode._Color = _Fixnodeparent._Color
                    _Fixnodeparent._Color = _Black
                    _Pnode._Right._Color = _Black
                    _Lrotate(self._Myhead, _Fixnodeparent)
                    break -- tree now recolored/rebalanced
                end
            else
                -- fixup right subtree
                _Pnode = _Fixnodeparent._Left
                if (_Pnode._Color == _Red) then
                    -- rotate red up from left subtree
                    _Pnode._Color = _Black
                    _Fixnodeparent._Color = _Red
                    _Rrotate(self._Myhead, _Fixnodeparent)
                    _Pnode = _Fixnodeparent._Left
                end

                if (_Pnode._Isnil) then
                    _Fixnode = _Fixnodeparent -- shouldn't happen
                elseif (_Pnode._Right._Color == _Black and _Pnode._Left._Color == _Black) then
                    -- redden left subtree with black children
                    _Pnode._Color = _Red
                    _Fixnode = _Fixnodeparent
                else
                    -- must rearrange left subtree
                    if (_Pnode._Left._Color == _Black) then
                        -- rotate red up from right sub-subtree
                        _Pnode._Right._Color = _Black
                        _Pnode._Color = _Red
                        _Lrotate(self._Myhead, _Pnode)
                        _Pnode = _Fixnodeparent._Left
                    end

                    _Pnode._Color = _Fixnodeparent._Color
                    _Fixnodeparent._Color = _Black
                    _Pnode._Left._Color = _Black
                    _Rrotate(self._Myhead, _Fixnodeparent)
                    break -- tree now recolored/rebalanced
                end
            end

            _Fixnodeparent = _Fixnode._Parent
        end

        _Fixnode._Color = _Black -- stopping node is black
    end

    self._Mysize = self._Mysize - 1
    _Erasednode._Left = nil
    _Erasednode._Parent = nil
    _Erasednode._Right = nil
    _Erasednode._Color = _Black
    _Erasednode._Isnil = true
    return (_Erasednode)
end

---查找
---@param _Keyval string | number key
---@return MapNode
function MapImpl:Find(_Keyval)
    local _Where = lower_bound(self, _Keyval)
    if _Where == self._end or self._Comp(_Keyval, _Where._key) then
        return self._end
    else
        return _Where
    end
end

---数量
---@return integer
function MapImpl:GetCount()
    return self._Mysize
end

---迭代
---@return function
function MapImpl:Enum()
    local iter = self._Myhead._Left
    local e = self._end
    local ptr
    return function()
        if iter~=e then
            ptr = iter
            iter = iter:Next()
            return ptr._key, ptr._value
        end
    end
end

return MapImpl