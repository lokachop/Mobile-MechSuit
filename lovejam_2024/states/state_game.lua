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
local RTOutside = LvLK3D.NewRenderTarget("RenderTargetOutside", sw * .25, sh * .25)
LvLK3D.SetRenderTargetFilter(RTOutside, "nearest", "nearest")


local rOutW, rOutH = (sw * .75) / (sw * .25), (sh * .75) / (sh * .25)

local RTCamera = LvLK3D.NewRenderTarget("RenderTargetCamera", 512, 512)
LvLK3D.SetRenderTargetFilter(RTCamera, "nearest", "nearest")
LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)

DO_NOCLIP = false

function state.onThink(dt)
	LvLK3D.PushUniverse(UniverseWorld)
		LvLK3D.SoundThink(dt)
	LvLK3D.PopUniverse()

	LoveJam.UpdateCameraTex(RTCamera)

	if not DO_NOCLIP then
		LoveJam.ViewThink(dt)
		LoveJam.InternalViewThink(dt)
		LoveJam.MechMovementInterpThink(dt)
		LoveJam.SoundInteriorThink(dt)
		LoveJam.MultiMoveThink()
	else
		LvLK3D.MouseCamThink(dt)
	end
	LoveJam.TerminalFlashThink()
end


local function updateCam()
	local prevCam = LvLK3D.CamPos
	local prevAng = LvLK3D.CamAng
	local rtCamRealAng = LoveJam.CameraAng - LoveJam.GetMechCamAng()
	LvLK3D.BuildProjectionMatrix(1, 0.01, 10000)
	LvLK3D.PushRenderTarget(RTCamera)
		LvLK3D.Clear(.1, .1, .2)
		LvLK3D.SetCamPos(LoveJam.GetMechCamPos())
		LvLK3D.SetCamAng(rtCamRealAng)

		LvLK3D.PushUniverse(UniverseWorld)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
		LvLK3D.PushUniverse(UniverseWorldLights)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
	LvLK3D.PopRenderTarget()

	LvLK3D.SetCamPos(prevCam)
	LvLK3D.SetCamAng(prevAng)
end


local camAutoFPS = 20
local camInterval = 1 / camAutoFPS
local nextCamUpdate = 0


local outsideAutoFPS = 30
local outsideInterval = 1 / outsideAutoFPS
local nextOutsideUpdate = 0


local function updateOutside()
	local prevCam = LvLK3D.CamPos
	local prevAng = LvLK3D.CamAng


	local mechCamAng = LoveJam.GetMechCamAng()
	local newRealAng = LvLK3D.CamAng - LoveJam.GetMechCamAng()

	local camAddRot = (LvLK3D.CamPos * .5)
	camAddRot:Rotate(mechCamAng)

	LvLK3D.PushRenderTarget(RTOutside)
		LvLK3D.ClearDepth()
		LvLK3D.SetCamPos(LoveJam.GetMechViewPos() + camAddRot)
		LvLK3D.SetCamAng(newRealAng)

		LvLK3D.PushUniverse(UniverseWorld)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
		LvLK3D.PushUniverse(UniverseWorldLights)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()
	LvLK3D.PopRenderTarget()


	LvLK3D.SetCamPos(prevCam)
	LvLK3D.SetCamAng(prevAng)
end


function state.onRender()
	love.graphics.clear(true, true, true)


	local prevCamAng = LvLK3D.CamAng
	local mechCamAng = LoveJam.GetMechCamAng()
	local prevCam = LvLK3D.CamPos

	if not LoveJam.IsOnGlass then
		if LoveJam.IsOnCamera then
			updateCam()
		elseif CurTime > nextCamUpdate then
			nextCamUpdate = CurTime + camInterval
			updateCam()
		end
	end


	local camAddRot = (LvLK3D.CamPos * .5)
	camAddRot:Rotate(mechCamAng)

	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 10000)
		if not LoveJam.IsOnCamera and not LoveJam.GetCurrentLevelNoVis() then
			--if LoveJam.IsOnGlass then
				updateOutside()
			--elseif CurTime > nextOutsideUpdate then
				--nextOutsideUpdate = CurTime + outsideInterval
			--end
		end

	LvLK3D.PushRenderTarget(RTGame)
		LvLK3D.Clear(.1, .1, .2)

		if not LoveJam.IsOnCamera and not LoveJam.GetCurrentLevelNoVis() then
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(RTOutside, 0, 0, 0, rOutW, rOutH)
		end


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

	love.graphics.setColor(1, 1, 1, 1)
	LvLK3D.RenderRTFullScreen(RTGame)


	LoveJam.ViewRender()
	LoveJam.RenderTutorial()
	--LoveJam.RenderZones()
end

function state.onKeyPressed(key)
	if DO_NOCLIP then
		LvLK3D.ToggleMouseLock(key)
	else
		LoveJam.ViewKeyPressed(key)
	end
	--[[
	if key == "kp8" then
		LoveJam.SetState(STATE_NEXTLEVEL)
	end

	if key == "kp9" then
		LoveJam.SetState(STATE_DEATH)
	end
	]]--
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
	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 10000)
end

function state.onExit()
	LoveJam.StopRadio()
end