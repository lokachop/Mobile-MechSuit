LoveJam = LoveJam or {}
LoveJam.States = LoveJam.States or {}
LvLK3D = LvLK3D or {}

local id, state = LoveJam.NewState()
STATE_GAME = id

local sw, sh = love.graphics.getDimensions()
local UniverseWorld = LvLK3D.GetUniverseByTag("UniverseWorld")
local UniverseWorldLights = LvLK3D.GetUniverseByTag("UniverseWorldLights")
local UniverseInterior = LvLK3D.GetUniverseByTag("UniverseInterior")
local UniverseInteriorLights = LvLK3D.GetUniverseByTag("UniverseInteriorLights")


local RTGame = LvLK3D.NewRenderTarget("RenderTargetGame", sw * .75, sh * .75)
LvLK3D.SetRenderTargetFilter(RTGame, "nearest", "nearest")


local RTCamera = LvLK3D.NewRenderTarget("RenderTargetCamera", 512, 512)
LvLK3D.SetRenderTargetFilter(RTCamera, "nearest", "nearest")
LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)

DO_NOCLIP = false

function state.onThink(dt)
	LvLK3D.MouseCamThink(dt)

	LvLK3D.PushUniverse(UniverseWorld)
		LvLK3D.SoundThink(dt)
	LvLK3D.PopUniverse()

	LoveJam.UpdateCameraTex(RTCamera)

	if not DO_NOCLIP then
		LoveJam.ViewThink(dt)
		LoveJam.InternalViewThink(dt)
		LoveJam.MechMovementInterpThink(dt)
		LoveJam.SoundInteriorThink(dt)
	end
	LoveJam.TerminalFlashThink()
end


function state.onRender()
	love.graphics.clear(true, true, true)


	local prevCamAng = LvLK3D.CamAng
	local mechCamAng = LoveJam.GetMechCamAng()
	local newRealAng = LvLK3D.CamAng - LoveJam.GetMechCamAng()


	local rtCamRealAng = LoveJam.CameraAng - LoveJam.GetMechCamAng()

	LvLK3D.BuildProjectionMatrix(1, 0.01, 1000)
	LvLK3D.PushRenderTarget(RTCamera)
		local prevCam = LvLK3D.CamPos
		LvLK3D.Clear(.1, .1, .2)
		LvLK3D.SetCamPos(LoveJam.GetMechCamPos())
		LvLK3D.SetCamAng(rtCamRealAng)

		LvLK3D.PushUniverse(UniverseWorld)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
		LvLK3D.PushUniverse(UniverseWorldLights)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
		LvLK3D.SetCamPos(prevCam)
	LvLK3D.PopRenderTarget()


	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)
	LvLK3D.PushRenderTarget(RTGame)
		LvLK3D.Clear(.1, .1, .2)

		local camAddRot = (LvLK3D.CamPos * .5)
		camAddRot:Rotate(mechCamAng)


		LvLK3D.SetCamPos(LoveJam.GetMechViewPos() + camAddRot)
		LvLK3D.SetCamAng(newRealAng)

		LvLK3D.PushUniverse(UniverseWorld)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
		LvLK3D.PushUniverse(UniverseWorldLights)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()

		love.graphics.setColor(0.25, 0.35, 0.75, 0.4)
		love.graphics.rectangle("fill", 0, 0, sw, sh)

		LvLK3D.SetCamPos(prevCam)
		LvLK3D.SetCamAng(prevCamAng)
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
	if DO_NOCLIP then
		LvLK3D.ToggleMouseLock(key)
	else
		LoveJam.ViewKeyPressed(key)
	end

	if key == "kp8" then
		LoveJam.SetState(STATE_NEXTLEVEL)
	end
end


function state.onMouseMoved(mx, my, dx, dy)
	if DO_NOCLIP then
		LvLK3D.MouseCamUpdate(dx, dy)
	else
		if LoveJam.ViewMouseMoved(mx, my, dx, dy) then -- captured
			return
		end

		LoveJam.MouseZoneHandle(mx, my)
	end
end


function state.onEnter()
	LoveJam.StartRadio()
	LvLK3D.FOV = 90
	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)
	print("Init")

	LoveJam.LoadLevel("level1")
end

function state.onExit()
	LoveJam.StopRadio()
	print("Exit")
end