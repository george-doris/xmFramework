local CJ = require "jass.common"
local japi = require "framework.dzapi"
local UpdateCallback = require "framework.update_callback"
local Mouse = require "framework.mouse"

---@class Camera
local Camera = {
    _topView = {
        _x_angle = 0,
        _near = 3,
        _far = 12,
        step = 200,
        _distance = 3
    }
}

local _camera

---默认视角
function Camera.Default()
    UpdateCallback.RemoveUpdateCallback("camera_view")
    Mouse.RemoveMouseWheelEvent("camera_view")
end

---顶视角
---@param near integer|nil 最小级数(最小距离/step,默认3)
---@param far integer|nil 最大距离(最大距离/step,默认12)
---@param step number|nil 每级间隔(默认200)
---@param xangle number|nil 视角倾斜度(默认当前视角倾斜度)
function Camera.TopView(near,far,step,xangle)
    local topView = Camera._topView
        topView._x_angle = 0
        topView._near = near or 3
        topView._far = far or 12
        topView.step = step or 200
        topView._distance = topView._near
    topView._x_angle = xangle or CJ.Rad2Deg(CJ.GetCameraField(CJ.CAMERA_FIELD_ANGLE_OF_ATTACK))
    UpdateCallback.RemoveUpdateCallback("camera_view")
    UpdateCallback.AddUpdateCallback("camera_view", function()
        if topView._x_angle > 0 then
            CJ.SetCameraField(CJ.CAMERA_FIELD_ANGLE_OF_ATTACK, topView._x_angle, 0.00)
            CJ.SetCameraField(CJ.CAMERA_FIELD_TARGET_DISTANCE,
            topView._distance * 200.00, 0.1)
        end
    end)

    Mouse.RemoveMouseWheelEvent("camera_view")
    Mouse.AddMouseWheelEvent("camera_view", function()
        if not japi.DzIsMouseOverUI() then return end
        local frameid = japi.DzGetMouseFocus()
        if frameid > 0 then return end
        if japi.DzGetWheelDelta() > 0 then
            if topView._distance > 3 then topView._distance = topView._distance - 1 end
        else
            if topView._distance < 12 then topView._distance = topView._distance + 1 end
        end
        topView._x_angle = CJ.Rad2Deg(CJ.GetCameraField(CJ.CAMERA_FIELD_ANGLE_OF_ATTACK))
    end)
end

return Camera