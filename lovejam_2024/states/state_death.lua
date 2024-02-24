LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}


local id, state = LoveJam.NewState()
STATE_DEATH = id

local sw, sh = love.graphics.getDimensions()

local RTRetry = LvLK3D.NewRenderTarget("RenderTargetRetry", sw * .75, sh * .75)
LvLK3D.SetRenderTargetFilter(RTRetry, "nearest", "nearest")

local RTGame = LvLK3D.GetRenderTargetByName("RenderTargetGame")

local function openUI()
	local w, h = love.graphics.getDimensions()
	local frameRetry = LvLKUI.NewElement("frame_retry", "frame")
	frameRetry:SetLabel("You Died!")
	frameRetry:SetPriority(20)
	frameRetry:SetPos({(w * .5) - (256 * .5), (h * .5) - (96 * .5)})
	frameRetry:SetSize({256, 96 + 48})
	frameRetry:SetCloseDisabled(true)

	local buttonNext = LvLKUI.NewElement("button_next", "button")
	buttonNext:SetPriority(40)
	buttonNext:SetPos({128 - (128 * .5), 24 + 8 + 16})
	buttonNext:SetSize({128, 32})
	buttonNext:SetLabel("Retry")
	buttonNext:SetColourOverride({0.25, 0.5, 0.25}, {0.1, 0.25, 0.1}, {0.5, 1, 0.5})
	buttonNext:SetOnClick(function(elm, mx, my)
		frameRetry:Remove()
		LoveJam.BeginLevel(LoveJam.GetCurrentLevelName())
		LoveJam.SetState(STATE_GAME)
	end)
	LvLKUI.PushElement(buttonNext, frameRetry)

	local buttonMenu = LvLKUI.NewElement("button_menu", "button")
	buttonMenu:SetPriority(40)
	buttonMenu:SetPos({128 - (128 * .5), 24 + 8 + 64})
	buttonMenu:SetSize({128, 32})
	buttonMenu:SetLabel("Main Menu")
	buttonMenu:SetColourOverride({0.5, 0.25, 0.25}, {0.25, 0.1, 0.1}, {1, 0.5, 0.5})
	buttonMenu:SetOnClick(function(elm, mx, my)
		frameRetry:Remove()
		LoveJam.SetState(STATE_MAINMENU)
	end)
	LvLKUI.PushElement(buttonMenu, frameRetry)

	local labelNext = LvLKUI.NewElement("label_next", "label")
	labelNext:SetPriority(30)
	labelNext:SetPos({128, 24 + 8})
	labelNext:SetSize({128, 32})
	labelNext:SetLabel("Acid pits / pools kill you.")
	labelNext:SetAlignMode({1, 1})
	LvLKUI.PushElement(labelNext, frameRetry)


	LvLKUI.PushElement(frameRetry)
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

	love.graphics.setColor(1, 1, 1, 1)
	LvLK3D.RenderRTFullScreen(RTRetry)
end



function state.onEnter()
	LvLK3D.FOV = 90
	LvLK3D.BuildProjectionMatrix(sw / sh, 0.01, 1000)
	love.mouse.setRelativeMode(false)


	love.graphics.setCanvas(RTRetry)
		love.graphics.setBlendMode("alpha", "premultiplied")
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(RTGame, 0, 0)
		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()

	openUI()
end

function state.onExit()
end