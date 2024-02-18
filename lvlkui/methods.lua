LvLKUI = LvLKUI or {}

-- these are injected automatically
LvLKUI.BaseMethods = {
	["SetPriority"] = function(elm, prio)
		elm.priority = prio or 0
		LvLKUI.RecalculateSortedElementList()
	end,
	["GetPriority"] = function(elm)
		return elm.priority
	end,

	-- pos
	["SetPos"] = function(elm, pos)
		if not pos then
			return
		end

		elm.pos = {pos[1] or 0, pos[2] or 0}
	end,
	["GetPos"] = function(elm)
		return elm.pos
	end,

	-- size
	["SetSize"] = function(elm, size)
		if not size then
			return
		end

		elm.size = {size[1] or 0, size[2] or 0}

		if elm.onSizeChange then
			elm.onSizeChange(elm)
		end
	end,
	["GetSize"] = function(elm)
		return elm.size
	end,

	-- label
	["SetLabel"] = function(elm, label)
		if not label then
			return
		end

		elm.label = label
		if elm.onLabelChange then
			elm.onLabelChange(elm)
		end
	end,
	["GetLabel"] = function(elm)
		return elm.label
	end,

	-- theme
	["SetTheme"] = function(elm, themeName)
		if not themeName then
			return
		end

		elm.theme = themeName
		if elm.onThemeChange then
			elm.onThemeChange(elm)
		end
	end,
	["GetTheme"] = function(elm)
		return elm.theme
	end,

	-- col override
	["SetColourOverride"] = function(elm, primary, secondary, highlight)
		if not primary or not secondary or not highlight then
			elm.doColourOverride = false
			return
		end

		elm.doColourOverride = true
		elm.colOverridePrimary = primary
		elm.colOverrideSecondary = secondary
		elm.colOverrideHighlight = highlight
		if elm.onColourOverrideChange then
			elm.onColourOverrideChange(elm)
		end
	end,
	["GetColourOverride"] = function(elm)
		return elm.doColourOverride, elm.colOverridePrimary, elm.colOverrideSecondary, elm.colOverrideHighlight
	end,

	["GetChild"] = function(elm, tag)
		return elm.children[tag]
	end,


	-- func override things
	["SetOnClick"] = function(elm, func)
		if not func then
			return
		end

		elm.onClick = func
	end,

	["SetOnPaint"] = function(elm, func)
		if not func then
			return
		end

		elm.onPaint = func
	end,

	-- misc...
	["ReInit"] = function(elm)
		if elm.onInit then
			elm.onInit(elm)
		end
	end,
	["Remove"] = function(elm)
		if elm.onRemove then
			elm.onRemove(elm)
		end

		local targetRecalc = elm._parent or LvLKUI.ActiveElements
		local hasParent = elm._parent ~= nil

		if hasParent then
			targetRecalc.children[elm.name] = nil
			elm = nil
			LvLKUI.RecalculateElementSortedChildren(targetRecalc)
		else
			LvLKUI.ActiveElements[elm.name] = nil
			LvLKUI.RecalculateSortedElementList()
		end
	end,
}