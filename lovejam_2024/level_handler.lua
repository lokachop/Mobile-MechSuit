LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

LoveJam.LevelList = LoveJam.LevelList or {}
LoveJam.ActiveLevel = "none"
LoveJam.ActiveLevelGrid = {}
function LoveJam.DeclareLevel(name, data)
    if not data then
        print("Attempt to declare w/o data!")
        return
    end

    LoveJam.LevelList[name] = data
end

local UniverseWorld = LvLK3D.GetUniverseByTag("UniverseWorld")
local UniverseWorldLights = LvLK3D.GetUniverseByTag("UniverseWorldLights")
local UniverseInterior = LvLK3D.GetUniverseByTag("UniverseInterior")


local function makeDeco(id, params)
    local oDeco = LvLK3D.AddObjectToUniv("decoID" .. id, params.mdl)
    LvLK3D.SetObjectPos(oDeco, params.pos)
    LvLK3D.SetObjectAng(oDeco, params.ang)
    LvLK3D.SetObjectScl(oDeco, params.scl)
    LvLK3D.SetObjectMat(oDeco, params.mat)

    LvLK3D.SetObjectFlag(oDeco, "SHADING", params.shaded)
    LvLK3D.SetObjectFlag(oDeco, "FULLBRIGHT", params.fullbright)
    LvLK3D.SetObjectFlag(oDeco, "UV_SCALE", {params.uvScaleX, params.uvScaleY})
    LvLK3D.SetObjectShadow(oDeco, params.shadow)

    LvLK3D.UpdateObjectMesh(oDeco)
end

local function makeLight(id, params)
    local colVal = params.col
    local realColVal = {colVal[1] / 255, colVal[2] / 255, colVal[3] / 255}

    LvLK3D.PushUniverse(UniverseWorld)
        local lightID = "light_" .. id
        LvLK3D.AddLightToUniv(lightID, params.pos, params.int, realColVal)
    LvLK3D.PopUniverse()

    LvLK3D.PushUniverse(UniverseWorldLights)
        local sclVal = params.int

        local lightBillboard = LvLK3D.AddObjectToUniv("lightID" .. id, "cube")
        LvLK3D.SetObjectPos(lightBillboard, params.pos)
        LvLK3D.SetObjectScl(lightBillboard, Vector(sclVal, sclVal, sclVal))
        LvLK3D.SetObjectCol(lightBillboard, {realColVal[1], realColVal[2], realColVal[3]})
        LvLK3D.SetObjectMat(lightBillboard, "flare5")
        LvLK3D.SetObjectShader(lightBillboard, "billboard")
        LvLK3D.SetObjectFlag(lightBillboard, "FULLBRIGHT", true)
        LvLK3D.SetObjectBlend(lightBillboard, "add")
    LvLK3D.PopUniverse()
end


local function addTile(x, y, tType)
    if not LoveJam.ActiveLevelGrid[x] then
        LoveJam.ActiveLevelGrid[x] = {}
    end

    LoveJam.ActiveLevelGrid[x][y] = tType
    local tParams = LoveJam.GetTileParams(tType)
    if tParams.onInit then
        tParams.onInit(x, y)
    end
end

function LoveJam.LoadLevel(name)
    LoveJam.ActiveLevel = name
    LoveJam.ActiveLevelGrid = {}

    local levelData = LoveJam.LevelList[name]
    if not levelData then
        print("attempt to load non-existing level!")
        return
    end


    LvLK3D.ClearUniverse(UniverseWorld)
    LvLK3D.ClearUniverse(UniverseWorldLights)

    LoveJam.PostLoadPushElements()

    LvLK3D.PushUniverse(UniverseWorld)
        for k, v in pairs(levelData.deco) do
            makeDeco(k, v)
        end
    LvLK3D.PopUniverse()

    for k, v in pairs(levelData.lights) do
        makeLight(k, v)
    end


    for k, v in pairs(levelData.tiles) do
        for k2, v2 in pairs(v) do
            addTile(k, k2, v2)
        end
    end


    LvLK3D.PushUniverse(UniverseInterior)
    local objBlockade = LvLK3D.GetObjectByName("interiorHullBlockade")
    if levelData.isNoVis then
        LvLK3D.SetObjectHidden(objBlockade, false)
        LoveJam.EditCurrentMessageOnTerminal("Due to a radiation hazard, the windows have been closed.")
        LoveJam.PushMessageToTerminal("")
        LoveJam.EditCurrentMessageOnTerminal("Please make sure to follow protocol code LK-7375")
        LoveJam.PushMessageToTerminal("")

    else
        LvLK3D.SetObjectHidden(objBlockade, true)
    end
    LvLK3D.PopUniverse()
end

function LoveJam.GetTileAtPos(x, y)
    if not LoveJam.ActiveLevelGrid[x] then
        return
    end

    if not LoveJam.ActiveLevelGrid[x][y] then
        return
    end


    return LoveJam.ActiveLevelGrid[x][y]
end


function LoveJam.GetCurrentLevelName()
    return LoveJam.ActiveLevel
end

function LoveJam.GetCurrentLevelData()
    return LoveJam.LevelList[LoveJam.ActiveLevel]
end

function LoveJam.GetCurrentLevelNoVis()
    return LoveJam.LevelList[LoveJam.ActiveLevel].isNoVis
end

function LoveJam.GetCurrentLevelRadioTrack()
    return LoveJam.LevelList[LoveJam.ActiveLevel].trackOverride or "sounds/music/radio1_shit.wav"
end