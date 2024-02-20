LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

function LKEdit.NewLevel(name)
    local levelData = {
        name = name,
        gW = 0,
        gH = 0,

        deco = {},
        lights = {},
        gridData = {},
        dark = false,
    }

    return levelData
end
