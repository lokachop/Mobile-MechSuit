LoveJam = LoveJam or {}

LoveJam.RelaPath = "lovejam_2024"
function LoveJam.LoadFile(path)
    require(LoveJam.RelaPath .. "." .. path)
end

LoveJam.LoadFile("load_textures")
LoveJam.LoadFile("load_models")

LoveJam.LoadFile("terminal")
LoveJam.LoadFile("camera")
LoveJam.LoadFile("interior")
LoveJam.LoadFile("state_handler")
LoveJam.LoadFile("states.state_game")