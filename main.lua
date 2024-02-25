--[[
	LoveJam 2024, By Lokachop
	This project uses a heavily thinned down version of LvLK3D!
	- No physics
	- No raycasts
	- No collada models
]]--
CurTime = CurTime or 0
LoveJam = LoveJam or {}





function love.load()
	love.window.setMode(0, 0, {
		fullscreen = true,
		vsync = -1,
	})
	--local rw, rh = love.graphics.getDimensions()
	--love.window.setMode(rw, rh, {
	--	fullscreen = "desktop",
	--	vsync = -1,
	--})

	require("lvlk3d.lvlk3d")




	local sw, sh = love.graphics.getDimensions()
	love.mouse.setPosition(sw * .5, sh * .5)
	love.mouse.setGrabbed(true)

	require("lvlkui.lvlkui")
	love.keyboard.setKeyRepeat(true)

	require("lovejam_2024.lovejam_main")


	LoveJam.SetState(STATE_MAINMENU)
	love.audio.setVolume(0.2)
end

function love.update(dt)
	CurTime = CurTime + dt
	LoveJam.StateThink(dt)


	LvLKUI.TriggerThink(dt)
end

function love.textinput(t)
	LvLKUI.TriggerKeypress(t, false)
end

function love.keypressed(key)
	LvLKUI.TriggerKeypress(key, true)

	LoveJam.StateKeyPressed(key)
end

function love.mousepressed(x, y, button)
	LvLKUI.TriggerClick(x, y, button)
end

function love.mousemoved(mx, my, dx, dy)
	LvLKUI.TriggerHover(mx, my)

	LoveJam.StateMouseMoved(mx, my, dx, dy)
end


function love.draw()
	LoveJam.StateRender()

	LvLKUI.DrawAll()
end