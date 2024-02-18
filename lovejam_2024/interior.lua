LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local UniverseInterior = LvLK3D.NewUniverse("UniverseInterior")
LvLK3D.PushUniverse(UniverseInterior)
    LvLK3D.SetSunLighting(false) -- do sun lighting for testing meanwhile
    LvLK3D.SetSunDir(Vector(-0.61, -0.51, 0.59):GetNormalized())
    LvLK3D.SetAmbientCol({.25, .25, .25})

    LvLK3D.AddLightToUniv("LightInterior", Vector(0, 0.85, 2), 4, {1, 0.95, 0.8})


    local interiorHull = LvLK3D.AddObjectToUniv("interiorHull", "interior_hull")
    LvLK3D.SetObjectPos(interiorHull, Vector(0, 0, 0))
    LvLK3D.SetObjectScl(interiorHull, Vector(2, 2, 2))
    LvLK3D.SetObjectMat(interiorHull, "metal4")
    LvLK3D.SetObjectFlag(interiorHull, "SHADING", true)
    LvLK3D.SetObjectFlag(interiorHull, "SHADING_SMOOTH", false)
    LvLK3D.SetObjectFlag(interiorHull, "NORM_INVERT", false)
    LvLK3D.SetObjectFlag(interiorHull, "FULLBRIGHT", false)
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
    LvLK3D.UpdateObjectMesh(screenCam)
LvLK3D.PopUniverse()