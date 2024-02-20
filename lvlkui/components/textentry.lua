local utf8 = require("utf8")

LvLKUI = LvLKUI or {}
LvLKUI.GLOBAL_HAS_TEXT_ENTRY = false

local cursorIBeam = love.mouse.getSystemCursor("ibeam")

LvLKUI.DeclareComponent("textentry", {
	["MOUSE_CLICK_EXTERNAL"] = true,
	["MOUSE_HOVER_EXTERNAL"] = true,
	["label"] = "Enter text here...",
	["textBuffer"] = "",
	["_textLabelObj"] = nil,
	["_isCaptured"] = false,
	["_dtTimer"] = 0,
	["maxLength"] = 0,
	["numericalOnly"] = false,
	["allowDecimals"] = true,

	-- what to do when we're initialized
	["onInit"] = function(elm)
		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj = love.graphics.newText(theme._fontObj, elm.label)
	end,

	-- what to do each tick?
	["onThink"] = function(elm, dt)
		elm._dtTimer = elm._dtTimer + dt
	end,

	-- what to do when the label changes
	["onLabelChange"] = function(elm)
		elm._textLabelObj:set(elm.label)

		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj:setFont(theme._fontObj)
	end,

	["EscapeInput"] = function(elm)
		if not elm._isCaptured then
			return
		end

		if not LvLKUI.GLOBAL_HAS_TEXT_ENTRY then
			return
		end

		LvLKUI.GLOBAL_HAS_TEXT_ENTRY = false
		elm._isCaptured = false
	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button, hit)
		if elm._isCaptured and (not hit) then

			elm:EscapeInput()
			return
		end

		if not hit then
			return
		end

		if LvLKUI.GLOBAL_HAS_TEXT_ENTRY then
			return
		end

		LvLKUI.GLOBAL_HAS_TEXT_ENTRY = true
		elm._isCaptured = true
	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my, hit)
		if hit then
			love.mouse.setCursor(cursorIBeam)
		else
			love.mouse.setCursor()
		end
	end,

	-- internal
	["onKeyPress"] = function(elm, key, isKeypress)
		if not LvLKUI.GLOBAL_HAS_TEXT_ENTRY then
			return
		end

		if not elm._isCaptured then
			return
		end

		local isCtrl = love.keyboard.isDown("lctrl")
		if isCtrl and key == "v" then
			elm.textBuffer = string.sub(elm.textBuffer .. love.system.getClipboardText(), 0, elm.maxLength == 0 and 12800 or elm.maxLength)
		end

		if key == "escape" then
			elm:EscapeInput()
			return
		end

		if key == "return" then
			elm:EscapeInput()

			elm.onEnter(elm, elm.textBuffer)
			return
		end

		if key == "backspace" then
			-- https://love2d.org/wiki/love.textinput
			local byteoffset = utf8.offset(elm.textBuffer, -1)
			if byteoffset then
				elm.textBuffer = string.sub(elm.textBuffer, 1, byteoffset - 1)
			end
		end

		if not isKeypress then -- add if we're on textinput
			local concatCalc = elm.textBuffer .. key
			if (elm.maxLength ~= 0) and (#concatCalc > elm.maxLength) then
				return
			end

			if not elm.allowDecimals and key == "." then
				return
			end

			if elm.numericalOnly and tonumber(concatCalc) == nil then
				if key == "." then
					concatCalc = elm.textBuffer .. ("0" .. key)
				elseif key == "-" and (#concatCalc <= 1) then
					concatCalc = concatCalc -- so linter doesnt hate me
				else
					return
				end
			end

			elm.textBuffer = concatCalc
		end

		local buff = elm.textBuffer

		local setMsg = buff
		if buff == "" then
			setMsg = elm.label
		end

		elm._textLabelObj:set(setMsg)

		elm._dtTimer = .5
		elm.onTextChange(elm, elm.textBuffer)
	end,

	-- for user
	["onTextChange"] = function(elm, message)
	end,

	["SetOnTextChange"] = function(elm, func)
		if not func then
			return
		end

		elm.onTextChange = func
	end,

	["onEnter"] = function(elm, message)
	end,

	["SetOnEnter"] = function(elm, func)
		if not func then
			return
		end

		elm.onEnter = func
	end,


	["SetText"] = function(elm, text)
		if not text then
			return
		end

		elm.textBuffer = text
		elm._textLabelObj:set(elm.textBuffer)
	end,

	["GetText"] = function(elm, text)
		return elm.textBuffer
	end,


	["SetMaxLength"] = function(elm, len)
		if not len then
			return
		end

		elm.maxLength = len
	end,

	["GetMaxLength"] = function(elm, text)
		return elm.maxLength
	end,

	["SetNumericalOnly"] = function(elm, bool)
		if not bool then
			return
		end

		elm.numericalOnly = bool
	end,

	["GetNumericalOnly"] = function(elm, text)
		return elm.numericalOnly
	end,

	["SetAllowDecimals"] = function(elm, bool)
		if not bool then
			return
		end

		elm.allowDecimals = bool
	end,

	["GetAllowDecimals"] = function(elm, text)
		return elm.allowDecimals
	end,

	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function(elm, w, h, colPrimary, colSecondary, colHighlight, font)
		local _add = elm._isCaptured and 0.05 or 0.0


		love.graphics.setColor(colSecondary[1] + _add, colSecondary[2] + _add, colSecondary[3] + _add)
		love.graphics.rectangle("fill", 0, 0, w, h)

		love.graphics.setColor(colPrimary[1] + _add, colPrimary[2] + _add, colPrimary[3] + _add)
		love.graphics.setLineWidth(2)
		love.graphics.rectangle("line", 0, 0, w, h)

		local textWide, textTall = elm._textLabelObj:getDimensions()

		local eMul = 1
		local cont = elm.textBuffer
		if cont == "" then
			cont = elm.label
			eMul = 0.25
			textWide = 0
		end


		love.graphics.setColor(colHighlight[1], colHighlight[2], colHighlight[3], eMul)
		love.graphics.draw(elm._textLabelObj, 2, (h * 0.5) - textTall * 0.5)

		if not elm._isCaptured then
			return
		end

		local blinkVar = math.floor((elm._dtTimer * 2) % 2)
		if blinkVar == 0 then
			return
		end

		love.graphics.setColor(colHighlight[1], colHighlight[2], colHighlight[3], 1)
		love.graphics.rectangle("fill", textWide + 2, (h * .25) * .5, 1, h * .75)
	end,

	-- what to do when we're removed?
	["onRemove"] = function()
	end,
})