LoveJam = LoveJam or {}
LoveJam.States = LoveJam.States or {}
LvLK3D = LvLK3D or {}

STATE_GAME = 1
local state = LoveJam.NewState(STATE_GAME)


local sw, sh = love.graphics.getDimensions()
local UniverseWorld = LvLK3D.NewUniverse("UniverseWorld")
local RTGame = LvLK3D.NewRenderTarget("RenderTargetGame", sw * .4, sh * .4)
LvLK3D.SetRenderTargetFilter(RTGame, "nearest", "nearest")
LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)




LvLK3D.PushUniverse(UniverseWorld)
	LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
	LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
	LvLK3D.SetAmbientCol({.25, .25, .25})



	LvLK3D.AddLightToUniv("LightTemp", Vector(0, 6, -2), 4, {1, 1, 1})
	local idxLightTempObj = LvLK3D.AddObjectToUniv("lightTempShadow", "cube")
	LvLK3D.SetObjectPos(idxLightTempObj, Vector(0, 6, -2))
	LvLK3D.SetObjectMat(idxLightTempObj, "white")
	LvLK3D.SetObjectFlag(idxLightTempObj, "SHADING", false)
	LvLK3D.SetObjectFlag(idxLightTempObj, "FULLBRIGHT", true)
	LvLK3D.SetObjectScl(idxLightTempObj, Vector(.1, .1, .1))
	LvLK3D.SetObjectCol(idxLightTempObj, {1, 1, 1})

	local planeFloor = LvLK3D.AddObjectToUniv("plane_floor", "plane")
	LvLK3D.SetObjectPos(planeFloor, Vector(0, 0, 0))
	LvLK3D.SetObjectScl(planeFloor, Vector(16, 16, 16))
	LvLK3D.SetObjectMat(planeFloor, "metal4")
	LvLK3D.SetObjectFlag(planeFloor, "SHADING", false)
	LvLK3D.SetObjectFlag(planeFloor, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(planeFloor, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(planeFloor, "FULLBRIGHT", false)
	LvLK3D.UpdateObjectMesh(planeFloor)


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


local function updateLightAndExShadow(id, pos)
	LvLK3D.SetLightPos(id, pos)
	LvLK3D.SetObjectPos(idxLightTempObj, pos)
end


function state.onThink(dt)
	LvLK3D.MouseCamThink(dt)

	LvLK3D.PushUniverse(UniverseWorld)
		updateLightAndExShadow("LightTemp", Vector(math.cos(CurTime * .65) * 4.6546, 6.5, math.sin(CurTime * .7645767) * 3.523))
		LvLK3D.SoundThink(dt)
	LvLK3D.PopUniverse()

	LoveJam.UpdateCameraTex(RTGame)
end


function state.onRender()
	love.graphics.clear(true, true, true)

	LvLK3D.PushRenderTarget(RTGame)
		LvLK3D.Clear(.1, .2, .3)
		LvLK3D.PushUniverse(UniverseWorld)

			LvLK3D.RenderActiveUniverse()

		LvLK3D.PopUniverse()

		LvLK3D.PushUniverse(LoveJam.UniverseInterior)
			LvLK3D.ClearDepth()
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()

	LvLK3D.PopRenderTarget()
	--LvLK3D.PushPPEffect("frameAccum", {
	--	["blendFactor"] = 0.97
	--})
	LvLK3D.RenderRTFullScreen(RTGame)
end

function state.onKeyPressed(key)
	LvLK3D.ToggleMouseLock(key)
end


function state.onMouseMoved(mx, my, dx, dy)
	LvLK3D.MouseCamUpdate(dx, dy)
end


function state.onEnter()
	print("Init")
end

function state.onExit()
	print("Exit")
end