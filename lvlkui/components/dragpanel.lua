LvLKUI = LvLKUI or {}
LvLKUI.GLOBAL_DRAGGING = LvLKUI.GLOBAL_DRAGGING or false

LvLKUI.DeclareComponent("dragpanel", {
	["MOUSE_HOVER_EXTERNAL"] = true,
	["_isDragging"] = false,

	-- what to do when we're initialized
	["onInit"] = function()

	end,

	-- what to do each tick?
	["onThink"] = function()

	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button)

	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my, hit, rx, ry)
		-- wow more terrible hacks
		if LvLKUI.GLOBAL_DRAGGING and LvLKUI.GLOBAL_DRAGGING ~= elm then
			return
		end

		if not elm._isDragging then
			if not hit then
				return
			end

			if not love.mouse.isDown(1) then
				return
			end

			local elmSize = elm.size

			if not LvLKUI.Inrange2D({mx, my}, {0, 0}, {elmSize[1], elmSize[2]}) then
				return
			end

			elm._isDragging = true
			elm._relativePickup = {mx, my}

			LvLKUI.GLOBAL_DRAGGING = elm
		else
			if not love.mouse.isDown(1) then
				elm._isDragging = false
				LvLKUI.GLOBAL_DRAGGING = nil
				return
			end


			local rmx, rmy = love.mouse.getPosition()
			local rela = elm._relativePickup
			elm:SetPos({-rela[1] + rmx, -rela[2] + rmy})
		end
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