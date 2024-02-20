LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}


LKEdit.CurrLevel = LKEdit.NewLevel("none")


local UniverseEditPlaneRef = LvLK3D.NewUniverse("UniverseEditPlaneRef")
local UniverseEdit = LvLK3D.NewUniverse("UniverseEdit")
local UniverseEditLights = LvLK3D.NewUniverse("UniverseEditLights")


LvLK3D.PushUniverse(UniverseEdit)
	LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
	LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
	LvLK3D.SetAmbientCol({.0, .0, .0})

	local pFloorRef = LvLK3D.AddObjectToUniv("planeFloor", "plane")
	LvLK3D.SetObjectPos(pFloorRef, Vector(0, 0, 0))
	LvLK3D.SetObjectAng(pFloorRef, Angle(0, 0, 0))
	LvLK3D.SetObjectScl(pFloorRef, Vector(32, 32, 32))
	LvLK3D.SetObjectMat(pFloorRef, "none")
	LvLK3D.SetObjectFlag(pFloorRef, "SHADING", false)
	LvLK3D.SetObjectFlag(pFloorRef, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(pFloorRef, "NORM_INVERT", false)
	--LvLK3D.SetObjectFlag(pFloorRef, "FULLBRIGHT", true)
	LvLK3D.UpdateObjectMesh(pFloorRef)

LvLK3D.PopUniverse()


--[[
LvLK3D.PushUniverse(UniverseEditPlaneRef)
	LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
	LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
	LvLK3D.SetAmbientCol({.0, .0, .0})

	local pFloorRef = LvLK3D.AddObjectToUniv("planeFloor", "plane")
	LvLK3D.SetObjectPos(pFloorRef, Vector(0, 0, 0))
	LvLK3D.SetObjectAng(pFloorRef, Angle(0, 0, 0))
	LvLK3D.SetObjectScl(pFloorRef, Vector(32, 32, 32))
	LvLK3D.SetObjectMat(pFloorRef, "none")
	LvLK3D.SetObjectFlag(pFloorRef, "SHADING", false)
	LvLK3D.SetObjectFlag(pFloorRef, "SHADING_SMOOTH", false)
	LvLK3D.SetObjectFlag(pFloorRef, "NORM_INVERT", false)
	LvLK3D.SetObjectFlag(pFloorRef, "FULLBRIGHT", true)
	LvLK3D.SetObjectBlend(pFloorRef, "add")
	LvLK3D.UpdateObjectMesh(pFloorRef)
LvLK3D.PopUniverse()
]]--