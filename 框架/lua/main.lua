local Camera = require "quick.camera"
local Unit = require "quick.unit"
local code = require "code"

Camera.TopView()


require "test.testui"


code.XMTestT = function (a)
    print(a)
end