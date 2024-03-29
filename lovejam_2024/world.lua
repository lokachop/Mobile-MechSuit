LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local UniverseWorld = LvLK3D.NewUniverse("UniverseWorld")
local UniverseWorldLights = LvLK3D.NewUniverse("UniverseWorldLights")

function LoveJam.PostLoadPushElements()
	LvLK3D.PushUniverse(UniverseWorld)
		LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
		LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
		LvLK3D.SetAmbientCol({0, 0, 0})

		local robotHull = LvLK3D.AddObjectToUniv("robot_hull", "robot_hull")
		LvLK3D.SetObjectPos(robotHull, Vector(0, 2.85, 0))
		LvLK3D.SetObjectScl(robotHull, Vector(1, 1, 1))
		LvLK3D.SetObjectMat(robotHull, "robot_hull")
		LvLK3D.SetObjectFlag(robotHull, "SHADING", true)
		LvLK3D.UpdateObjectMesh(robotHull)
		LvLK3D.SetObjectShadow(robotHull, true)

		local robotLegL = LvLK3D.AddObjectToUniv("robot_legl", "robot_legl")
		LvLK3D.SetObjectPos(robotLegL, Vector(0, 2.85, 0))
		LvLK3D.SetObjectScl(robotLegL, Vector(1, 1, 1))
		LvLK3D.SetObjectMat(robotLegL, "robot_legl")
		LvLK3D.SetObjectFlag(robotLegL, "SHADING", true)
		LvLK3D.UpdateObjectMesh(robotLegL)
		LvLK3D.SetObjectShadow(robotLegL, true)

		local robotLegR = LvLK3D.AddObjectToUniv("robot_legr", "robot_legr")
		LvLK3D.SetObjectPos(robotLegR, Vector(0, 2.85, 0))
		LvLK3D.SetObjectScl(robotLegR, Vector(1, 1, 1))
		LvLK3D.SetObjectMat(robotLegR, "robot_legr")
		LvLK3D.SetObjectFlag(robotLegR, "SHADING", true)
		LvLK3D.UpdateObjectMesh(robotLegR)
		LvLK3D.SetObjectShadow(robotLegR, true)
	LvLK3D.PopUniverse()

	LvLK3D.PushUniverse(UniverseWorldLights)
		LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
		LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
		LvLK3D.SetAmbientCol({0, 0, 0})
	LvLK3D.PopUniverse()
end



LvLK3D.PushUniverse(UniverseWorld)
	LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
	LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
	LvLK3D.SetAmbientCol({.25, .25, .25})

	LvLK3D.AddLightToUniv("LightTemp", Vector(0, 6, -2), 4, {1, 1, 1})

	local robotHull = LvLK3D.AddObjectToUniv("robot_hull", "robot_hull")
	LvLK3D.SetObjectPos(robotHull, Vector(0, 2.85, 0))
	LvLK3D.SetObjectScl(robotHull, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(robotHull, "robot_hull")
	LvLK3D.SetObjectFlag(robotHull, "SHADING", true)
	LvLK3D.UpdateObjectMesh(robotHull)
	LvLK3D.SetObjectShadow(robotHull, true)

	local robotLegL = LvLK3D.AddObjectToUniv("robot_legl", "robot_legl")
	LvLK3D.SetObjectPos(robotLegL, Vector(0, 2.85, 0))
	LvLK3D.SetObjectScl(robotLegL, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(robotLegL, "robot_legl")
	LvLK3D.SetObjectFlag(robotLegL, "SHADING", true)
	LvLK3D.UpdateObjectMesh(robotLegL)
	LvLK3D.SetObjectShadow(robotLegL, true)

	local robotLegR = LvLK3D.AddObjectToUniv("robot_legr", "robot_legr")
	LvLK3D.SetObjectPos(robotLegR, Vector(0, 2.85, 0))
	LvLK3D.SetObjectScl(robotLegR, Vector(1, 1, 1))
	LvLK3D.SetObjectMat(robotLegR, "robot_legr")
	LvLK3D.SetObjectFlag(robotLegR, "SHADING", true)
	LvLK3D.UpdateObjectMesh(robotLegR)
	LvLK3D.SetObjectShadow(robotLegR, true)
LvLK3D.PopUniverse()
