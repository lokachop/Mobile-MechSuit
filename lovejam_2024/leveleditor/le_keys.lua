LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

LKEdit.NormalKeyMode = "move"
local function keysMoveMode(key)
    local sObj = LKEdit.SelectedEntity
    local sType = LKEdit.SelectedType


    local sPos = sObj.pos:Copy()

    local altered = false
    if key == "kp8" then
        LKEdit.SetSelectedEntityParameter("pos", Vector(sPos[1], sPos[2], sPos[3] - 1), sType)
        altered = true
    elseif key == "kp5" then
        LKEdit.SetSelectedEntityParameter("pos", Vector(sPos[1], sPos[2], sPos[3] + 1), sType)
        altered = true
    elseif key == "kp4" then
        LKEdit.SetSelectedEntityParameter("pos", Vector(sPos[1] - 1, sPos[2], sPos[3]), sType)
        altered = true
    elseif key == "kp6" then
        LKEdit.SetSelectedEntityParameter("pos", Vector(sPos[1] + 1, sPos[2], sPos[3]), sType)
        altered = true
    elseif key == "kp7" then
        LKEdit.SetSelectedEntityParameter("pos", Vector(sPos[1], sPos[2] + 1, sPos[3]), sType)
        altered = true
    elseif key == "kp1" then
        LKEdit.SetSelectedEntityParameter("pos", Vector(sPos[1], sPos[2] - 1, sPos[3]), sType)
        altered = true
    end

    return altered
end

local function keysMoveRotate(key)
    local sObj = LKEdit.SelectedEntity
    local sType = LKEdit.SelectedType
    if sType ~= "deco" then
        return
    end

    local sAng = sObj.ang:Copy()

    local fract = 22.5
    local altered = false
    if key == "kp8" then
        LKEdit.SetSelectedEntityParameter("ang", Angle((sAng[1] + fract) % 360, sAng[2], sAng[3]), sType)
        altered = true
    elseif key == "kp5" then
        LKEdit.SetSelectedEntityParameter("ang", Angle((sAng[1] - fract) % 360, sAng[2], sAng[3]), sType)
        altered = true
    elseif key == "kp4" then
        LKEdit.SetSelectedEntityParameter("ang", Angle(sAng[1], (sAng[2] - fract) % 360, sAng[3]), sType)
        altered = true
    elseif key == "kp6" then
        LKEdit.SetSelectedEntityParameter("ang", Angle(sAng[1], (sAng[2] + fract) % 360, sAng[3]), sType)
        altered = true
    elseif key == "kp7" then
        LKEdit.SetSelectedEntityParameter("ang", Angle(sAng[1], sAng[2], (sAng[3] + fract) % 360), sType)
        altered = true
    elseif key == "kp1" then
        LKEdit.SetSelectedEntityParameter("ang", Angle(sAng[1], sAng[2], (sAng[3] - fract) % 360), sType)
        altered = true
    end

    return altered
end

local function keysScaleMode(key)
    local sObj = LKEdit.SelectedEntity
    local sType = LKEdit.SelectedType
    if sType ~= "deco" then
        return
    end


    local sScl = sObj.scl:Copy()
    local altered = false
    if key == "kp8" then
        LKEdit.SetSelectedEntityParameter("scl", Vector(sScl[1], sScl[2], sScl[3] - 1), sType)
        altered = true
    elseif key == "kp5" then
        LKEdit.SetSelectedEntityParameter("scl", Vector(sScl[1], sScl[2], sScl[3] + 1), sType)
        altered = true
    elseif key == "kp4" then
        LKEdit.SetSelectedEntityParameter("scl", Vector(sScl[1] - 1, sScl[2], sScl[3]), sType)
        altered = true
    elseif key == "kp6" then
        LKEdit.SetSelectedEntityParameter("scl", Vector(sScl[1] + 1, sScl[2], sScl[3]), sType)
        altered = true
    elseif key == "kp7" then
        LKEdit.SetSelectedEntityParameter("scl", Vector(sScl[1], sScl[2] + 1, sScl[3]), sType)
        altered = true
    elseif key == "kp1" then
        LKEdit.SetSelectedEntityParameter("scl", Vector(sScl[1], sScl[2] - 1, sScl[3]), sType)
        altered = true
    end

    return altered
end

local function keysTexMode(key)
    local sObj = LKEdit.SelectedEntity
    local sType = LKEdit.SelectedType
    if sType ~= "deco" then
        return
    end

    local sUvScaleX = sObj.uvScaleX
    local sUvScaleY = sObj.uvScaleY

    local altered = false
    if key == "kp8" then
        LKEdit.SetSelectedEntityParameter("uvScaleY", sUvScaleY + 1, sType)
        altered = true
    elseif key == "kp5" then
        LKEdit.SetSelectedEntityParameter("uvScaleY", sUvScaleY - 1, sType)
        altered = true
    elseif key == "kp4" then
        LKEdit.SetSelectedEntityParameter("uvScaleX", sUvScaleX + 1, sType)
        altered = true
    elseif key == "kp6" then
        LKEdit.SetSelectedEntityParameter("uvScaleX", sUvScaleX - 1, sType)
        altered = true
    end

    return altered
end


function LKEdit.LEKeys(key)
    local sObj = LKEdit.SelectedEntity
    if not sObj then
        return
    end


    if key == "1" then
        LKEdit.NormalKeyMode = "move"
    elseif key == "2" then
        LKEdit.NormalKeyMode = "rotate"
    elseif key == "3" then
        LKEdit.NormalKeyMode = "scale"
    elseif key == "4" then
        LKEdit.NormalKeyMode = "texscl"
    end


    if LKEdit.NormalKeyMode == "move" then
        if keysMoveMode(key) then
            LKEdit.PushParamsForSelected()
        end
    elseif LKEdit.NormalKeyMode == "rotate" then
        if keysMoveRotate(key) then
            LKEdit.PushParamsForSelected()
        end
    elseif LKEdit.NormalKeyMode == "scale" then
        if keysScaleMode(key) then
            LKEdit.PushParamsForSelected()
        end
    elseif LKEdit.NormalKeyMode == "texscl" then
        if keysTexMode(key) then
            LKEdit.PushParamsForSelected()
        end
    end
end