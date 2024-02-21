LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LoveJam.MechPos = {0, 0}
LoveJam.MechAng = 0

local mechPosVis = Vector(0, 0, 0)
local mechAngVis = Angle(0, 0, 0)

local UniverseWorld = LvLK3D.GetUniverseByTag("UniverseWorld")

local matForward = Matrix()
function LoveJam.GetMechForward()
    local mechAng = Angle(0, LoveJam.MechAng, 0)
    matForward:SetAngles(mechAng)

    return matForward:Forward()
end

local forwardLUT = {
    [0] = {0, -1},
    [90] = {1, 0},
    [180] = {0, 1},
    [270] = {-1, 0}
}
function LoveJam.GetForwardTileDir()
    return forwardLUT[LoveJam.MechAng]
end

function LoveJam.GetMechCamPos()
    return Vector(LoveJam.MechPos[1] * GRID_SZ, 3.4, LoveJam.MechPos[2] * GRID_SZ) + (LoveJam.GetMechForward() * 1.2)
end
function LoveJam.GetMechCamAng()
    return Angle(0, LoveJam.MechAng, 0)
end

function LoveJam.GetMechViewPos()
    return Vector(LoveJam.MechPos[1] * GRID_SZ, 3.05, LoveJam.MechPos[2] * GRID_SZ)
end



function LoveJam.UpdateVisOnMechMove()
    LvLK3D.PushUniverse(UniverseWorld)
        local rHull = LvLK3D.GetObjectByName("robot_hull")
        local rLegL = LvLK3D.GetObjectByName("robot_legl")
        local rLegR = LvLK3D.GetObjectByName("robot_legr")

        if not rHull then
            return
        end

        if not rLegL then
            return
        end

        if not rLegR then
            return
        end

        local mechVisPos = Vector(LoveJam.MechPos[1] * GRID_SZ, 2.85, LoveJam.MechPos[2] * GRID_SZ)
        LvLK3D.SetObjectPos(rHull, mechVisPos)
        LvLK3D.SetObjectPos(rLegL, mechVisPos)
        LvLK3D.SetObjectPos(rLegR, mechVisPos)

        local mechAng = Angle(0, LoveJam.MechAng, 0)
        LvLK3D.SetObjectAng(rHull, mechAng)
        LvLK3D.SetObjectAng(rLegL, mechAng)
        LvLK3D.SetObjectAng(rLegR, mechAng)
    LvLK3D.PopUniverse()
end

function LoveJam.MechMovementThink()


end




function LoveJam.SetMechPos(x, y)
    LoveJam.MechPos = {x, y}
    LoveJam.UpdateVisOnMechMove()
end

function LoveJam.SetMechAng(ang)
    LoveJam.MechAng = ang
    LoveJam.UpdateVisOnMechMove()
end



function LoveJam.MoveMechForward()
    local forward = LoveJam.GetForwardTileDir()

    local newX = LoveJam.MechPos[1] + forward[1]
    local newY = LoveJam.MechPos[2] + forward[2]
    local tile = LoveJam.GetTileAtPos(newX, newY)

    if not tile then
        LoveJam.SetMechPos(newX, newY) -- TODO make fancy
        return
    end

    local tParams = LoveJam.GetTileParams(tile)
    if not tParams then
        return
    end

    if tParams.solid then
        return
    end

    if tParams.onStep then
        local stop = tParams.onStep()
        if stop then
            return
        end
    end

    LoveJam.SetMechPos(newX, newY)
end

local rotLUT = {
    [0] = {
        270,
        90,
    },
    [90] = {
        0,
        180,
    },
    [180] = {
        90,
        270,
    },
    [270] = {
        180,
        0,
    }
}


function LoveJam.RotateMechLeft()
    local nextAng = rotLUT[LoveJam.MechAng][1]
    LoveJam.SetMechAng(nextAng)
end


function LoveJam.RotateMechRight()
    local nextAng = rotLUT[LoveJam.MechAng][2]
    LoveJam.SetMechAng(nextAng)
end