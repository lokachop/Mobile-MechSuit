LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local fontLarge = love.graphics.newFont(64)
local fontSz = 16
local fontSmall = love.graphics.newFont("fonts/terminal.ttf", fontSz, "mono")
LvLK3D.NewTextureFunc("terminal_tex", 512, 512, function()
	local okSpacing = string.rep(" ", 6)
	love.graphics.clear(0.0, 0.05, 0.0, 1, true, true)
	love.graphics.setColor(0, 1, 0)

	local yBuff = 0
	love.graphics.print("MECH::LOAD", fontSmall, 0, yBuff)
	yBuff = yBuff + 10
	love.graphics.print("->HYDRAULICS" .. okSpacing .. "[OK]", fontSmall, 0, yBuff)
	yBuff = yBuff + 10
	love.graphics.print("->TEST" .. okSpacing .. "[OK]", fontSmall, 0, yBuff)
	yBuff = yBuff + 10
end)
LvLK3D.SetTextureFilter("terminal_tex", "nearest", "nearest")


local lineCount = 32
local terminalBuffer = {}
local function refreshTerminal()
	LvLK3D.RenderTexture("terminal_tex", function()
		local w, h = love.graphics.getCanvas():getDimensions()
		love.graphics.clear(0.0, 0.05, 0.0, 1, true, true)


		love.graphics.setColor(0, 1, 0)
		local yBuff = h - fontSz - 2
		for i = #terminalBuffer, 1, -1 do
			local val = terminalBuffer[i]
			if not val then
				return
			end

			love.graphics.print(val, fontSmall, 0, yBuff)
			yBuff = yBuff - fontSz
		end
	end)
end


function LoveJam.PushMessageToTerminal(msg)
	print("push; " .. msg)
	terminalBuffer[#terminalBuffer + 1] = msg
	if #terminalBuffer > lineCount then
		table.remove(terminalBuffer, 1)
	end

	refreshTerminal()
end


function LoveJam.EditCurrentMessageOnTerminal(msg, id)
	terminalBuffer[#terminalBuffer] = msg

	refreshTerminal()
end

function LoveJam.ClearTerminalBuffer()
	terminalBuffer = {}
end

LoveJam.PushMessageToTerminal("MECH::INIT")
LoveJam.PushMessageToTerminal("-> BASE                        [OK]")
LoveJam.PushMessageToTerminal("-> HYDRAULICS                  [OK]")
LoveJam.PushMessageToTerminal("-> LEG [L]                     [OK]")
LoveJam.PushMessageToTerminal("-> LEG [R]                     [OK]")
LoveJam.PushMessageToTerminal("-> AIRVENT                     [OK]")
LoveJam.PushMessageToTerminal("-> ENERGY                      [OK]")
LoveJam.PushMessageToTerminal("Initialized successfully!")
LoveJam.PushMessageToTerminal("Please sign-in with your username:")


local keyTranslations = {
	["space"] = " ",
	["lgui"] = "",
	["lshift"] = "",
}

local username = "none"
local head = username .. "@mech0> "
local cBuff = ""

LoveJam.PushMessageToTerminal(head)



local commandTable = {}
local commandState = "username"
local function newCommand(name, params)
	commandTable[name] = {
		onFirst = params.onFirst or function() end,
		onEnter = params.onEnter or function(msg, realMsg) end,
		name = name
	}

end


local function setCommandState(newState)
	commandState = newState
end

local function handleCommandEnter()
	cmdTarget = commandState

	if commandState == "none" then
		cmdTarget = string.lower(cBuff)
	end

	local cmd = commandTable[cmdTarget]
	if not cmd then
		LoveJam.PushMessageToTerminal("Unknown Command \"" .. cmdTarget .. "\"!")
		return
	end

	if commandState ~= cmdTarget then
		setCommandState(cmdTarget)
		cmd.onFirst(cBuff)
	else
		cmd.onEnter(cBuff)
	end
end


newCommand("username", {
	onFirst = function()
		LoveJam.PushMessageToTerminal("Please enter your username.")
	end,
	onEnter = function(msg)
		LoveJam.PushMessageToTerminal("Welcome, " .. msg)
		LoveJam.PushMessageToTerminal("Remember to follow the contract guidelines,")
		LoveJam.PushMessageToTerminal("Failure to do so will result in termination.")

		username = msg
		head = username .. "@mech0> "
		setCommandState("none")
	end,
})

newCommand("help", {
	onFirst = function()
		LoveJam.PushMessageToTerminal("--==Commands==--")
		setCommandState("none")
	end,
	onEnter = function(msg)
	end,
})

newCommand("clear", {
	onFirst = function()
		LoveJam.ClearTerminalBuffer()
		setCommandState("none")
	end,
	onEnter = function(msg)
	end,
})



local function playKB(sample)
	local src = LvLK3D.PlaySound3D("sounds/keyboard/" .. sample, Vector(-0.75, -0.75, -0.4), 1, 1)
	LvLK3D.SetSourceEffect(src, "reverbInterior", true)
	LvLK3D.SetSourceFilter(src, {
		["volume"] = 0.0,
		["type"] = "lowpass"
	})
	src:play()
end


local function playRandomKeySound()
	playKB("key" .. math.random(1, 7) .. ".wav")
end

local function playRandomSpaceSound()
	playKB("space" .. math.random(1, 2) .. ".wav")
end













function LoveJam.TerminalOnKey(key)
	if key == "space" then
		playRandomSpaceSound()
	else
		playRandomKeySound()
	end

	if key == "backspace" then
		cBuff = string.sub(cBuff, 1, #cBuff - 1)
	elseif key == "return" then
		LoveJam.EditCurrentMessageOnTerminal(head .. cBuff, 1)
		handleCommandEnter()

		cBuff = ""

		LoveJam.PushMessageToTerminal(head)
	else
		if keyTranslations[key] then
			key = keyTranslations[key]
		end

		if #key ~= 1 then
			key = ""
		end

		if love.keyboard.isDown("lshift") then
			key = string.upper(key)
		end

		cBuff = cBuff .. key
	end

	LoveJam.EditCurrentMessageOnTerminal(head .. cBuff .. "|", 1)
end

local flashFlag = false
function LoveJam.TerminalFlashThink()
	local doFlash = false
	if (CurTime % 1) >= .5 then
		doFlash = true
	else
		doFlash = false
	end

	if flashFlag ~= doFlash then
		flashFlag = doFlash
		LoveJam.EditCurrentMessageOnTerminal(head .. cBuff .. (flashFlag and "|" or ""), 1)
	end
end