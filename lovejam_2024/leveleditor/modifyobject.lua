LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

LKEdit.SelectedEntity = LKEdit.SelectedEntity
LKEdit.SelectedType = "none"
LKEdit.SelectedID = 0


local UniverseEdit = LvLK3D.GetUniverseByTag("UniverseEdit")
local UniverseEditLights = LvLK3D.GetUniverseByTag("UniverseEditLights")
LvLK3D.PushUniverse(UniverseEdit)
    local oInvRef = LvLK3D.AddObjectToUniv("invRefSelected", "cube")
    LvLK3D.SetObjectPos(oInvRef, Vector(0, 0, 0))
    LvLK3D.SetObjectAng(oInvRef, Angle(0, 0, 0))
    LvLK3D.SetObjectScl(oInvRef, Vector(1, 1, 1))
    LvLK3D.SetObjectMat(oInvRef, "white")
    LvLK3D.SetObjectCol(oInvRef, {1, 0, 0})
    LvLK3D.SetObjectFlag(oInvRef, "NO_TRACE", true)
    LvLK3D.SetObjectFlag(oInvRef, "NORM_INVERT", true)
    LvLK3D.SetObjectFlag(oInvRef, "FULLBRIGHT", true)
    LvLK3D.UpdateObjectMesh(oInvRef)
LvLK3D.PopUniverse()


function LKEdit.UpdateSelectedShadow()
    local selected = LKEdit.SelectedEntity

    local _offSz = .025
    LvLK3D.PushUniverse(UniverseEdit)
        LvLK3D.SetObjectModel(oInvRef, selected.mdl or "cube")
        LvLK3D.SetObjectPos(oInvRef, selected.pos)
        LvLK3D.SetObjectAng(oInvRef, selected.ang or Angle(0, 0, 0))
        LvLK3D.SetObjectScl(oInvRef, (selected.scl or Vector(1, 1, 1)) + Vector(_offSz, _offSz, _offSz))
        LvLK3D.UpdateObjectMesh(oInvRef)
    LvLK3D.PopUniverse()
end


local parameterSetTypeCallbacks = {
    ["deco"] = function(param, val)
        LKEdit.SelectedEntity[param] = val
        LKEdit.UpdateDeco(LKEdit.SelectedID)
        LKEdit.UpdateSelectedShadow()
    end,
    ["light"] = function(param, val)
        LKEdit.SelectedEntity[param] = val
        LKEdit.UpdateLight(LKEdit.SelectedID)
        LKEdit.UpdateSelectedShadow()
    end,
}





function LKEdit.SetSelectedEntityParameter(param, val, eType)
    if not LKEdit.SelectedEntity then
        return
    end

    if eType ~= LKEdit.SelectedType then
        return
    end

    if parameterSetTypeCallbacks[LKEdit.SelectedType] then
        parameterSetTypeCallbacks[LKEdit.SelectedType](param, val)
    end

end

local pushEntityTypeCallbacks = {
    ["deco"] = function(ent, eType, id)
        LKEdit.PushFrameEntProps(ent, eType, id)
        LKEdit.UpdateSelectedShadow()
    end,
    ["light"] = function(ent, eType, id)
        LKEdit.PushFrameLightProps(ent, eType, id)
        LKEdit.UpdateSelectedShadow()
    end,
}



function LKEdit.SelectEntity(id, eType)
    local ent = nil
    if eType == "deco" then
        ent = LKEdit.CurrLevel.deco[id]
    elseif eType == "light" then
        ent = LKEdit.CurrLevel.lights[id]
    end
    LKEdit.SelectedType = eType
    LKEdit.SelectedID = id
    LKEdit.SelectedEntity = ent


    if pushEntityTypeCallbacks[eType] then
        pushEntityTypeCallbacks[eType](ent, eType, id)
    end
end

local function selectInView()
    local camPos = LvLK3D.CamPos
    local dir = LvLK3D.CamMatrix_Rot:Forward()

    local hit, pos, norm, dist, obj = LvLK3D.TraceRay(camPos, dir, 512)
    if not hit then
        return false, math.huge
    end

    if not obj then
        return false, math.huge
    end

    return obj, dist
end



function LKEdit.SelectLookAtHandle(key)
    if key ~= "f" then
        return
    end

    LvLK3D.PushUniverse(UniverseEdit)
        local objE, distE = selectInView()
    LvLK3D.PopUniverse()

    LvLK3D.PushUniverse(UniverseEditLights)
        local objL, distL = selectInView()
    LvLK3D.PopUniverse()

    local obj = distE < distL and objE or objL

    local oID = obj.LKEDIT_ID
    if not oID then
        return
    end

    local oType = obj.LKEDIT_TYPE
    LKEdit.SelectEntity(oID, oType)
end