--[[
	LoveJam 2024, By Lokachop
	This project uses a heavily thinned down version of LvLK3D!
	- No physics
	- No raycasts
	- No collada models
]]--
CurTime = CurTime or 0
require("lvlk3d.lvlk3d")
LoveJam = LoveJam or {}




function love.load()
	local sw, sh = love.graphics.getDimensions()
	love.mouse.setPosition(sw * .5, sh * .5)
	love.mouse.setGrabbed(true)

	require("lvlkui.lvlkui")
	love.keyboard.setKeyRepeat(true)

	require("lovejam_2024.lovejam_main")
	LvLK3D.SendModelsToC()

	LoveJam.SetState(STATE_GAME)
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