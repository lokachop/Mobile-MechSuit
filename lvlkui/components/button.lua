LvLKUI = LvLKUI or {}

local cursorClick = love.mouse.getSystemCursor("hand")

LvLKUI.DeclareComponent("button", {
	["label"] = "Button",
	["_isHovered"] = false,
	["MOUSE_HOVER_EXTERNAL"] = true,
	["MOUSE_CLICK_EXTERNAL"] = false,
	["_textLabelObj"] = nil,
	["isDisabled"] = false,

	-- what to do when we're initialized
	["onInit"] = function(elm)
		local theme = LvLKUI.Themes[elm.theme]

		elm._textLabelObj = love.graphics.newText(theme._fontObj, elm.label)
	end,

	-- what to do each tick?
	["onThink"] = function()
	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button, hit)
	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my, hit)
		elm._isHovered = hit

		if hit then
			love.mouse.setCursor(cursorClick)
		else
			love.mouse.setCursor()
		end
	end,

	-- what to do when the label changes
	["onLabelChange"] = function(elm)
		elm._textLabelObj:set(elm.label)

		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj:setFont(theme._fontObj)
	end,


	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function(elm, w, h, colPrimary, colSecondary, colHighlight, font)
		local _addHover = elm._isHovered and 0.1 or 0.0
		local _addMouse = (elm._isHovered and love.mouse.isDown(1)) and 0.2 or 0

		local _add = _addHover + _addMouse

		love.graphics.setColor(colSecondary[1] + _add, colSecondary[2] + _add, colSecondary[3] + _add)
		love.graphics.rectangle("fill", 0, 0, w, h)

		love.graphics.setColor(colPrimary[1] + _add, colPrimary[2] + _add, colPrimary[3] + _add)
		love.graphics.setLineWidth(2)
		love.graphics.rectangle("line", 0, 0, w, h)

		-- align to center
		local textWide, textTall = elm._textLabelObj:getDimensions()


		love.graphics.setColor(colHighlight[1], colHighlight[2], colHighlight[3])
		love.graphics.draw(elm._textLabelObj, (w * .5) - (textWide * .5), (h * .5) - (textTall * .5))

	end,

	-- what to do when we're removed?
	["onRemove"] = function()
	end,
})