LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}


LKEdit.CurrLevel = LKEdit.NewLevel("none")
LKEdit.GridEdit = false


local UniverseEditPlaneRef = LvLK3D.NewUniverse("UniverseEditPlaneRef")
local UniverseEdit = LvLK3D.NewUniverse("UniverseEdit")
local UniverseEditLights = LvLK3D.NewUniverse("UniverseEditLights")

LvLK3D.PushUniverse(UniverseEdit)
	LvLK3D.SetSunLighting(false)
	LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
	LvLK3D.SetAmbientCol({.0, .0, .0})
LvLK3D.PopUniverse()

LvLK3D.PushUniverse(UniverseEditPlaneRef)
	local pFloorRef = LvLK3D.AddObjectToUniv("planeCursor", "plane")
	LvLK3D.SetObjectPos(pFloorRef, Vector(0, 0, 0))
	LvLK3D.SetObjectCol(pFloorRef, {0, 1, 0.25})
	LvLK3D.SetObjectScl(pFloorRef, Vector(GRID_SZ * .5, 1, GRID_SZ * .5))
	LvLK3D.SetObjectMat(pFloorRef, "white")
	LvLK3D.SetObjectFlag(pFloorRef, "FULLBRIGHT", true)
	LvLK3D.SetObjectBlend(pFloorRef, "add")
	LvLK3D.UpdateObjectMesh(pFloorRef)
LvLK3D.PopUniverse()