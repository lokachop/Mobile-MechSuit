LoveJam = LoveJam or {}

LoveJam.RelaPath = "lovejam_2024"
function LoveJam.LoadFile(path)
    require(LoveJam.RelaPath .. "." .. path)
end

LoveJam.LoadFile("quat")
LoveJam.LoadFile("consts")
LoveJam.LoadFile("tiles")

LoveJam.LoadFile("load_textures")
LoveJam.LoadFile("load_models")

LoveJam.LoadFile("terminal")
LoveJam.LoadFile("camera")
LoveJam.LoadFile("interior")
LoveJam.LoadFile("world")
LoveJam.LoadFile("radio")
LoveJam.LoadFile("movement")
LoveJam.LoadFile("gameplay")
LoveJam.LoadFile("sound_interior")
LoveJam.LoadFile("tutorial")

LoveJam.LoadFile("view_manager")
LoveJam.LoadFile("views.view_general")
LoveJam.LoadFile("views.view_terminal")
LoveJam.LoadFile("views.view_camera")
LoveJam.LoadFile("views.view_glass")

LoveJam.LoadFile("level_handler")
LoveJam.LoadFile("levels.leveltest")
LoveJam.LoadFile("levels.tiletest")
LoveJam.LoadFile("levels.level1test")

LoveJam.LoadFile("levels.level_tuto")
LoveJam.LoadFile("levels.level1")
LoveJam.LoadFile("levels.level2")
LoveJam.LoadFile("levels.level3")
LoveJam.LoadFile("levels.level4")


--[[
    TODO
    Comment out on release
]]--

LoveJam.LoadFile("leveleditor.new_level")
LoveJam.LoadFile("leveleditor.save_level")
LoveJam.LoadFile("leveleditor.load_level")

LoveJam.LoadFile("leveleditor.init_vars")


LoveJam.LoadFile("leveleditor.ui.levelprop_ui")
LoveJam.LoadFile("leveleditor.ui.objectlist_ui")
LoveJam.LoadFile("leveleditor.ui.objectprop_ui")
LoveJam.LoadFile("leveleditor.ui.lightprop_ui")


LoveJam.LoadFile("leveleditor.deco")
LoveJam.LoadFile("leveleditor.light")
LoveJam.LoadFile("leveleditor.modifyobject")
LoveJam.LoadFile("leveleditor.gridedit")
LoveJam.LoadFile("leveleditor.le_keys")

LoveJam.LoadFile("state_handler")
LoveJam.LoadFile("states.state_mainmenu")
LoveJam.LoadFile("states.state_game")
LoveJam.LoadFile("states.state_nextlevel")
LoveJam.LoadFile("states.state_death")

LoveJam.LoadFile("states.state_leveledit")