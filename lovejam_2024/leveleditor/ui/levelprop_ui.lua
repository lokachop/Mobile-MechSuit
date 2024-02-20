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


	local e_levelName = LvLKUI.NewElement("e_levelName", "textentry")
	e_levelName:SetPos({16, 26})
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

	local b_levelLoad = LvLKUI.NewElement("b_levelLoad", "button")
	b_levelLoad:SetPos({16, 26 + 24})
	b_levelLoad:SetSize({128 - 32, 24})
	b_levelLoad:SetLabel("load")
	b_levelLoad:SetOnClick(function(elm)
		LKEdit.LoadLevel(string.lower(LKEdit.CurrLevel.name))
	end)
	LvLKUI.PushElement(b_levelLoad, LKEdit.FLevelInfo)


	local b_levelSave = LvLKUI.NewElement("b_levelSave", "button")
	b_levelSave:SetPos({16 + (128 - 32) + 32, 26 + 24})
	b_levelSave:SetSize({128 - 32, 24})
	b_levelSave:SetLabel("save")
	b_levelSave:SetOnClick(function(elm)
		LKEdit.SaveLevel(string.lower(LKEdit.CurrLevel.name))
	end)
	LvLKUI.PushElement(b_levelSave, LKEdit.FLevelInfo)


	local c_darkLevel = LvLKUI.NewElement("c_darkLevel", "checkbox")
	c_darkLevel:SetPos({16, 26 + 24 + 32})
	c_darkLevel:SetSize({16, 16})
	c_darkLevel:SetOnChange(function(elm, new)
		--
	end)
	LvLKUI.PushElement(c_darkLevel, LKEdit.FLevelInfo)



	LvLKUI.PushElement(LKEdit.FLevelInfo)
end
