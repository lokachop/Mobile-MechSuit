LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

function LKEdit.LoadLevel(name)
    local levelData = LoveJam.LevelList[name]
    if not levelData then
        print("attempt to load non-existing level!")
        return
    end


    LKEdit.CurrLevel = LKEdit.NewLevel(name)
    local cLevel = LKEdit.CurrLevel
    cLevel.name = levelData.name or "no-name"
    cLevel.gW = levelData.gW or 0
    cLevel.gH = levelData.gH or 0
    cLevel.gOX = levelData.gOX or 0
    cLevel.gOY = levelData.gOY or 0
    cLevel.deco = {}

    for k, v in pairs(levelData.deco) do
        local dID = LKEdit.NewDeco()
        local decoPtr = cLevel.deco[dID]
        decoPtr.pos = v.pos or Vector(0, 0, 0)
        decoPtr.ang = v.ang or Angle(0, 0, 0)
        decoPtr.scl = v.scl or Vector(1, 1, 1)

        decoPtr.mat = v.mat or "none"
        decoPtr.mdl = v.mdl or "cube"

        decoPtr.fullbright = v.fullbright ~= nil and v.fullbright or false
        decoPtr.shadow = v.shadow ~= nil and v.shadow or true
        decoPtr.shaded = v.shaded ~= nil and v.shaded or true

        LKEdit.UpdateDeco(dID)
    end

    for k, v in pairs(levelData.lights) do
        local lID = LKEdit.NewLight()
        local lightPtr = cLevel.lights[lID]
        lightPtr.pos = v.pos or Vector(0, 0, 0)
        lightPtr.int = v.int or 1
        if v.col then
            local vReal = v.col
            lightPtr.col = {vReal[1] / 255, vReal[2] / 255, vReal[3] / 255}
        end

        LKEdit.UpdateLight(lID)
    end

    cLevel.tiles = levelData.tiles
    LKEdit.RebuildVisTiles()


    print("Load complete for \"" .. name .. "\"")
end