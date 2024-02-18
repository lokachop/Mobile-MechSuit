LoveJam = LoveJam or {}

LoveJam.RelaPath = "lovejam_2024"
function LoveJam.LoadFile(path)
    require(LoveJam.RelaPath .. "." .. path)
end

LoveJam.LoadFile("quat")

LoveJam.LoadFile("load_textures")
LoveJam.LoadFile("load_models")

LoveJam.LoadFile("terminal")
LoveJam.LoadFile("camera")
LoveJam.LoadFile("interior")
LoveJam.LoadFile("world")
LoveJam.LoadFile("radio")

LoveJam.LoadFile("view_manager")
LoveJam.LoadFile("views.view_general")
LoveJam.LoadFile("views.view_terminal")
LoveJam.LoadFile("views.view_camera")

LoveJam.LoadFile("state_handler")
LoveJam.LoadFile("states.state_game")