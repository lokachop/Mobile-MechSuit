LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}


local function shitLabel(parent, text, yAccum)
	local label = LvLKUI.NewElement("label" .. text, "label")
	label:SetPos({32, yAccum})
	label:SetLabel(text)
	LvLKUI.PushElement(label, parent)
end

local function checkAndLabel(parent, label, onChange, yAccum)
	local labelObj = LvLKUI.NewElement("labelCheck" .. label, "label")
	labelObj:SetPos({32, yAccum})
	labelObj:SetLabel(label)
	LvLKUI.PushElement(labelObj, parent)

	local c_prop = LvLKUI.NewElement("c_prop" .. label, "checkbox")
	c_prop:SetPos({256 + 16, yAccum})
	c_prop:SetSize({16, 16})
	c_prop:SetOnChange(onChange)
	LvLKUI.PushElement(c_prop, parent)

end

function LKEdit.InitFrameEntProp()
	local w, h = love.graphics.getDimensions()

	LKEdit.FEntProp = LvLKUI.NewElement("f_entProp", "frame")
	LKEdit.FEntProp:SetPriority(20)
	LKEdit.FEntProp:SetPos({w - (256 + 64) - 32, 32 + 256})
	LKEdit.FEntProp:SetSize({256 + 64, 512})
	LKEdit.FEntProp:SetLabel("EntProperties")
	LKEdit.FEntProp:SetCloseDisabled(true)
	LKEdit.FEntProp:ReInit()

	local yAccum = 32

	local l_selected = LvLKUI.NewElement("l_selected", "label")
	l_selected:SetPos({32, yAccum})
	l_selected:SetLabel("[0] (none)")
	LvLKUI.PushElement(l_selected, LKEdit.FEntProp)
	yAccum = yAccum + 24

	shitLabel(LKEdit.FEntProp, "pos", yAccum)
	yAccum = yAccum + 24

	local v_entPos = LvLKUI.NewElement("v_entPos", "vectorentry")
	v_entPos:SetPos({32, yAccum})
	v_entPos:SetSize({256, 16})
	v_entPos:SetVector(Vector(0, 0, 0))
	v_entPos:SetOnChange(function(elm, newVec)
		if not newVec then
			return
		end

		LKEdit.SetSelectedEntityParameter("pos", newVec, "deco")
	end)
	v_entPos:RefreshEntries()
	LvLKUI.PushElement(v_entPos, LKEdit.FEntProp)
	yAccum = yAccum + 24


	shitLabel(LKEdit.FEntProp, "ang", yAccum)
	yAccum = yAccum + 24
	local v_entAng = LvLKUI.NewElement("v_entAng", "vectorentry")
	v_entAng:SetPos({32, yAccum})
	v_entAng:SetSize({256, 16})
	v_entAng:SetVector(Angle(0, 0, 0))
	v_entAng:SetOnChange(function(elm, newVec)
		if not newVec then
			return
		end

		LKEdit.SetSelectedEntityParameter("ang", newVec, "deco")
	end)
	v_entAng:RefreshEntries()
	LvLKUI.PushElement(v_entAng, LKEdit.FEntProp)
	yAccum = yAccum + 24


	shitLabel(LKEdit.FEntProp, "scl", yAccum)
	yAccum = yAccum + 24
	local v_entScl = LvLKUI.NewElement("v_entScl", "vectorentry")
	v_entScl:SetPos({32, yAccum})
	v_entScl:SetSize({256, 16})
	v_entScl:SetVector(Vector(1, 1, 1))
	v_entScl:SetOnChange(function(elm, newVec)
		if not newVec then
			return
		end

		LKEdit.SetSelectedEntityParameter("scl", newVec, "deco")
	end)
	v_entScl:RefreshEntries()
	LvLKUI.PushElement(v_entScl, LKEdit.FEntProp)
	yAccum = yAccum + 24


	shitLabel(LKEdit.FEntProp, "mdl", yAccum)
	yAccum = yAccum + 24
	local e_entMdl = LvLKUI.NewElement("e_entMdl", "textentry")
	e_entMdl:SetPos({32, yAccum})
	e_entMdl:SetSize({256, 16})
	e_entMdl:SetText("cube")
	e_entMdl:SetOnTextChange(function(elm, new)
		if not LvLK3D.Models[new] then
			return
		end

		LKEdit.SetSelectedEntityParameter("mdl", new, "deco")
	end)
	LvLKUI.PushElement(e_entMdl, LKEdit.FEntProp)
	yAccum = yAccum + 24

	shitLabel(LKEdit.FEntProp, "mat", yAccum)
	yAccum = yAccum + 24
	local e_entMat = LvLKUI.NewElement("e_entMat", "textentry")
	e_entMat:SetPos({32, yAccum})
	e_entMat:SetSize({256, 16})
	e_entMat:SetText("none")
	e_entMat:SetOnTextChange(function(elm, new)
		if not LvLK3D.Textures[new] then
			return
		end

		LKEdit.SetSelectedEntityParameter("mat", new, "deco")
	end)
	LvLKUI.PushElement(e_entMat, LKEdit.FEntProp)
	yAccum = yAccum + 32

	checkAndLabel(LKEdit.FEntProp, "fullbright", function(elm, new)
		LKEdit.SetSelectedEntityParameter("fullbright", new, "deco")
	end, yAccum)
	yAccum = yAccum + 32

	checkAndLabel(LKEdit.FEntProp, "shaded", function(elm, new)
		LKEdit.SetSelectedEntityParameter("shaded", new, "deco")
	end, yAccum)
	yAccum = yAccum + 32

	checkAndLabel(LKEdit.FEntProp, "shadow", function(elm, new)
		LKEdit.SetSelectedEntityParameter("shadow", new, "deco")
	end, yAccum)
	yAccum = yAccum + 32


	LvLKUI.PushElement(LKEdit.FEntProp)
end


function LKEdit.PushFrameEntProps(ent, eType, id)
	local l_selected = LKEdit.FEntProp:GetChild("l_selected")
	l_selected:SetLabel("[" .. id .. "] (" .. eType .. ")")

	local childPos = LKEdit.FEntProp:GetChild("v_entPos")
	childPos:SetVector(ent.pos)

	local childAng = LKEdit.FEntProp:GetChild("v_entAng")
	childAng:SetVector(ent.ang)

	local childScl = LKEdit.FEntProp:GetChild("v_entScl")
	childScl:SetVector(ent.scl)

	local childMdl = LKEdit.FEntProp:GetChild("e_entMdl")
	childMdl:SetText(ent.mdl)

	local childMat = LKEdit.FEntProp:GetChild("e_entMat")
	childMat:SetText(ent.mat)

	local childFullbright = LKEdit.FEntProp:GetChild("c_prop" .. "fullbright")
	childFullbright:SetValue(ent.fullbright)

	local childShaded = LKEdit.FEntProp:GetChild("c_prop" .. "shaded")
	childShaded:SetValue(ent.shaded)

	local childShadow = LKEdit.FEntProp:GetChild("c_prop" .. "shadow")
	childShadow:SetValue(ent.shadow)
end