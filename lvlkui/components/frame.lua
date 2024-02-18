LvLKUI = LvLKUI or {}

LvLKUI.GLOBAL_DRAGGING = LvLKUI.GLOBAL_DRAGGING or false

LvLKUI.DeclareComponent("frame", {
	["MOUSE_HOVER_EXTERNAL"] = true,
	["MOUSE_CLICK_EXTERNAL"] = false,
	["_isDragging"] = false,
	["_relativePickup"] = {0, 0},

	["label"] = "A frame",
	["_textLabelObj"] = nil,

	["_childrenStash"] = {},
	["_isMinimized"] = false,
	["_formerSize"] = {0, 0},

	["closeDisabled"] = false,

	["SetCloseDisabled"] = function(elm, disable)
		elm.closeDisabled = disable or false
	end,

	-- what to do when we're initialized
	["onInit"] = function(elm)
		elm.children = {}

		local elmSize = elm.size

		local bClose = LvLKUI.NewElement("bClose_Frame", "button")
		bClose:SetPriority(30)
		bClose:SetPos({elmSize[1] - 16, 0})
		bClose:SetSize({16, 16})
		bClose:SetLabel("X")
		bClose:SetOnClick(function()
			if elm.closeDisabled then
				return
			end

			elm:Remove()
		end)
		bClose:SetColourOverride(elm.colOverridePrimary, elm.colOverrideSecondary, {1, 0.25, 0.25})
		bClose:SetOnPaint(function(elm2, w, h, colPrimary, colSecondary, colHighlight, font)
			local _add = 0
			if not elm.closeDisabled then
				local _addHover = elm2._isHovered and 0.1 or 0.0
				local _addMouse = (elm2._isHovered and love.mouse.isDown(1)) and 0.2 or 0
				_add = _addHover + _addMouse
			end

			love.graphics.setColor(colSecondary[1] + _add, colSecondary[2] + _add, colSecondary[3] + _add)
			love.graphics.rectangle("fill", 0, 0, w, h)

			love.graphics.setColor(colPrimary[1] + _add, colPrimary[2] + _add, colPrimary[3] + _add)
			love.graphics.setLineWidth(2)
			love.graphics.rectangle("line", 0, 0, w, h)

			-- align to center
			local textWide, textTall = elm2._textLabelObj:getDimensions()

			local mulDisabled = elm.closeDisabled and .25 or 1

			love.graphics.setColor(colHighlight[1] * mulDisabled, colHighlight[2], colHighlight[3])
			love.graphics.draw(elm2._textLabelObj, (w * .5) - (textWide * .5), (h * .5) - (textTall * .5))
		end)

		LvLKUI.PushElement(bClose, elm)

		local bMinimize = LvLKUI.NewElement("bMinimize_Frame", "button")
		bMinimize:SetPriority(30)
		bMinimize:SetPos({elmSize[1] - 16 - 20, 0})
		bMinimize:SetSize({16, 16})
		bMinimize:SetLabel("-")
		bMinimize:SetColourOverride(elm.colOverridePrimary, elm.colOverrideSecondary, {0.9, 0.9, 1})


		bMinimize:SetOnClick(function()
			local _blacklistNames = {
				["bClose_Frame"] = true,
				["bMinimize_Frame"] = true
			}

			if not elm._isMinimized then
				-- move everything but the GUI buttons to the stash
				for k, v in pairs(elm.children) do
					if not _blacklistNames[k] then
						elm._childrenStash[k] = v
						elm.children[k] = nil
					end
				end

				-- change height so we can click thru
				elm._formerSize = elm.size
				elm.size = {elm._formerSize[1], 18}

				LvLKUI.RecalculateElementSortedChildren(elm)
				elm._isMinimized = true
			else
				-- move everything back
				for k, v in pairs(elm._childrenStash) do
					elm.children[k] = v
				end
				elm._childrenStash = {}

				-- bring back the height
				elm.size = elm._formerSize

				LvLKUI.RecalculateElementSortedChildren(elm)
				elm._isMinimized = false
			end
		end)

		LvLKUI.PushElement(bMinimize, elm)

		-- setup the label, same as button
		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj = love.graphics.newText(theme._fontObj, elm.label)
	end,

	["onSizeChange"] = function(elm)
		local elmSize = elm.size

		local bClose = elm:GetChild("bClose_Frame")
		bClose:SetPos({elmSize[1] - 16, 0})

		local bMinimize = elm:GetChild("bMinimize_Frame")
		bMinimize:SetPos({elmSize[1] - 16 - 20, 0})
	end,

	-- what to do each tick?
	["onThink"] = function(elm)
	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button, hit)
	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my, hit)
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

			if not LvLKUI.Inrange2D({mx, my}, {0, 0}, {elmSize[1], 18}) then
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

	-- what to do when the label changes
	["onLabelChange"] = function(elm)
		elm._textLabelObj:set(elm.label)

		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj:setFont(theme._fontObj)
	end,


	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function(elm, w, h, colPrimary, colSecondary, colHighlight, font)
		love.graphics.setColor(colSecondary[1], colSecondary[2], colSecondary[3])
		love.graphics.rectangle("fill", 0, 0, w, h)

		love.graphics.setColor(colPrimary[1], colPrimary[2], colPrimary[3])
		love.graphics.setLineWidth(2)
		love.graphics.rectangle("line", 0, 0, w, h)

		-- top bar
		love.graphics.rectangle("fill", 0, 0, w, 18)


		love.graphics.setColor(colHighlight[1], colHighlight[2], colHighlight[3])
		love.graphics.draw(elm._textLabelObj, 4, 0)
	end,

	-- what to do when we're removed?
	["onRemove"] = function()
	end,
})