LvLKUI = LvLKUI or {}

LvLKUI.DeclareComponent("label", {
	["label"] = "Label",
	["_textLabelObj"] = nil,
	["alignMode"] = {0, 0}, -- top left

	-- what to do when we're initialized
	["onInit"] = function(elm)
		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj = love.graphics.newText(theme._fontObj, elm.label)
	end,

	-- what to do each tick?
	["onThink"] = function()
	end,

	-- what to do when the label changes
	["onLabelChange"] = function(elm)
		elm._textLabelObj:set(elm.label)

		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj:setFont(theme._fontObj)
	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button)
	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my)
	end,

	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function(elm, w, h, colPrimary, colSecondary, colHighlight, font)
		local textWide, textTall = elm._textLabelObj:getDimensions()

		local aln = elm.alignMode

		local alnXMul = aln[1] * 0.5
		local alnYMul = aln[2] * 0.5


		love.graphics.setColor(colHighlight[1], colHighlight[2], colHighlight[3])
		love.graphics.draw(elm._textLabelObj, -textWide * alnXMul, -textTall * alnYMul)
	end,

	-- what to do when we're removed?
	["onRemove"] = function()
	end,


	["SetAlignMode"] = function(elm, alignmode)
		if not alignmode then
			return
		end

		elm.alignMode = alignmode
	end,
})