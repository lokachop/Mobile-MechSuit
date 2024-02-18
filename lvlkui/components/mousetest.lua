LvLKUI = LvLKUI or {}

LvLKUI.DeclareComponent("mousetest", {
	["_hoverPoint"] = {0, 0},
	["_clickPoint"] = {0, 0},
	["MOUSE_CAPTURE_EXTERNAL"] = false,

	-- what to do when we're initialized
	["onInit"] = function()

	end,

	-- what to do each tick?
	["onThink"] = function()

	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button, hit)
		--if not hit then
		--	return
		--end

		elm._clickPoint = {mx, my}
	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my, hit)
		--if not hit then
		--	return
		--end

		elm._hoverPoint = {mx, my}
	end,

	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function(elm, w, h, colPrimary, colSecondary, colHighlight, font)
		love.graphics.setColor(colSecondary[1], colSecondary[2], colSecondary[3])
		love.graphics.rectangle("fill", 0, 0, w, h)

		love.graphics.setColor(colPrimary[1], colPrimary[2], colPrimary[3])
		love.graphics.setLineWidth(4)
		love.graphics.rectangle("line", 0, 0, w, h)


		love.graphics.setColor(colHighlight[1], colHighlight[2], colHighlight[3])
		local hoverPos = elm._hoverPoint
		love.graphics.rectangle("fill", hoverPos[1] - 8, hoverPos[2] - 8, 16, 16)

		love.graphics.setColor(1, 0, 0)
		local clickPos = elm._clickPoint
		love.graphics.rectangle("fill", clickPos[1] - 4, clickPos[2] - 4, 8, 8)

	end,

	-- what to do when we're removed?
	["onRemove"] = function()

	end,
})