LvLKUI = LvLKUI or {}

LvLKUI.RelaPath = "lvlkui"
function LvLKUI.LoadFile(path)
    require(LvLKUI.RelaPath .. "." .. path)
end

LvLKUI.LoadFile("utils")

LvLKUI.LoadFile("themes")
LvLKUI.LoadFile("methods")
LvLKUI.LoadFile("components")
LvLKUI.LoadFile("elements")
LvLKUI.LoadFile("input")

LvLKUI.LoadFile("rendering")