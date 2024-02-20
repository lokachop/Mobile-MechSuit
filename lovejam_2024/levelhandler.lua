LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

LoveJam.LevelList = {}
function LoveJam.DeclareLevel(name, data)
    if not data then
        print("Attempt to declare w/o data!")
        return
    end

    LoveJam.LevelList[name] = data
end