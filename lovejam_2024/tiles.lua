LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}

LoveJam.Tiles = LoveJam.Tiles or {}
local name2idTiles = {}

local lastID = 0
function LoveJam.DeclareTile(params)
    lastID = lastID + 1

    local rName = params.name or "none"
    LoveJam.Tiles[lastID] = {
        name = params.name or "none",
        solid = params.solid or false,
        harmful = params.harmful or false,
        onStep = params.onStep or function(x, y) end,
        onInit = params.onInit or function(x, y) end,
        editorTex = params.editorTex or "dev_floor",
    }
    name2idTiles[rName] = lastID

    return lastID
end


function LoveJam.GetTileParams(id)
    return LoveJam.Tiles[id]
end
function LoveJam.GetTileIDByName(name)
    return name2idTiles[name]
end
function LoveJam.GetTileParamsByName(name)
    return LoveJam.Tiles[name2idTiles[name] or 0]
end




TILE_GROUND = LoveJam.DeclareTile({
    name = "ground",
    solid = false,
    harmful = false,
    editorTex = "dev_floor",
})

TILE_WALL = LoveJam.DeclareTile({
    name = "wall",
    solid = true,
    harmful = false,
    editorTex = "dev_block",
})

TILE_KILL = LoveJam.DeclareTile({
    name = "kill",
    solid = false,
    harmful = true,
    editorTex = "dev_kill",
})

TILE_SPAWN = LoveJam.DeclareTile({
    name = "spawn",
    solid = false,
    harmful = true,
    editorTex = "dev_spawn",
})