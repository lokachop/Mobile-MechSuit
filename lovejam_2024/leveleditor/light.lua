local UniverseEdit = LvLK3D.GetUniverseByTag("UniverseEdit")
local UniverseEditLights = LvLK3D.GetUniverseByTag("UniverseEditLights")


function LKEdit.GetLightById(id)
    return LKEdit.CurrLevel.lights[id]
end



function LKEdit.UpdateLight(id)
    local lightParams = LKEdit.CurrLevel.lights[id]
    if not lightParams then
        return
    end


    local oLight = lightParams.light_id
    local oBillBoard = lightParams.lvlk3d_id
    LvLK3D.PushUniverse(UniverseEdit)
        LvLK3D.SetLightPos(oLight, lightParams.pos)
        LvLK3D.SetLightIntensity(oLight, lightParams.int)
        LvLK3D.SetLightCol(oLight, lightParams.col)
    LvLK3D.PopUniverse()

    LvLK3D.PushUniverse(UniverseEditLights)
        local sclVal = lightParams.int
        local colVal = lightParams.col

        print(colVal[1] * .5, colVal[2] * .5, colVal[3] * .5)

        LvLK3D.SetObjectPos(oBillBoard, lightParams.pos)
        LvLK3D.SetObjectScl(oBillBoard, Vector(sclVal, sclVal, sclVal))
        LvLK3D.SetObjectCol(oBillBoard, {colVal[1] * .5, colVal[2] * .5, colVal[3] * .5})
        LvLK3D.UpdateObjectMesh(oBillBoard)
    LvLK3D.PopUniverse()


end


function LKEdit.NewLight()
    local cLevel = LKEdit.CurrLevel
    local id = #cLevel.lights + 1

    cLevel.lights[id] = {
        pos = Vector(0, 0, 0),
        int = 1,
        col = {1, 1, 1},
        lvlk3d_id = 0,
        light_id = "",
        id = id,
    }

    local lightParams = cLevel.lights[id]

    LvLK3D.PushUniverse(UniverseEdit)
        local lightID = "lightID" .. id
        LvLK3D.AddLightToUniv(lightID, lightParams.pos, lightParams.int, lightParams.col)
        print("newLight")
    LvLK3D.PopUniverse()

    LvLK3D.PushUniverse(UniverseEditLights)
        local sclVal = (1 / lightParams.int)
        local colVal = lightParams.col

        local lightBillboard = LvLK3D.AddObjectToUniv("lightID" .. id, "cube")
        LvLK3D.SetObjectPos(lightBillboard, lightParams.pos)
        LvLK3D.SetObjectScl(lightBillboard, Vector(sclVal, sclVal, sclVal))
        LvLK3D.SetObjectCol(lightBillboard, {colVal[1] * .5, colVal[2] * .5, colVal[3] * .5})
        LvLK3D.SetObjectMat(lightBillboard, "flare4")
        LvLK3D.SetObjectShader(lightBillboard, "billboard")
        LvLK3D.SetObjectFlag(lightBillboard, "FULLBRIGHT", true)
        LvLK3D.SetObjectBlend(lightBillboard, "add")

        LvLK3D.SetObjectFlag(lightBillboard, "LKEDIT_ID", id)
        LvLK3D.SetObjectFlag(lightBillboard, "LKEDIT_TYPE", "light")

        LvLK3D.UpdateObjectMesh(lightBillboard)
    LvLK3D.PopUniverse()



    lightParams.lvlk3d_id = lightBillboard
    lightParams.light_id = lightID

    LKEdit.SelectEntity(id, "light")
    return id
end