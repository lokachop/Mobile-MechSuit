LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}


local id, state = LoveJam.NewState()
STATE_MAINMENU = id

local sw, sh = love.graphics.getDimensions()
local UniverseMainMenu = LvLK3D.NewUniverse("UniverseMainMenu")
local RTMainMenu = LvLK3D.NewRenderTarget("RenderTargetMainMenu", sw, sh)


LvLK3D.PushUniverse(UniverseMainMenu)
	LvLK3D.SetSunLighting(false)
	LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
	LvLK3D.SetAmbientCol({.1, .1, .1})

	LvLK3D.AddLightToUniv("LightMM", Vector(0, 6, -2), 4, {1, 1, 1})

	local planeFloor = LvLK3D.AddObjectToUniv("plane_floor", "plane")
	LvLK3D.SetObjectPos(planeFloor, Vector(0, 0, 0))
	LvLK3D.SetObjectScl(planeFloor, Vector(16, 16, 16))
	LvLK3D.SetObjectMat(planeFloor, "metal2")
	LvLK3D.SetObjectFlag(planeFloor, "SHADING", false)
	LvLK3D.SetObjectFlag(planeFloor, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(planeFloor, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(planeFloor, "FULLBRIGHT", false)
	LvLK3D.SetObjectFlag(planeFloor, "UV_SCALE", {8, 8})
	LvLK3D.UpdateObjectMesh(planeFloor)

	local planeWallB = LvLK3D.AddObjectToUniv("planeWallB", "plane")
	LvLK3D.SetObjectPos(planeWallB, Vector(0, 16, 16))
	LvLK3D.SetObjectAng(planeWallB, Vector(90, 0, 0))
	LvLK3D.SetObjectScl(planeWallB, Vector(16, 16, 16))
	LvLK3D.SetObjectMat(planeWallB, "metal4")
	LvLK3D.SetObjectFlag(planeWallB, "SHADING", false)
	LvLK3D.SetObjectFlag(planeWallB, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(planeWallB, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(planeWallB, "FULLBRIGHT", false)
	LvLK3D.SetObjectFlag(planeWallB, "UV_SCALE", {16, 16})
	LvLK3D.UpdateObjectMesh(planeWallB)

	local planeWallL = LvLK3D.AddObjectToUniv("planeWallB", "plane")
	LvLK3D.SetObjectPos(planeWallL, Vector(16, 16, 0))
	LvLK3D.SetObjectAng(planeWallL, Vector(90, 0, -90))
	LvLK3D.SetObjectScl(planeWallL, Vector(16, 16, 16))
	LvLK3D.SetObjectMat(planeWallL, "metal4")
	LvLK3D.SetObjectFlag(planeWallL, "SHADING", false)
	LvLK3D.SetObjectFlag(planeWallL, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(planeWallL, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(planeWallL, "FULLBRIGHT", false)
	LvLK3D.SetObjectFlag(planeWallL, "UV_SCALE", {16, 16})
	LvLK3D.UpdateObjectMesh(planeWallL)


	local robotHull = LvLK3D.AddObjectToUniv("robot_hull", "robot_hull")
	LvLK3D.SetObjectPos(robotHull, Vector(0, 2.85, 0))
	LvLK3D.SetObjectScl(robotHull, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(robotHull, "robot_hull")
	LvLK3D.SetObjectFlag(robotHull, "SHADING", true)
	LvLK3D.UpdateObjectMesh(robotHull)
	LvLK3D.SetObjectShadow(robotHull, true)

	local robotLegL = LvLK3D.AddObjectToUniv("robot_legl", "robot_legl")
	LvLK3D.SetObjectPos(robotLegL, Vector(0, 2.85, 0))
	LvLK3D.SetObjectScl(robotLegL, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(robotLegL, "robot_legl")
	LvLK3D.SetObjectFlag(robotLegL, "SHADING", true)
	LvLK3D.UpdateObjectMesh(robotLegL)
	LvLK3D.SetObjectShadow(robotLegL, true)

	local robotLegR = LvLK3D.AddObjectToUniv("robot_legr", "robot_legr")
	LvLK3D.SetObjectPos(robotLegR, Vector(0, 2.85, 0))
	LvLK3D.SetObjectScl(robotLegR, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(robotLegR, "robot_legr")
	LvLK3D.SetObjectFlag(robotLegR, "SHADING", true)
	LvLK3D.UpdateObjectMesh(robotLegR)
	LvLK3D.SetObjectShadow(robotLegR, true)
LvLK3D.PopUniverse()

LvLK3D.SetRenderTargetFilter(RTMainMenu, "nearest", "nearest")


local menuLoop = love.audio.newSource("sounds/music/menuloop.wav", "stream")
menuLoop:setLooping(true)
local function beginMusic()
	menuLoop:play()
end

local function endMusic()
	menuLoop:stop()
end


local function sign(x)
	return x < 0 and -1 or 1
end

local function moveTowards(a, b, delta)
	if math.abs(a - b) <= delta then
		return b
	end

	return a + (sign(b - a) * delta)
end



local function rmUI()
	LvLKUI.RemoveElement("panel_mainmenu")
	LvLKUI.RemoveElement("frame_level_select")
	LvLKUI.RemoveElement("frame_map_edit")
end


local function onStart()
	endMusic()
	rmUI()
	LoveJam.LoadLevel("level_tuto")
	LoveJam.SetState(STATE_GAME)
end

local function onCredits()
	endMusic()
	rmUI()
	LoveJam.SetState(STATE_CREDITS)
end

local levels = {
	{
		name = "level_tuto",
		fancyName = "Tutorial Level",
	}, {
		name = "level1",
		fancyName = "Level 1",
	}, {
		name = "level2",
		fancyName = "Level 2",
	}, {
		name = "level3",
		fancyName = "Level 3",
	}, {
		name = "level4",
		fancyName = "Level 4",
	}, {
		name = "level5",
		fancyName = "Level 5",
	}, {
		name = "levelfinal",
		fancyName = "The Reactor Core",
	},
}


local function onLevelSelect()
	if LvLKUI.GetElement("frame_level_select") then
		return
	end

	local w, h = love.graphics.getDimensions()
	local frameLevelSelect = LvLKUI.NewElement("frame_level_select", "frame")
	frameLevelSelect:SetLabel("Level Select")
	frameLevelSelect:SetPriority(84)
	frameLevelSelect:SetPos({(w * .5) - (256 * .5), (h * .5) - (96 * .5)})
	frameLevelSelect:SetSize({256, 256 + 32})


	local yBuff = 24 + 2
	for k, v in ipairs(levels) do
		local buttonLvl = LvLKUI.NewElement("button_level_" .. k, "button")
		buttonLvl:SetPriority(40)
		buttonLvl:SetPos({128 - 64 - 32, yBuff})
		buttonLvl:SetSize({128 + 64, 32})
		buttonLvl:SetLabel(v.fancyName)
		buttonLvl:SetOnClick(function(elm, mx, my)
			endMusic()
			rmUI()
			LoveJam.LoadLevel(v.name)
			LoveJam.SetState(STATE_GAME)
		end)
		LvLKUI.PushElement(buttonLvl, frameLevelSelect)

		yBuff = yBuff + 36
	end


	LvLKUI.PushElement(frameLevelSelect)
end



local function onMapEdit()
	if LvLKUI.GetElement("frame_map_edit") then
		return
	end


	local w, h = love.graphics.getDimensions()
	local frameMapEdit = LvLKUI.NewElement("frame_map_edit", "frame")
	frameMapEdit:SetLabel("Map Editor")
	frameMapEdit:SetPriority(80)
	frameMapEdit:SetPos({(w * .5) - (256 * .5), (h * .5) - (96 * .5)})
	frameMapEdit:SetSize({256, 96 + 48})

	local labels = {
		"This will load the map editor.",
		"All of the levels were made w/ this",
		"its a very broken and bad editor",
		"it might also crash your game.",
		"Are you sure you want to open it?"
	}


	for k, v in ipairs(labels) do
		local labelNfo = LvLKUI.NewElement("labelNfo" .. k, "label")
		labelNfo:SetPriority(25)
		labelNfo:SetPos({128, 24 + 8 + ((k - 1) * 16)})
		labelNfo:SetSize({128, 32})
		labelNfo:SetLabel(v)
		labelNfo:SetAlignMode({1, 1})
		LvLKUI.PushElement(labelNfo, frameMapEdit)
	end




	local buttonYes = LvLKUI.NewElement("button_yes", "button")
	buttonYes:SetPriority(40)
	buttonYes:SetPos({128 - 96, 24 + 8 + 74})
	buttonYes:SetSize({64, 32})
	buttonYes:SetLabel("Yes")
	buttonYes:SetColourOverride({0.25, 0.5, 0.25}, {0.1, 0.25, 0.1}, {0.5, 1, 0.5})
	buttonYes:SetOnClick(function(elm, mx, my)
		frameMapEdit:Remove()
		endMusic()
		rmUI()
		LoveJam.SetState(STATE_LEVELEDIT)
	end)
	LvLKUI.PushElement(buttonYes, frameMapEdit)

	local buttonNo = LvLKUI.NewElement("button_no", "button")
	buttonNo:SetPriority(40)
	buttonNo:SetPos({128 + 32, 24 + 8 + 74})
	buttonNo:SetSize({64, 32})
	buttonNo:SetLabel("No")
	buttonNo:SetColourOverride({0.5, 0.25, 0.25}, {0.25, 0.1, 0.1}, {1, 0.5, 0.5})
	buttonNo:SetOnClick(function(elm, mx, my)
		frameMapEdit:Remove()
	end)
	LvLKUI.PushElement(buttonNo, frameMapEdit)


	LvLKUI.PushElement(frameMapEdit)


end

local function onQuit()
	endMusic()
	love.event.quit()
	--buttonQuit
end




local texLogo = love.graphics.newImage("textures/logo.png")
texLogo:setFilter("nearest", "nearest")
local logoW, logoH = 56, 21
local logoScl = 6

local target = "robot"
local blurTarget = 0
local currBlur = 0
local function initUI()
	local fw, fh = sw * .35, sh

	LoveJam.PanelMainMenu = LvLKUI.NewElement("panel_mainmenu", "panel")
	LoveJam.PanelMainMenu:SetPriority(20)
	LoveJam.PanelMainMenu:SetPos({0, 0})
	LoveJam.PanelMainMenu:SetSize({sw, sh})
	LoveJam.PanelMainMenu:SetOnPaint(function(elm, w, h)
	end)

	local panelButtons = LvLKUI.NewElement("panel_buttons", "panel")
	panelButtons:SetPos({0, 0})
	panelButtons:SetSize({fw, fh})
	panelButtons:SetOnPaint(function(elm, w, h)
		love.graphics.setColor(0, 0, 0, 0.7)
		love.graphics.rectangle("fill", 0, 0, w, h)

		love.graphics.setColor(1, 1, 1, 1)
		local logoWM = logoW * logoScl
		love.graphics.draw(texLogo, w * .5 - (logoWM * .5), 32, 0, logoScl, logoScl)
	end)

	panelButtons.onHover = function(elm)
		if target ~= "buttons" then
			target = "buttons"
			blurTarget = 0.0125
		end
	end

	local bw, bh = fw * .65, 64
	local buttonStart = LvLKUI.NewElement("button_start", "button")
	buttonStart:SetPos({fw * .5 - (bw * .5), 240})
	buttonStart:SetSize({bw, bh})
	buttonStart:SetLabel("Play")
	buttonStart:SetPriority(40)
	buttonStart:SetOnClick(function(elm)
		onStart()
	end)
	LvLKUI.PushElement(buttonStart, panelButtons)


	local buttonCredits = LvLKUI.NewElement("button_credits", "button")
	buttonCredits:SetPos({fw * .5 - (bw * .5), 240 + bh * 2})
	buttonCredits:SetSize({bw, bh})
	buttonCredits:SetLabel("Credits")
	buttonCredits:SetPriority(40)
	buttonCredits:SetOnClick(function(elm)
		onCredits()
	end)
	LvLKUI.PushElement(buttonCredits, panelButtons)


	local buttonLevelSelect = LvLKUI.NewElement("button_level_select", "button")
	buttonLevelSelect:SetPos({fw * .5 - (bw * .5), 240 + bh * 4})
	buttonLevelSelect:SetSize({bw, bh})
	buttonLevelSelect:SetLabel("Level Select")
	buttonLevelSelect:SetPriority(40)
	buttonLevelSelect:SetOnClick(function(elm)
		onLevelSelect()
	end)
	LvLKUI.PushElement(buttonLevelSelect, panelButtons)



	local buttonMapEdit = LvLKUI.NewElement("button_mapedit", "button")
	buttonMapEdit:SetPos({fw * .5 - (bw * .5), 240 + bh * 6})
	buttonMapEdit:SetSize({bw, bh})
	buttonMapEdit:SetLabel("Dev MapEditor")
	buttonMapEdit:SetPriority(40)
	buttonMapEdit:SetOnClick(function(elm)
		onMapEdit()
	end)
	LvLKUI.PushElement(buttonMapEdit, panelButtons)


	local buttonQuit = LvLKUI.NewElement("button_quit", "button")
	buttonQuit:SetPos({fw * .5 - (bw * .5), fh * .9})
	buttonQuit:SetSize({bw, bh})
	buttonQuit:SetLabel("Quit")
	buttonQuit:SetPriority(40)
	buttonQuit:SetColourOverride({0.5, 0.25, 0.25}, {0.25, 0.1, 0.1}, {1, 0.5, 0.5})
	buttonQuit:SetOnClick(function(elm)
		onQuit()
	end)
	LvLKUI.PushElement(buttonQuit, panelButtons)

	LvLKUI.PushElement(panelButtons, LoveJam.PanelMainMenu)


	local panelRobotView = LvLKUI.NewElement("panel_robotview", "panel")
	panelRobotView:SetPos({fw, 0})
	panelRobotView:SetSize({sw - fw, fh})
	panelRobotView:SetOnPaint(function(elm, w, h)
	end)

	panelRobotView.onHover = function(elm)
		if target ~= "robot" then
			target = "robot"
			blurTarget = 0.0
		end
	end

	LvLKUI.PushElement(panelRobotView, LoveJam.PanelMainMenu)


	LvLKUI.PushElement(LoveJam.PanelMainMenu)
end
function state.onThink(dt)
	LvLK3D.PushUniverse(UniverseMainMenu)
		LvLK3D.SetLightPos("LightMM", Vector(math.cos(CurTime * .65) * 2.6546, (math.sin(CurTime * .53) * 1.7353) + 4, (math.sin(CurTime * .7645767) - 4) * 1.523))
	LvLK3D.PopUniverse()

	currBlur = moveTowards(currBlur, blurTarget, dt * .02)
end


function state.onRender()
	--love.graphics.clear(true, true, true)
	love.graphics.clear(.1, .1, .2, 1, true, true)
	LvLK3D.PushRenderTarget(RTMainMenu)
		LvLK3D.PushUniverse(UniverseMainMenu)
			LvLK3D.Clear(.1, .1, .2)
			LvLK3D.SetCamPos(Vector(-6, 6, -6))
			LvLK3D.SetCamAng(Angle(-25 + (math.cos(CurTime * .56212) * 7), 220 + (math.sin(CurTime * .1534) * 15), 0))
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
	LvLK3D.PopRenderTarget()

	--LvLK3D.PushPPEffect("frameAccum", {
	--	["blendFactor"] = 0.9
	--})

	LvLK3D.PushPPEffect("blur", {
		["passes"] = 6,
		["amount"] = currBlur,
	})
	love.graphics.setColor(1, 1, 1, 1)
	LvLK3D.RenderRTFullScreen(RTMainMenu)
end


function state.onEnter()
	LvLK3D.FOV = 60
	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)
	beginMusic()
	initUI()
end