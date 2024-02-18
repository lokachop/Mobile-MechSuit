LvLKUI = LvLKUI or {}

local function renderElement(elm)
	local pos, size = elm.pos, elm.size
	love.graphics.push()
	love.graphics.translate(pos[1], pos[2])
		local theme = LvLKUI.Themes[elm.theme]
		if not theme then
			error("Theme \"" .. elm.theme .. "\" doesnt exist!")
		end

			local primary = theme.primary
			local secondary = theme.secondary
			local highlight = theme.highlight
			if elm.doColourOverride == true then
				primary = elm.colOverridePrimary
				secondary = elm.colOverrideSecondary
				highlight = elm.colOverrideHighlight
			end

			elm.onPaint(elm, size[1], size[2], primary, secondary, highlight, theme._fontObj)


		if elm._childCount > 0 then
			-- render the children
			for i = #elm._sortedChildren, 1, -1 do
				local child = elm._sortedChildren[i]
				renderElement(child)
			end
		end
	love.graphics.pop()
end


function LvLKUI.DrawAll()
	for i = #LvLKUI.SortedElements, 1, -1 do -- lowest priority to highest (painters algo, it overdraws...)
		local elm = LvLKUI.SortedElements[i]
		renderElement(elm)
	end
end