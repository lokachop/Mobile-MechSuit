LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}

local stages = {
	["tutoView"] = {
		messages = {
			"Welcome to Mobile MechSuit, in this game you control a mech.",
			"Please move your mouse to the left edge of the screen to look at the terminal."
		},
		trigger = "tutoView",
		nextTuto = "tutoTerminal",
	},
	["tutoTerminal"] = {
		messages = {
			"This is the mech's terminal, here you will control the mech",
			"Enter your username to proceed.",
		},
		trigger = "tutoTerminal",
		nextTuto = "tutoCommands",
	},
	["tutoCommands"] = {
		messages = {
			"You are now signed in, to see a list of commands, type in \"help\"",
		},
		trigger = "tutoCommands",
		nextTuto = "tutoMove",
	},
	["tutoMove"] = {
		messages = {
			"Now, try to move the mech forward by typing in \"fw\"",
		},
		trigger = "tutoMove",
		nextTuto = "tutoGlass1",
	},
	["tutoGlass1"] = {
		messages = {
			"As you should be able to hear, we are now moving.",
			"Move the mouse to the right of the screen to exit the terminal."
		},
		trigger = "tutoGlass1",
		nextTuto = "tutoGlass2",
	},
	["tutoGlass2"] = {
		messages = {
			"Controlling a mech without being aware of your location is a bad idea.",
			"Move your mouse to the top of the screen to look through the windows."
		},
		trigger = "tutoGlass2",
		nextTuto = "tutoGlass3",
	},
	["tutoGlass3"] = {
		messages = {
			"You can rotate your view by holding LMB.",
			"Move the mouse down to exit the window view.",
		},
		trigger = "tutoGlass3",
		nextTuto = "tutoCam1",
	},
	["tutoCam1"] = {
		messages = {
			"In some situations, the glass will close down.",
			"In that case, you can use the camera located to the right.",
		},
		trigger = "tutoCam1",
		nextTuto = "tutoCam2",
	},
	["tutoCam2"] = {
		messages = {
			"If you hold LMB, you can look around with the camera.",
			"Move the mouse to the left to exit the camera view."
		},
		trigger = "tutoCam2",
		nextTuto = "tutoFinal",
	},
	["tutoFinal"] = {
		messages = {
			"Your goal is to make it to the exit, there will be a red light marking it.",
			"Your destination is the reactor of the facility.",
			"Good luck!"
		},
		trigger = "tutoFinal",
		nextTuto = "tutoDone",
	},
	["tutoDone"] = {
		trigger = "",
		nextTuto = "",
	}
}

local currStage = "tutoView"
local function getCurrentTutoData()
	return stages[currStage]
end

local lastSet = 0
local function setTutoStage(target)
	if not stages[target] then
		return
	end


	currStage = target
	lastSet = CurTime
end

function LoveJam.TutoSendTrigger(name)
	local tData = getCurrentTutoData()
	if name == tData.trigger then
		setTutoStage(tData.nextTuto)
	end

end

local w, h = love.graphics.getDimensions()
local scrDiv = (w / 1920) * 32

local fontLarge = love.graphics.newFont(scrDiv)

function LoveJam.RenderTutorial()
	if LoveJam.GetCurrentLevelName() ~= "level_tuto" then
		return
	end

	if (lastSet + 6) < CurTime and currStage == "tutoFinal" then
		LoveJam.TutoSendTrigger("tutoFinal")
	end


	local tData = getCurrentTutoData()
	local msgs = tData.messages
	if not msgs then
		return
	end


	local yBuff = h * .5
	local msgCount = #msgs
	love.graphics.setColor(0, 0, 0, 0.75)
	love.graphics.rectangle("fill", 0, yBuff, w, msgCount * (scrDiv * 1.5))



	for k, v in ipairs(msgs) do
		local tW = fontLarge:getWidth(v)
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.print(v, fontLarge, (w * .5 - (tW * .5)) + 2, yBuff + 2)

		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.print(v, fontLarge, w * .5 - (tW * .5), yBuff)



		yBuff = yBuff + (scrDiv * 1.5)
	end
end
