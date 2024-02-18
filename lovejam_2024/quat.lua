LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local _pattForm = "%4.2f, %4.2f, %4.2f, %4.2f"
local q_meta = {
    -- str
    ["__tostring"] = function(x)
        return string.format(_pattForm, x[1], x[2], x[3], x[4])
    end,
    ["__concat"] = function(x)
        return string.format(_pattForm, x[1], x[2], x[3], x[4])
    end,
    ["SetEuler"] = function(x, y)
        local cr = math.cos(math.rad(y[3]) * 0.5)
        local sr = math.sin(math.rad(y[3]) * 0.5)
        local cp = math.cos(math.rad(y[1]) * 0.5)
        local sp = math.sin(math.rad(y[1]) * 0.5)
        local cy = math.cos(math.rad(y[2]) * 0.5)
        local sy = math.sin(math.rad(y[2]) * 0.5)

        x[4] = cr * cp * cy + sr * sp * sy
        x[1] = sr * cp * cy - cr * sp * sy
        x[2] = cr * sp * cy + sr * cp * sy
        x[3] = cr * cp * sy - sr * sp * cy
    end,
    ["GetEuler"] = function(x)
        local eOut = Angle(0, 0, 0)

        -- roll (x-axis rotation)
        local sinr_cosp = 2 * (q.w * q.x + q.y * q.z)
        local cosr_cosp = 1 - 2 * (q.x * q.x + q.y * q.y)
        eOut[3] = math.atan2(sinr_cosp, cosr_cosp)

        -- pitch (y-axis rotation)
        local sinp = math.sqrt(1 + 2 * (q.w * q.y - q.x * q.z))
        local cosp = math.sqrt(1 - 2 * (q.w * q.y - q.x * q.z))
        eOut[1] = 2 * math.atan2(sinp, cosp) - math.pi / 2

        -- yaw (z-axis rotation)
        local siny_cosp = 2 * (q.w * q.z + q.x * q.y)
        local cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z)
        eOut[2] = math.atan2(siny_cosp, cosy_cosp)

        return eOut
    end,

    -- etc
    ["__name"] = "Quaternion",
}
q_meta.__index = q_meta

function Quaternion(x, y, z, w)
    if tonumber(x) == nil then
        local v = {x[1] or 0, x[2] or 0, x[3] or 0, x[4] or 1} -- w is matrix only currently
        setmetatable(v, q_meta)
        return v
    else
        local v = {x or 0, y or 0, z or 0, w or 1}
        setmetatable(v, q_meta)
        return v
    end
end