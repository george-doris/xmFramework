---类说明
---@class Shape
Shape = {}

---新建实例
---@param length number 长度
---@param width number 宽度
---@return Shape
function Shape.new(length,width)
    local o = {}
    setmetatable(o,{__index = Shape})
	o:ctor(length,width)

    return o
end

---构造函数
function Shape:ctor(length,width)
    self.length = length
    self.width = width
    self.area = width*length
end

function Shape:pr()
    print(self.area)
end

local s = Shape.new(10,20)