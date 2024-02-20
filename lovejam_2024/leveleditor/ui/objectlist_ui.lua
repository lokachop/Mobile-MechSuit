LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}


function LKEdit.InitFrameEntList()
	local w, h = love.graphics.getDimensions()

	LKEdit.FEntList = LvLKUI.NewElement("f_entList", "frame")
	LKEdit.FEntList:SetPriority(20)
	LKEdit.FEntList:SetPos({w - 128 - 32, 32})
	LKEdit.FEntList:SetSize({128, 128 + 64})
	LKEdit.FEntList:SetLabel("EntityAdd")
	LKEdit.FEntList:SetCloseDisabled(true)
	LKEdit.FEntList:ReInit()

	local yAdd = 26
	local b_deco = LvLKUI.NewElement("b_deco", "button")
	b_deco:SetPos({16, yAdd})
	b_deco:SetSize({128 - 32, 24})
	b_deco:SetLabel("deco")
	b_deco:SetOnClick(function(elm)
		LKEdit.NewDeco()
	end)
	LvLKUI.PushElement(b_deco, LKEdit.FEntList)
	yAdd = yAdd + 32

	local b_light = LvLKUI.NewElement("b_light", "button")
	b_light:SetPos({16, yAdd})
	b_light:SetSize({128 - 32, 24})
	b_light:SetLabel("light")
	b_light:SetOnClick(function(elm)
		LKEdit.NewLight()
	end)
	LvLKUI.PushElement(b_light, LKEdit.FEntList)
	yAdd = yAdd + 32


	LvLKUI.PushElement(LKEdit.FEntList)

end

