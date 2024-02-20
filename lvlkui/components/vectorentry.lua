LvLKUI = LvLKUI or {}

LvLKUI.DeclareComponent("vectorentry", {
	["vCont"] = Vector(0, 0, 0),
	-- what to do when we're initialized
	["onInit"] = function(elm)
		local elmSize = elm.size

		local eWide = elmSize[1] / 3
		local div3 = 1 / 3


		local eX = LvLKUI.NewElement("eX", "textentry")
		eX:SetPriority(30)
		eX:SetPos({0, 0})
		eX:SetSize({eWide, elmSize[2]})
		eX:SetLabel("X")
		eX:SetNumericalOnly(true)
		eX:SetOnTextChange(function(_, new)
			local num = tonumber(new)
			if not num then
				return
			end

			elm.vCont[1] = num
			elm.onVectorChange(elm, elm.vCont)
		end)

		LvLKUI.PushElement(eX, elm)


		local eY = LvLKUI.NewElement("eY", "textentry")
		eY:SetPriority(30)
		eY:SetPos({elmSize[1] * div3, 0})
		eY:SetSize({eWide, elmSize[2]})
		eY:SetLabel("Y")
		eY:SetNumericalOnly(true)
		eY:SetOnTextChange(function(_, new)
			local num = tonumber(new)
			if not num then
				return
			end

			elm.vCont[2] = num
			elm.onVectorChange(elm, elm.vCont)
		end)

		LvLKUI.PushElement(eY, elm)


		local eZ = LvLKUI.NewElement("eZ", "textentry")
		eZ:SetPriority(30)
		eZ:SetPos({elmSize[1] * (div3 * 2), 0})
		eZ:SetSize({eWide, elmSize[2]})
		eZ:SetLabel("Z")
		eZ:SetNumericalOnly(true)
		eZ:SetOnTextChange(function(_, new)
			local num = tonumber(new)
			if not num then
				return
			end

			elm.vCont[3] = num
			elm.onVectorChange(elm, elm.vCont)
		end)

		LvLKUI.PushElement(eZ, elm)
	end,

	["onSizeChange"] = function(elm)
		local elmSize = elm.size
		local eWide = elmSize[1] / 3
		local div3 = 1 / 3

		local eX = elm:GetChild("eX")
		eX:SetPos({0, 0})
		eX:SetSize({eWide, elmSize[2]})

		local eY = elm:GetChild("eY")
		eY:SetPos({elmSize[1] * div3, 0})
		eY:SetSize({eWide, elmSize[2]})

		local eZ = elm:GetChild("eZ")
		eZ:SetPos({elmSize[1] * (div3 * 2), 0})
		eZ:SetSize({eWide, elmSize[2]})
	end,

	-- what to do each tick?
	["onThink"] = function()

	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button)

	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my)

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

	["RefreshEntries"] = function(elm)
		local vCont = elm.vCont

		elm:GetChild("eX"):SetText(vCont[1])
		elm:GetChild("eY"):SetText(vCont[2])
		elm:GetChild("eZ"):SetText(vCont[3])
	end,

	["SetVector"] = function(elm, vec)
		elm.vCont = vec:Copy()

		elm:RefreshEntries()
	end,

	["onVectorChange"] = function(elm, vec)
	end,

	["SetOnChange"] = function(elm, func)
		elm.onVectorChange = func or function() end
	end,

	["GetVector"] = function(elm)
		return elm.vCont
	end,
})