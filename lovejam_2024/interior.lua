LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

LvLK3D.AddNewSoundEffect("reverbInterior", {
	["type"] = "reverb",
	["gain"] = 0.5,
	["highgain"] = 3.0,
	["density"] = 0.0,
	["diffusion"] = 0.8,
	["decaytime"] = 0.5,
	["decayhighratio"] = 0.83,
	["earlygain"] = 1,
	["earlydelay"] = 0.1,
	["lategain"] = 0,
	["latedelay"] = 0.011,
	["roomrolloff"] = 0,
	["airabsorption"] = 0.994,
	["highlimit"] = true
})

--[[
LvLK3D.AddNewSoundEffect("reverbInterior", {
	["type"] = "reverb",
	["gain"] = 0.4,
	["highgain"] = 1.4,
	["density"] = 0.3,
	["diffusion"] = 0.4,
	["decaytime"] = 1.2 ,
	["decayhighratio"] = 0.83,
	["earlygain"] = 1.26,
	["earlydelay"] = 0.05,
	["lategain"] = 0.0,
	["latedelay"] = 0.011,
	["roomrolloff"] = 0.01,
	["airabsorption"] = 0.994,
	["highlimit"] = true
})
]]--



local UniverseInterior = LvLK3D.NewUniverse("UniverseInterior")
local UniverseInteriorLights = LvLK3D.NewUniverse("UniverseInteriorLights")
LvLK3D.PushUniverse(UniverseInterior)
	LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
	LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
	LvLK3D.SetAmbientCol({.25, .25, .25})

	LvLK3D.AddLightToUniv("LightInterior", Vector(0, 0.85, 2), 2, {1, 0.95, 0.8})

	--LvLK3D.AddLightToUniv("CompLight1", Vector(-0.3, -1.175, -0.1), 0.05, {0.2, 0.8, 0.1})
	--LvLK3D.AddLightToUniv("CompLight2", Vector(0.3, -1.175, -0.1), 0.05, {0.2, 0.8, 0.1})

	local interiorHull = LvLK3D.AddObjectToUniv("interiorHullExposed", "interior_hull_exposed")
	LvLK3D.SetObjectPos(interiorHull, Vector(0, 0, .2))
	LvLK3D.SetObjectScl(interiorHull, Vector(2, 2, 2))
	LvLK3D.SetObjectMat(interiorHull, "metal4")
	LvLK3D.SetObjectFlag(interiorHull, "SHADING", true)
	LvLK3D.SetObjectFlag(interiorHull, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(interiorHull, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(interiorHull, "FULLBRIGHT", false)
	LvLK3D.SetObjectFlag(interiorHull, "UV_SCALE", {48, 48})
	LvLK3D.UpdateObjectMesh(interiorHull)


	local monitorTerminal = LvLK3D.AddObjectToUniv("monitorTerminal", "monitor")
	LvLK3D.SetObjectPos(monitorTerminal, Vector(-0.75, -0.75, -0.5))
	LvLK3D.SetObjectAng(monitorTerminal, Angle(0, -25, 0))
	LvLK3D.SetObjectScl(monitorTerminal, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(monitorTerminal, "monitor_sheet")
	LvLK3D.SetObjectFlag(monitorTerminal, "SHADING", true)
	LvLK3D.SetObjectFlag(monitorTerminal, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(monitorTerminal, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(monitorTerminal, "FULLBRIGHT", false)
	LvLK3D.UpdateObjectMesh(monitorTerminal)
	LvLK3D.SetObjectShadow(monitorTerminal, true)

	local screenTerminal = LvLK3D.AddObjectToUniv("monitorTerminal", "monitor_screen")
	LvLK3D.SetObjectPos(screenTerminal, Vector(-0.75, -0.75, -0.5))
	LvLK3D.SetObjectAng(screenTerminal, Angle(0, -25, 0))
	LvLK3D.SetObjectScl(screenTerminal, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(screenTerminal, "terminal_tex")
	LvLK3D.SetObjectFlag(screenTerminal, "SHADING", false)
	LvLK3D.SetObjectFlag(screenTerminal, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(screenTerminal, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(screenTerminal, "FULLBRIGHT", true)
	LvLK3D.UpdateObjectMesh(screenTerminal)


	local monitorCam = LvLK3D.AddObjectToUniv("monitorCam", "monitor")
	LvLK3D.SetObjectPos(monitorCam, Vector(0.75, -0.75, -0.5))
	LvLK3D.SetObjectAng(monitorCam, Angle(0, 25, 0))
	LvLK3D.SetObjectScl(monitorCam, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(monitorCam, "monitor_sheet")
	LvLK3D.SetObjectFlag(monitorCam, "SHADING", true)
	LvLK3D.SetObjectFlag(monitorCam, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(monitorCam, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(monitorCam, "FULLBRIGHT", false)
	LvLK3D.UpdateObjectMesh(monitorCam)
	LvLK3D.SetObjectShadow(monitorCam, true)

	local screenCam = LvLK3D.AddObjectToUniv("screenCam", "monitor_screen")
	LvLK3D.SetObjectPos(screenCam, Vector(0.75, -0.75, -0.5))
	LvLK3D.SetObjectAng(screenCam, Angle(0, 25, 0))
	LvLK3D.SetObjectScl(screenCam, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(screenCam, "camera_tex")
	LvLK3D.SetObjectFlag(screenCam, "SHADING", false)
	LvLK3D.SetObjectFlag(screenCam, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(screenCam, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(screenCam, "FULLBRIGHT", true)
	LvLK3D.SetObjectShader(screenCam, "cam")
	LvLK3D.UpdateObjectMesh(screenCam)



	local interiorTable = LvLK3D.AddObjectToUniv("interiorHullTable", "table")
	LvLK3D.SetObjectPos(interiorTable, Vector(0, -.7, -.2))
	LvLK3D.SetObjectScl(interiorTable, Vector(2, 1, 3))
	LvLK3D.SetObjectMat(interiorTable, "metal3")
	LvLK3D.SetObjectFlag(interiorTable, "SHADING", true)
	LvLK3D.SetObjectFlag(interiorTable, "UV_SCALE", {16, 16})
	LvLK3D.UpdateObjectMesh(interiorTable)
	LvLK3D.SetObjectShadow(interiorTable, true)

	local interiorKB1 = LvLK3D.AddObjectToUniv("interiorKB1", "keyboard")
	LvLK3D.SetObjectPos(interiorKB1, Vector(-.5, -1.25, .25))
	LvLK3D.SetObjectAng(interiorKB1, Angle(0, -25, 0))
	LvLK3D.SetObjectScl(interiorKB1, Vector(.75, 1, .75))
	LvLK3D.SetObjectMat(interiorKB1, "keyboard_sheet")
	LvLK3D.SetObjectFlag(interiorKB1, "SHADING", true)
	LvLK3D.UpdateObjectMesh(interiorKB1)
	LvLK3D.SetObjectShadow(interiorKB1, true)


	local interiorKB2 = LvLK3D.AddObjectToUniv("interiorKB2", "keyboard")
	LvLK3D.SetObjectPos(interiorKB2, Vector(.5, -1.25, .25))
	LvLK3D.SetObjectAng(interiorKB2, Angle(0, 25, 0))
	LvLK3D.SetObjectScl(interiorKB2, Vector(.75, 1, .75))
	LvLK3D.SetObjectMat(interiorKB2, "keyboard_sheet")
	LvLK3D.SetObjectFlag(interiorKB2, "SHADING", true)
	LvLK3D.UpdateObjectMesh(interiorKB2)
	LvLK3D.SetObjectShadow(interiorKB2, true)



	local posterVIP = LvLK3D.AddObjectToUniv("posterVIP", "plane")
	LvLK3D.SetObjectPos(posterVIP, Vector(1.75, 0, 1.25))
	LvLK3D.SetObjectAng(posterVIP, Angle(-90, 0, -90))
	LvLK3D.SetObjectScl(posterVIP, Vector(.75, .5, .5))
	LvLK3D.SetObjectMat(posterVIP, "poster_vip")
	LvLK3D.SetObjectFlag(posterVIP, "SHADING", true)
	LvLK3D.SetObjectFlag(posterVIP, "UV_SCALE", {1, -1})
	LvLK3D.UpdateObjectMesh(posterVIP)


	local interiorChair = LvLK3D.AddObjectToUniv("interiorHullChair", "chair")
	LvLK3D.SetObjectPos(interiorChair, Vector(0, -.85, .6))
	LvLK3D.SetObjectScl(interiorChair, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(interiorChair, "metal3")
	LvLK3D.SetObjectFlag(interiorChair, "SHADING", true)
	LvLK3D.SetObjectFlag(interiorChair, "UV_SCALE", {16, 16})
	LvLK3D.UpdateObjectMesh(interiorChair)
	LvLK3D.SetObjectShadow(interiorChair, true)


	local interiorBlockade = LvLK3D.AddObjectToUniv("interiorHullBlockade", "interior_hull_blockade")
	LvLK3D.SetObjectPos(interiorBlockade, Vector(0, 0, .2))
	LvLK3D.SetObjectScl(interiorBlockade, Vector(2, 2, 2))
	LvLK3D.SetObjectMat(interiorBlockade, "metal2")
	LvLK3D.SetObjectFlag(interiorBlockade, "SHADING", true)
	LvLK3D.SetObjectFlag(interiorBlockade, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(interiorBlockade, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(interiorBlockade, "FULLBRIGHT", false)
	LvLK3D.SetObjectFlag(interiorBlockade, "UV_SCALE", {16, 16})
	LvLK3D.UpdateObjectMesh(interiorBlockade)


	--[[
	local boxRadio = LvLK3D.AddObjectToUniv("boxRadio", "cube")
	LvLK3D.SetObjectPos(boxRadio, Vector(0.75, 0.75, -0.6))
	LvLK3D.SetObjectAng(boxRadio, Angle(0, 25, 0))
	LvLK3D.SetObjectScl(boxRadio, Vector(.5, .5, .5))
	LvLK3D.SetObjectMat(boxRadio, "metal2")
	LvLK3D.SetObjectFlag(boxRadio, "SHADING", false)
	LvLK3D.SetObjectFlag(boxRadio, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(boxRadio, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(boxRadio, "FULLBRIGHT", false)
	LvLK3D.UpdateObjectMesh(boxRadio)
	LvLK3D.SetObjectShadow(boxRadio, true)
	]]--

LvLK3D.PopUniverse()

LvLK3D.PushUniverse(UniverseInteriorLights)
	local lights = UniverseInterior.lights

	for k, v in pairs(lights) do

		local sclVal = (1 / v.intensity)
		local planeBillboard = LvLK3D.AddObjectToUniv("lightBillBoard" .. k, "cube")
		LvLK3D.SetObjectPos(planeBillboard, v.pos)
		LvLK3D.SetObjectScl(planeBillboard, Vector(sclVal, sclVal, sclVal))
		LvLK3D.SetObjectCol(planeBillboard, {v.col[1] * .5, v.col[2] * .5, v.col[3] * .5})
		LvLK3D.SetObjectMat(planeBillboard, "flare4")
		LvLK3D.SetObjectShader(planeBillboard, "billboard")
		LvLK3D.SetObjectFlag(planeBillboard, "FULLBRIGHT", true)
		LvLK3D.SetObjectBlend(planeBillboard, "add")
		LvLK3D.UpdateObjectMesh(planeBillboard)
	end
LvLK3D.PopUniverse()