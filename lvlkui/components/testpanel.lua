LvLKUI = LvLKUI or {}

LvLKUI.DeclareComponent("testpanel", {
	-- what to do when we're initialized
	["onInit"] = function()

	end,

	-- what to do each tick?
	["onThink"] = function()

	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button)
		print("You clicked me! Relative: x" .. mx .. ", y" .. my)
	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my)
		print("You hovered over me!")
	end,

	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function(elm, w, h, colPrimary, colSecondary, colHighlight, font)
		love.graphics.setColor(colSecondary[1], colSecondary[2], colSecondary[3])
		love.graphics.rectangle("fill", 0, 0, w, h)

		love.graphics.setColor(colPrimary[1], colPrimary[2], colPrimary[3])
		love.graphics.setLineWidth(4)
		love.graphics.rectangle("line", 0, 0, w, h)
	end,

	-- what to do when we're removed?
	["onRemove"] = function()

	end,
})