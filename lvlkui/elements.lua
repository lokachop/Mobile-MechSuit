LvLKUI = LvLKUI or {}

LvLKUI.ActiveElements = LvLKUI.ActiveElements or {}
LvLKUI.SortedElements = LvLKUI.SortedElements or {}

function LvLKUI.RecalculateSortedElementList()
	--print("LvLKUI: --==recalc. sorted element list...==--")
	LvLKUI.SortedElements = {}

	for k, v in pairs(LvLKUI.ActiveElements) do
		LvLKUI.SortedElements[#LvLKUI.SortedElements + 1] = v
	end

	--[[
	print("LvLKUI: --presort--;")
	for k, v in ipairs(LvLKUI.SortedElements) do
		print("[" .. k .. "]: " .. v.name .. "(" .. v.priority .. ")")
	end
	]]--

	-- sort by priority
	table.sort(LvLKUI.SortedElements, function(a, b)
		return a.priority > b.priority
	end)

	--[[
	print("LvLKUI: --postsort--;")
	for k, v in ipairs(LvLKUI.SortedElements) do
		print("[" .. k .. "]: " .. v.name .. "(" .. v.priority .. ")")
	end
	]]--
end

function LvLKUI.RecalculateElementSortedChildren(elm)
	--print("LvLKUI: --==recalc. sorted children list...==--")
	elm._sortedChildren = {}

	for k, v in pairs(elm.children) do
		if v._childCount > 0 then
			LvLKUI.RecalculateElementSortedChildren(v)
		end

		elm._sortedChildren[#elm._sortedChildren + 1] = v
	end

	-- sort by priority
	table.sort(elm._sortedChildren, function(a, b)
		return a.priority > b.priority
	end)
end

function LvLKUI.NewElement(name, component)
	if not name then
		print("LvLKUI: Attempt to create element with no name!")
		return
	end

	if not component then
		print("LvLKUI: Attempt to create element with no component!")
		return
	end

	if not LvLKUI.Components[component] then
		print("Component \"" .. component .. "\" doesnt exist!")
		return
	end

	local elm = LvLKUI.GetNewComponentCopy(component)
	elm.name = name
	elm.component = component

	local theme = LvLKUI.Themes[elm.theme]
	if not theme then
		error("Non-existant \"" .. elm.theme .. "\", FATAL!")
	end

	elm.colOverridePrimary = theme.primary
	elm.colOverrideSecondary = theme.secondary
	elm.colOverrideHighlight = theme.highlight

	elm.onInit(elm)
	return elm
end

function LvLKUI.PushElement(elm, parent)
	if parent then
		parent.children[elm.name] = elm
		parent._childCount = parent._childCount + 1
		elm._parent = parent

		--print(parent.name .. ".children[" .. elm.name .. "]: {comp. \"" .. elm.component .. "\"}")

		LvLKUI.RecalculateElementSortedChildren(parent)
	else
		if LvLKUI.ActiveElements[elm.name] ~= nil then
			error("Element \"" .. elm.name .. "\" already exists in global space, BAD!")
		end

		LvLKUI.ActiveElements[elm.name] = elm
		--print("LvLKUI.ActiveElements[" .. elm.name .. "]: {comp. \"" .. elm.component .. "\"}")

		LvLKUI.RecalculateSortedElementList()
	end
end

function LvLKUI.RemoveElement(tag, parent)
	if parent then
		if not parent.children[tag] then
			return
		end

		local elm = parent.children[tag]
		if elm.onRemove then
			elm.onRemove(elm)
		end

		parent.children[tag] = nil
		parent._childCount = parent._childCount - 1

		LvLKUI.RecalculateElementSortedChildren(parent)
	else
		if not LvLKUI.ActiveElements[tag] then
			return
		end

		local elm = LvLKUI.ActiveElements[tag]
		if elm.onRemove then
			elm.onRemove(elm)
		end


		LvLKUI.ActiveElements[tag] = nil
		LvLKUI.RecalculateSortedElementList()
	end
end

function LvLKUI.GetElement(tag, parent)
	if parent then
		return parent.children[tag]
	else
		return LvLKUI.ActiveElements[tag]
	end
end