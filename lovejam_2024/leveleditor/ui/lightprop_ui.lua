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


function LKEdit.InitFrameLightProp()
	local w, h = love.graphics.getDimensions()

	LKEdit.FLightProp = LvLKUI.NewElement("f_lightProp", "frame")
	LKEdit.FLightProp:SetPriority(20)
	LKEdit.FLightProp:SetPos({32, h - (32 + 256)})
	LKEdit.FLightProp:SetSize({256, 256})
	LKEdit.FLightProp:SetLabel("lightProperties")
	LKEdit.FLightProp:SetCloseDisabled(true)
	LKEdit.FLightProp:ReInit()

	local yAccum = 32

	local l_selected = LvLKUI.NewElement("l_selected", "label")
	l_selected:SetPos({32, yAccum})
	l_selected:SetLabel("[0] (none)")
	LvLKUI.PushElement(l_selected, LKEdit.FLightProp)
	yAccum = yAccum + 24

	shitLabel(LKEdit.FLightProp, "pos", yAccum)
	yAccum = yAccum + 24

	local v_lightPos = LvLKUI.NewElement("v_lightPos", "vectorentry")
	v_lightPos:SetPos({32, yAccum})
	v_lightPos:SetSize({256 - 64, 16})
	v_lightPos:SetVector(Vector(0, 0, 0))
	v_lightPos:SetOnChange(function(elm, newVec)
		if not newVec then
			return
		end

		LKEdit.SetSelectedEntityParameter("pos", newVec, "light")
	end)
	v_lightPos:RefreshEntries()
	LvLKUI.PushElement(v_lightPos, LKEdit.FLightProp)
	yAccum = yAccum + 24

	shitLabel(LKEdit.FLightProp, "intensity", yAccum)
	yAccum = yAccum + 24
	local e_lightIntensity = LvLKUI.NewElement("e_lightIntensity", "textentry")
	e_lightIntensity:SetPos({32, yAccum})
	e_lightIntensity:SetSize({256 - 64, 16})
	e_lightIntensity:SetText(1)
	e_lightIntensity:SetNumericalOnly(true)
	e_lightIntensity:SetOnTextChange(function(elm, new)
		new = tonumber(new)
		if not new then
			return
		end

		LKEdit.SetSelectedEntityParameter("int", new, "light")
	end)
	LvLKUI.PushElement(e_lightIntensity, LKEdit.FLightProp)
	yAccum = yAccum + 24



	shitLabel(LKEdit.FLightProp, "col", yAccum)
	yAccum = yAccum + 24
	local v_lightCol = LvLKUI.NewElement("v_lightCol", "vectorentry")
	v_lightCol:SetPos({32, yAccum})
	v_lightCol:SetSize({256 - 64, 16})
	v_lightCol:SetVector(Vector(255, 255, 255))
	v_lightCol:SetOnChange(function(elm, new)
		if not new then
			return
		end

		LKEdit.SetSelectedEntityParameter("col", {new[1] / 255, new[2] / 255, new[3] / 255}, "light")
	end)
	v_lightCol:RefreshEntries()
	LvLKUI.PushElement(v_lightCol, LKEdit.FLightProp)
	yAccum = yAccum + 24

	LvLKUI.PushElement(LKEdit.FLightProp)
end


function LKEdit.PushFrameLightProps(light, eType, id)
	local l_selected = LKEdit.FLightProp:GetChild("l_selected")
	l_selected:SetLabel("[" .. id .. "] (" .. eType .. ")")

	local childPos = LKEdit.FLightProp:GetChild("v_lightPos")
	childPos:SetVector(light.pos)

	local childInt = LKEdit.FLightProp:GetChild("e_lightIntensity")
	childInt:SetText(light.int)

	local childCol = LKEdit.FLightProp:GetChild("v_lightCol")
	childCol:SetVector(Vector(math.floor(light.col[1] * 255), math.floor(light.col[2] * 255), math.floor(light.col[3] * 255)))
end