LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

function LKEdit.NewLevel(name)
    local levelData = {
        name = name,
        nextLevel = "none",
        isNoVis = false,
        gW = 0,
        gH = 0,
        gOX = 0,
        gOY = 0,

        deco = {},
        lights = {},
        tiles = {},
        dark = false,
    }

    return levelData
end
