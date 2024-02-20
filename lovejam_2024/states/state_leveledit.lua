LoveJam = LoveJam or {}
LoveJam.States = LoveJam.States or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

local id, state = LoveJam.NewState()
STATE_LEVELEDIT = id

local sw, sh = love.graphics.getDimensions()
local UniverseEditPlaneRef = LvLK3D.GetUniverseByTag("UniverseEditPlaneRef")
local UniverseEdit = LvLK3D.GetUniverseByTag("UniverseEdit")
local UniverseEditLights = LvLK3D.GetUniverseByTag("UniverseEditLights")

local RTLevelEdit = LvLK3D.NewRenderTarget("RenderTargetLevelEdit", sw, sh)
LvLK3D.SetRenderTargetFilter(RTLevelEdit, "nearest", "nearest")






local function initUI()
	LKEdit.InitFrameLevelInfo()
	LKEdit.InitFrameEntList()
	LKEdit.InitFrameEntProp()
	LKEdit.InitFrameLightProp()
end

function state.onThink(dt)
	if LKEdit.GridEdit then
		LKEdit.GECamThink(dt)
	else
		LvLK3D.MouseCamThink(dt)
	end
end


function state.onRender()
	love.graphics.clear(true, true, true)

	LvLK3D.PushRenderTarget(RTLevelEdit)
		LvLK3D.Clear(.1, .1, .2)
		LvLK3D.PushUniverse(UniverseEditPlaneRef)
			LvLK3D.RenderActiveUniverse()
		LvLK3D.PopUniverse()


		if not LKEdit.GridEdit then
			LvLK3D.ClearDepth()
			LvLK3D.PushUniverse(UniverseEdit)
				LvLK3D.RenderActiveUniverse()
			LvLK3D.PopUniverse()

			LvLK3D.PushUniverse(UniverseEditLights)
				LvLK3D.RenderActiveUniverse()
			LvLK3D.PopUniverse()
		end
	LvLK3D.PopRenderTarget()

	love.graphics.setColor(1, 1, 1, 1)
	LvLK3D.RenderRTFullScreen(RTLevelEdit)

	if LvLK3D.CamInputLock then
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.circle("fill", sw * .5, sh * .5, 3, 16)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.circle("fill", sw * .5, sh * .5, 2, 16)

		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.print("F to select lookat..", sw * .5 + 2, sh * .5 + 2)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.print("F to select lookat..", sw * .5, sh * .5)
	end


	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("kp9 to enter gridEdit mode!", sw * .5, 24)
	love.graphics.print("GridEdit; " .. tostring(LKEdit.GridEdit), sw * .5, 48)

	if LKEdit.GridEdit then
		LKEdit.GEPaint()
	end
end

function state.onKeyPressed(key)
	LKEdit.ToggleGridEdit(key)
	if LKEdit.GridEdit then
		LKEdit.GEKeys(key)
	else
		LvLK3D.ToggleMouseLock(key)
		LKEdit.SelectLookAtHandle(key)
	end
end


function state.onMouseMoved(mx, my, dx, dy)
	if LKEdit.GridEdit then

	else
		LvLK3D.MouseCamUpdate(dx, dy)
	end
end



function state.onEnter()
	print("LevelEdit")
	--love.window.setMode(1200, 800, {
	--	fullscreen = false,
	--})
	love.mouse.setGrabbed(false)
	LvLK3D.FOV = 90
	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)
	initUI()
end

function state.onExit()
	print("Bye from LevelEdit")
end