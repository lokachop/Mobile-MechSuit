LoveJam = LoveJam or {}
LoveJam.States = LoveJam.States or {}
LvLK3D = LvLK3D or {}

local id, state = LoveJam.NewState()
STATE_GAME = id

local sw, sh = love.graphics.getDimensions()
local UniverseWorld = LvLK3D.GetUniverseByTag("UniverseWorld")
local UniverseInterior = LvLK3D.GetUniverseByTag("UniverseInterior")
local UniverseInteriorLights = LvLK3D.GetUniverseByTag("UniverseInteriorLights")


local RTGame = LvLK3D.NewRenderTarget("RenderTargetGame", sw * .75, sh * .75)
LvLK3D.SetRenderTargetFilter(RTGame, "nearest", "nearest")


local RTCamera = LvLK3D.NewRenderTarget("RenderTargetCamera", 512, 512)
LvLK3D.SetRenderTargetFilter(RTCamera, "nearest", "nearest")
LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)

function state.onThink(dt)
	LvLK3D.MouseCamThink(dt)

	LvLK3D.PushUniverse(UniverseWorld)
		LvLK3D.SoundThink(dt)
	LvLK3D.PopUniverse()

	LoveJam.UpdateCameraTex(RTCamera)

	LoveJam.InternalViewThink(dt)
	LoveJam.ViewThink(dt)
	LoveJam.TerminalFlashThink()
end


function state.onRender()
	love.graphics.clear(true, true, true)
	LvLK3D.PushRenderTarget(RTCamera)
		LvLK3D.PushUniverse(UniverseWorld)
			LvLK3D.Clear(.1, .1, .2)
			local prevCam = LvLK3D.CamPos
			LvLK3D.SetCamPos(Vector(0, 4, -1))
			LvLK3D.RenderActiveUniverse()
			LvLK3D.SetCamPos(prevCam)
		LvLK3D.PopUniverse()
	LvLK3D.PopRenderTarget()


	LvLK3D.PushRenderTarget(RTGame)
		LvLK3D.PushUniverse(UniverseInterior)
			LvLK3D.ClearDepth()
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()

		LvLK3D.PushUniverse(UniverseInteriorLights)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
	LvLK3D.PopRenderTarget()

	LvLK3D.RenderRTFullScreen(RTGame)


	LoveJam.ViewRender()
	LoveJam.RenderZones()
end

function state.onKeyPressed(key)
	--LvLK3D.ToggleMouseLock(key)
	LoveJam.ViewKeyPressed(key)
end


function state.onMouseMoved(mx, my, dx, dy)
	--LvLK3D.MouseCamUpdate(dx, dy)
	LoveJam.MouseZoneHandle(mx, my)
end


function state.onEnter()
	LoveJam.StartRadio()
	LvLK3D.FOV = 90
	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)
	print("Init")
end

function state.onExit()
	LoveJam.StopRadio()
	print("Exit")
end