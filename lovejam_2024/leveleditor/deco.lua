local UniverseEdit = LvLK3D.GetUniverseByTag("UniverseEdit")
local UniverseEditLights = LvLK3D.GetUniverseByTag("UniverseEditLights")


function LKEdit.GetDecoByID(id)
    return LKEdit.CurrLevel.deco[id]
end



function LKEdit.UpdateDeco(id)
    local decoParams = LKEdit.CurrLevel.deco[id]
    if not decoParams then
        return
    end


    local oDeco = decoParams.lvlk3d_id
    LvLK3D.PushUniverse(UniverseEdit)
        LvLK3D.SetObjectModel(oDeco, decoParams.mdl)
        LvLK3D.SetObjectPos(oDeco, decoParams.pos)
        LvLK3D.SetObjectAng(oDeco, decoParams.ang)
        LvLK3D.SetObjectScl(oDeco, decoParams.scl)
        LvLK3D.SetObjectMat(oDeco, decoParams.mat)

        LvLK3D.SetObjectFlag(oDeco, "SHADING", decoParams.shaded)
        LvLK3D.SetObjectFlag(oDeco, "FULLBRIGHT", decoParams.fullbright)
        LvLK3D.SetObjectShadow(oDeco, decoParams.shadow)

        LvLK3D.UpdateObjectMesh(oDeco)
    LvLK3D.PopUniverse()
end


function LKEdit.NewDeco()
    local cLevel = LKEdit.CurrLevel
    local id = #cLevel.deco + 1

    cLevel.deco[id] = {
        pos = Vector(0, 0, 0),
        ang = Angle(0, 0, 0),
        scl = Vector(1, 1, 1),
        mat = "none",
        mdl = "cube",
        fullbright = false,
        shadow = true,
        shaded = true,
        lvlk3d_id = 0,
        id = id,
    }

    local decoParams = cLevel.deco[id]

    LvLK3D.PushUniverse(UniverseEdit)
        local oDeco = LvLK3D.AddObjectToUniv("decoID" .. id, decoParams.mdl)
        LvLK3D.SetObjectPos(oDeco, decoParams.pos)
        LvLK3D.SetObjectAng(oDeco, decoParams.ang)
        LvLK3D.SetObjectScl(oDeco, decoParams.scl)
        LvLK3D.SetObjectMat(oDeco, decoParams.mat)
        LvLK3D.SetObjectFlag(oDeco, "SHADING", decoParams.shaded)
        LvLK3D.SetObjectFlag(oDeco, "SHADING_SMOOTH", false)
        LvLK3D.SetObjectFlag(oDeco, "NORM_INVERT", false)
        LvLK3D.SetObjectFlag(oDeco, "FULLBRIGHT", decoParams.fullbright)
        LvLK3D.SetObjectShadow(oDeco, decoParams.shadow)

        LvLK3D.SetObjectFlag(oDeco, "LKEDIT_ID", id)
        LvLK3D.SetObjectFlag(oDeco, "LKEDIT_TYPE", "deco")

        LvLK3D.UpdateObjectMesh(oDeco)
    LvLK3D.PopUniverse()

    decoParams.lvlk3d_id = oDeco

    LKEdit.SelectEntity(id, "deco")
    return id
end