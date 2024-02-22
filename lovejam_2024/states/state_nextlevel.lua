LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}


local id, state = LoveJam.NewState()
STATE_NEXTLEVEL = id

local sw, sh = love.graphics.getDimensions()

local RTNextLevel = LvLK3D.NewRenderTarget("RenderTargetNextLevel", sw * .75, sh * .75)
LvLK3D.SetRenderTargetFilter(RTNextLevel, "nearest", "nearest")

local RTGame = LvLK3D.GetRenderTargetByName("RenderTargetGame")

local function openUI()
	local w, h = love.graphics.getDimensions()
	local frameNextMap = LvLKUI.NewElement("frame_map", "frame")
	frameNextMap:SetLabel("Next Map")
	frameNextMap:SetPriority(20)
	frameNextMap:SetPos({(w * .5) - (256 * .5), (h * .5) - (96 * .5)})
	frameNextMap:SetSize({256, 96 + 48})
	frameNextMap:SetCloseDisabled(true)

	local buttonNext = LvLKUI.NewElement("button_next", "button")
	buttonNext:SetPriority(40)
	buttonNext:SetPos({128 - (128 * .5), 24 + 8 + 16})
	buttonNext:SetSize({128, 32})
	buttonNext:SetLabel(map == "credits" and "Credits" or "Next Level")
	buttonNext:SetColourOverride({0.25, 0.5, 0.25}, {0.1, 0.25, 0.1}, {0.5, 1, 0.5})
	buttonNext:SetOnClick(function(elm, mx, my)
		frameNextMap:Remove()
	end)
	LvLKUI.PushElement(buttonNext, frameNextMap)

	local buttonMenu = LvLKUI.NewElement("button_menu", "button")
	buttonMenu:SetPriority(40)
	buttonMenu:SetPos({128 - (128 * .5), 24 + 8 + 64})
	buttonMenu:SetSize({128, 32})
	buttonMenu:SetLabel("Main Menu")
	buttonMenu:SetColourOverride({0.5, 0.25, 0.25}, {0.25, 0.1, 0.1}, {1, 0.5, 0.5})
	buttonMenu:SetOnClick(function(elm, mx, my)
		frameNextMap:Remove()
		LoveJam.SetState(STATE_MAINMENU)
	end)
	LvLKUI.PushElement(buttonMenu, frameNextMap)

	local labelNext = LvLKUI.NewElement("label_next", "label")
	labelNext:SetPriority(30)
	labelNext:SetPos({128, 24 + 8})
	labelNext:SetSize({128, 32})
	labelNext:SetLabel("Good Job!")
	labelNext:SetAlignMode({1, 1})
	LvLKUI.PushElement(labelNext, frameNextMap)


	LvLKUI.PushElement(frameNextMap)
end

function state.onThink(dt)
end


function state.onRender()
	love.graphics.clear(true, true, true)

	LvLK3D.PushPPEffect("cbBlur", {
		["offset"] = 0.6,
		["blendFactor"] = 0.1
	})

	LvLK3D.PushPPEffect("blur", {
		["passes"] = 2,
		["amount"] = 0.004,
	})

	LvLK3D.RenderRTFullScreen(RTNextLevel)
end



function state.onEnter()
	LvLK3D.FOV = 90
	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)
	love.mouse.setRelativeMode(false)


	love.graphics.setCanvas(RTNextLevel)
		love.graphics.setBlendMode("alpha", "premultiplied")
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(RTGame, 0, 0)
		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()

	openUI()
end

function state.onExit()
end