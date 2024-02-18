LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

LoveJam.LevelList = {}
function LoveJam.NewLevel(name, data)
    LoveJam.LevelList[name] = data
end

function LoveJam.LoadLevel(name)
    local data = LoveJam.LevelList[name]
    if not data then
        print("Attempt to load non-existing level!")
        return
    end
end