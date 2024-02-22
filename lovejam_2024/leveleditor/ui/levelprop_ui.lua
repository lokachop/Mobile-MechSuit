LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

function LKEdit.InitFrameLevelInfo()
	LKEdit.FLevelInfo = LvLKUI.NewElement("frame_load", "frame")
	LKEdit.FLevelInfo:SetPriority(20)
	LKEdit.FLevelInfo:SetPos({32, 32})
	LKEdit.FLevelInfo:SetSize({256, 256 + 64})
	LKEdit.FLevelInfo:SetLabel("LevelInfo")
	LKEdit.FLevelInfo:SetCloseDisabled(true)
	LKEdit.FLevelInfo:ReInit()

	local yAccum = 26

	local e_levelName = LvLKUI.NewElement("e_levelName", "textentry")
	e_levelName:SetPos({16, yAccum})
	e_levelName:SetSize({256 - 32, 16})
	e_levelName:SetLabel("LevelName")
	e_levelName:SetText(LKEdit.CurrLevel.name)
	e_levelName:SetMaxLength(512)
	e_levelName:SetOnTextChange(function(elm, new)
		if not new then
			return
		end

		LKEdit.CurrLevel.name = string.lower(new)
	end)
	LvLKUI.PushElement(e_levelName, LKEdit.FLevelInfo)
	yAccum = yAccum + 24




	local b_levelLoad = LvLKUI.NewElement("b_levelLoad", "button")
	b_levelLoad:SetPos({16, yAccum})
	b_levelLoad:SetSize({128 - 32, 24})
	b_levelLoad:SetLabel("load")
	b_levelLoad:SetOnClick(function(elm)
		LKEdit.LoadLevel(string.lower(LKEdit.CurrLevel.name))
	end)
	LvLKUI.PushElement(b_levelLoad, LKEdit.FLevelInfo)


	local b_levelSave = LvLKUI.NewElement("b_levelSave", "button")
	b_levelSave:SetPos({16 + (128 - 32) + 32, yAccum})
	b_levelSave:SetSize({128 - 32, 24})
	b_levelSave:SetLabel("save")
	b_levelSave:SetOnClick(function(elm)
		LKEdit.SaveLevel(string.lower(LKEdit.CurrLevel.name))
	end)
	LvLKUI.PushElement(b_levelSave, LKEdit.FLevelInfo)
	yAccum = yAccum + 32



	local e_nextLevel = LvLKUI.NewElement("e_nextLevel", "textentry")
	e_nextLevel:SetPos({16, yAccum})
	e_nextLevel:SetSize({256 - 32, 16})
	e_nextLevel:SetLabel("NextLevel")
	e_nextLevel:SetText(LKEdit.CurrLevel.nextLevel)
	e_nextLevel:SetMaxLength(512)
	e_nextLevel:SetOnTextChange(function(elm, new)
		if not new then
			return
		end

		LKEdit.CurrLevel.nextLevel = string.lower(new)
	end)
	LvLKUI.PushElement(e_nextLevel, LKEdit.FLevelInfo)
	yAccum = yAccum + 24

	local c_noVisLevel = LvLKUI.NewElement("c_noVisLevel", "checkbox")
	c_noVisLevel:SetPos({16, yAccum})
	c_noVisLevel:SetSize({16, 16})
	c_noVisLevel:SetOnChange(function(elm, new)
		LKEdit.CurrLevel.isNoVis = new
	end)
	LvLKUI.PushElement(c_noVisLevel, LKEdit.FLevelInfo)


	local l_noVis = LvLKUI.NewElement("l_noVis", "label")
	l_noVis:SetPos({16 + 24, yAccum})
	l_noVis:SetSize({128, 16})
	l_noVis:SetLabel("No Vis level (metal glass)")
	LvLKUI.PushElement(l_noVis, LKEdit.FLevelInfo)
	yAccum = yAccum + 24



	LvLKUI.PushElement(LKEdit.FLevelInfo)
end


function LKEdit.PushFrameLevelProps()
	local c_noVisLevel = LKEdit.FLevelInfo:GetChild("c_noVisLevel")
	c_noVisLevel:SetValue(LKEdit.CurrLevel.isNoVis)

	local e_nextLevel = LKEdit.FLevelInfo:GetChild("e_nextLevel")
	e_nextLevel:SetText(LKEdit.CurrLevel.nextLevel)
end