LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local fontLarge = love.graphics.newFont(64)
local fontSz = 16
local fontSmall = love.graphics.newFont("fonts/terminal.ttf", fontSz, "mono")
local termSize = 512

local canvasTerm = love.graphics.newCanvas(termSize, termSize)
canvasTerm:setFilter("nearest", "nearest")

LvLK3D.NewTextureFunc("terminal_tex", termSize, termSize, function()
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
local shaderCRT = love.graphics.newShader(LvLK3D.RelaPath .. "/shader/screen/crt.frag")
local function refreshTerminal()
	love.graphics.setCanvas(canvasTerm)
		love.graphics.clear(0.0, 0.05, 0.0, 1, true, true)


		love.graphics.setColor(0, 1, 0)
		local yBuff = termSize - fontSz - 2
		for i = #terminalBuffer, 1, -1 do
			local val = terminalBuffer[i]
			if not val then
				return
			end

			love.graphics.print(val, fontSmall, 0, yBuff)
			yBuff = yBuff - fontSz
		end
	love.graphics.setCanvas()



	LvLK3D.RenderTexture("terminal_tex", function()
		love.graphics.clear(0.0, 0.0, 0.0, 1, true, true)
		love.graphics.setColor(1, 1, 1, 1)

		local warp = 0
		local scan = .75

		love.graphics.setShader(shaderCRT)
		shaderCRT:send("warp", warp)
		shaderCRT:send("scan", scan)
		shaderCRT:send("screenSize", {termSize, termSize})
		love.graphics.draw(canvasTerm, 0, 0)
		love.graphics.setShader()
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
		desc = params.desc or "No description",
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
	params = ""

	if commandState == "none" then
		local cGrab = string.lower(cBuff)
		local cmd, args = string.match(cGrab, "([^ ]+) ?(.*)$")

		cmdTarget = cmd
		params = args
	end

	local cmd = commandTable[cmdTarget]
	if not cmd then
		LoveJam.PushMessageToTerminal("Unknown Command \"" .. cmdTarget .. "\"!")
		return
	end

	if commandState ~= cmdTarget then
		setCommandState(cmdTarget)
		cmd.onFirst(cBuff, params)
	else
		cmd.onEnter(cBuff)
	end
end


newCommand("username", {
	desc = "Changes your username",
	onFirst = function(msg, args)
		LoveJam.PushMessageToTerminal("Please enter your username.")
	end,
	onEnter = function(msg)
		LoveJam.PushMessageToTerminal("Welcome, " .. msg)
		LoveJam.PushMessageToTerminal("Remember to follow the contract guidelines,")
		LoveJam.PushMessageToTerminal("Failure to do so will result in termination.")

		username = msg
		head = username .. "@mech0> "
		setCommandState("none")
		LoveJam.TutoSendTrigger("tutoTerminal")
	end,
})

newCommand("help", {
	desc = "Displays list of commands",
	onFirst = function(msg, args)
		LoveJam.PushMessageToTerminal("--==Commands==--")
		for k, v in pairs(commandTable) do
			if not v.hidden then
				LoveJam.PushMessageToTerminal("[" .. k .. "]")
				LoveJam.PushMessageToTerminal("    " .. v.desc)
			end
		end
		setCommandState("none")
		LoveJam.TutoSendTrigger("tutoCommands")
	end,
	onEnter = function(msg)
	end,
})

newCommand("clear", {
	desc = "Clears the terminal",
	onFirst = function(msg, args)
		LoveJam.ClearTerminalBuffer()
		setCommandState("none")
	end,
	onEnter = function(msg)
	end,
})

newCommand("fw", {
	desc = "Moves the mech forward, can specify amount [fw 8]",
	onFirst = function(msg, args)
		setCommandState("none")

		if LoveJam.IsMechMoving() then
			LoveJam.PushMessageToTerminal("Mech is still moving, aborting!")
			return
		end

		local count = tonumber(args) or 1

		if count > 1 then
			LoveJam.MultiMoveForward(count)
			LoveJam.PushMessageToTerminal("Moving forward " .. count .. " times!")
			return
		end



		local moved = LoveJam.MoveMechForward()
		if moved then
			LoveJam.PushMessageToTerminal("Moving forward!")
		else
			LoveJam.PushMessageToTerminal("Obstacle detected, halting...")
		end

		LoveJam.TutoSendTrigger("tutoMove")
	end,
	onEnter = function(msg)
	end,
})


newCommand("left", {
	desc = "Rotates the mech left",
	onFirst = function()
		setCommandState("none")

		if LoveJam.IsMechMoving() then
			LoveJam.PushMessageToTerminal("Mech is still moving, aborting!")
			return
		end

		LoveJam.PushMessageToTerminal("Rotating left!")
		LoveJam.RotateMechLeft()
	end,
	onEnter = function(msg)
	end,
})

newCommand("right", {
	desc = "Rotates the mech right",
	onFirst = function()
		setCommandState("none")

		if LoveJam.IsMechMoving() then
			LoveJam.PushMessageToTerminal("Mech is still moving, aborting!")
			return
		end

		LoveJam.PushMessageToTerminal("Rotating right!")
		LoveJam.RotateMechRight()
	end,
	onEnter = function(msg)
	end,
})


newCommand("lore1", {
	hidden = true,
	desc = "Something",
	onFirst = function(msg, args)
		LoveJam.PushMessageToTerminal("Lore Bla Bla Bla")
		LoveJam.PushMessageToTerminal("Lore Line 2 Bla Bla Bla!")
		setCommandState("none")
	end,
	onEnter = function(msg)
	end,
})

newCommand("instructions", {
	hidden = false,
	desc = "Instructions for operation of MCU",
	onFirst = function(msg, args)
		LoveJam.PushMessageToTerminal("Detailed guidance regarding the tasks assigned to associates under contract #AZ1567. It is ")
		LoveJam.PushMessageToTerminal("imperative that we adhere to the outlined responsibilities to ensure the successful completion of ")
		LoveJam.PushMessageToTerminal("our objectives.")
		LoveJam.PushMessageToTerminal("			")
		LoveJam.PushMessageToTerminal("1) Acquisition of Mech Suit")
		LoveJam.PushMessageToTerminal("2) Navigation through Reactor Complex 5")
		LoveJam.PushMessageToTerminal("3) Piloting the Mech into Reactor Core")
		LoveJam.PushMessageToTerminal("4) Exiting the MCU")
		setCommandState("none")
	end,
	onEnter = function(msg)
	end,
})

newCommand("controller", {
	hidden = true,
	desc = "Current Operator of MCU: ",
	onFirst = function(msg, args)
		LoveJam.PushMessageToTerminal("Name: [error]")
		LoveJam.PushMessageToTerminal("Occupation: Mech suit pilot, CLASS 4")
		LoveJam.PushMessageToTerminal("Service History: 24yrs")
		LoveJam.PushMessageToTerminal("Occupational record: Minor Lacerations 11:56:11, Minor Radiation exposure ")
		LoveJam.PushMessageToTerminal("98:56:92, Major Radiation Exposure - 99:70:70")
		LoveJam.PushMessageToTerminal("Assignment success rate 72%")
		setCommandState("none")
	end,
	onEnter = function(msg)
	end,
})

newCommand("lefton", {
	hidden = true,
	desc = "Lefton",
	onFirst = function(msg, args)
		LoveJam.PushMessageToTerminal("I made the last level and most of the textures")
		setCommandState("none")
	end,
	onEnter = function(msg)
	end,
})

newCommand("loka", {
	hidden = true,
	desc = "Lefton",
	onFirst = function(msg, args)
		LoveJam.PushMessageToTerminal("I made the game :|")
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