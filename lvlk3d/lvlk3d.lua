LvLK3D = LvLK3D or {}
LvLK3D.Version = "0.1"
LvLK3D.Debug = true
LvLK3D.FilterMode = "nearest"

LvLK3D.RelaPath = "lvlk3d"
LvLK3D.LibDir = "lvlk3d.libs"
LvLK3D.LibDirExt = "lvlk3d.libs.external"
function LvLK3D.LoadFile(path)
    require(LvLK3D.RelaPath .. "." .. path)
end

LvLK3D.LoadFile("libs/lmat") -- make sure to load lmat first
LvLK3D.LoadFile("libs/lvec")
LvLK3D.LoadFile("libs/lang")
LvLK3D.LoadFile("libs/lknoise")

LvLK3D.LoadFile("consts")
LvLK3D.LoadFile("textures")
LvLK3D.LoadFile("universes")
LvLK3D.LoadFile("rendertargets")
LvLK3D.LoadFile("models")

-- all of the model loaders
LvLK3D.LoadFile("loaders.mdl.loader_obj")

LvLK3D.LoadFile("basemodels")
LvLK3D.LoadFile("objects")
LvLK3D.LoadFile("shaders")
LvLK3D.LoadFile("shadowvolumes")
LvLK3D.LoadFile("lights")
LvLK3D.LoadFile("proctex")
LvLK3D.LoadFile("procmodel")
LvLK3D.LoadFile("postprocess")
LvLK3D.LoadFile("sound")
--LvLK3D.LoadFile("physics")

LvLK3D.LoadFile("camera")
LvLK3D.LoadFile("render")