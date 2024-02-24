LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LoveJam.MechPos = {0, 0}
LoveJam.MechAng = 0

local mechPosVis = Vector(0, 0, 0)
local mechAngVis = Angle(0, 0, 0)

local UniverseWorld = LvLK3D.GetUniverseByTag("UniverseWorld")

local matForward = Matrix()
function LoveJam.GetMechCamAng()
    return mechAngVis
end

function LoveJam.GetMechForward()
    local mechAng = LoveJam.GetMechCamAng()
    matForward:SetAngles(mechAng)
    local fw = matForward:Forward()
    fw[1] = -fw[1]
    return fw
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

local function getMechInterpolatedPos()
    return mechPosVis
end

function LoveJam.GetMechCamPos()
    return getMechInterpolatedPos() + Vector(0, 3.5, 0) + (LoveJam.GetMechForward() * 1.3)
end


function LoveJam.GetMechViewPos()
    return getMechInterpolatedPos() + Vector(0, 3.05, 0)
end

function LoveJam.GetMechModelPos()
    return getMechInterpolatedPos() + Vector(0, 2.85, 0)
end

function LoveJam.GetMechModelAng()
    return mechAngVis
end

local isMoving = false
local moveType = "none"
function LoveJam.IsMechMoving()
    return isMoving
end

function LoveJam.GetMechMovementType()
    return moveType
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

        local visPos = LoveJam.GetMechModelPos()
        LvLK3D.SetObjectPos(rHull, visPos)
        LvLK3D.SetObjectPos(rLegL, visPos)
        LvLK3D.SetObjectPos(rLegR, visPos)

        local visAng = LoveJam.GetMechModelAng()
        LvLK3D.SetObjectAng(rHull, visAng)
        LvLK3D.SetObjectAng(rLegL, visAng)
        LvLK3D.SetObjectAng(rLegR, visAng)
    LvLK3D.PopUniverse()
end



local function lerp(t, a, b)
    return a * (1 - math.min(t, 1)) + b * t
end

local function lerpVector(t, a, b)
    return Vector(lerp(t, a[1], b[1]), lerp(t, a[2], b[2]), lerp(t, a[3], b[3]))
end


local function onMoveDone()
    local x = LoveJam.MechPos[1]
    local y = LoveJam.MechPos[2]
    local tile = LoveJam.GetTileAtPos(x, y)
    local tParams = LoveJam.GetTileParams(tile)

    if tParams.onStep then
        tParams.onStep()
    end
end



local lerpIsFall = false

local lerpDeltaPos = 0
local lerpStartPos = Vector(0, 0, 0)
local lerpTargetPos = Vector(0, 0, 0)
local function posLerpThink(dt)
    if lerpDeltaPos >= 1 then
        if moveType == "pos" and isMoving then
            isMoving = false
            onMoveDone()
        end

        return
    end

    lerpDeltaPos = lerpDeltaPos + ((dt * .25) * MECH_MOVE_MUL)
    mechPosVis = lerpVector(lerpDeltaPos, lerpStartPos, lerpTargetPos)

    if lerpIsFall then
        mechPosVis[2] = mechPosVis[2] - (((lerpDeltaPos + 1) * (lerpDeltaPos + 1)) - 1)
    else
        mechPosVis[2] = mechPosVis[2] + math.abs(math.sin((lerpDeltaPos * 4) * math.pi) * .5)
    end


    LoveJam.UpdateVisOnMechMove()
end

local lerpDeltaAng = 0
local lerpStartAng = 0
local lerpTargetAng = 0
local function angLerpThink(dt)
    if lerpDeltaAng >= 1 then
        if moveType == "ang" then
            isMoving = false
        end

        return
    end


    lerpDeltaAng = lerpDeltaAng + ((dt * .225) * MECH_ROTATE_MUL)
    mechAngVis = Angle(0, lerp(lerpDeltaAng, lerpStartAng, lerpTargetAng), 0)

    --if lerpIsFall then
    --    mechAngVis[1] = (((lerpDeltaAng + 1) * (lerpDeltaAng + 1)) - 1) * 15
    --end


    LoveJam.UpdateVisOnMechMove()

end


function LoveJam.MechMovementInterpThink(dt)
    posLerpThink(dt)
    angLerpThink(dt)
end


function LoveJam.GetMechLerpTimers()
    return lerpDeltaPos, lerpDeltaAng
end


function LoveJam.SetMechPos(x, y)
    lerpStartPos = Vector(x * GRID_SZ, 0, y * GRID_SZ)
    lerpTargetPos = Vector(x * GRID_SZ, 0, y * GRID_SZ)
    mechPosVis = Vector(x * GRID_SZ, 0, y * GRID_SZ)
    lerpDeltaPos = 1
    lerpIsFall = false

    LoveJam.MechPos = {x, y}
    LoveJam.UpdateVisOnMechMove()
end


function LoveJam.SetMechPosLerped(x, y)
    lerpStartPos = Vector(LoveJam.MechPos[1] * GRID_SZ, 0, LoveJam.MechPos[2] * GRID_SZ)
    lerpTargetPos = Vector(x * GRID_SZ, 0, y * GRID_SZ)
    lerpDeltaPos = 0
    isMoving = true
    moveType = "pos"
    lerpIsFall = false


    LoveJam.MechPos = {x, y}
    LoveJam.UpdateVisOnMechMove()
end

function LoveJam.SetMechAng(ang)
    lerpStartAng = ang
    lerpTargetAng = ang
    mechAngVis = Angle(0, ang, 0)
    lerpDeltaAng = 1
    lerpIsFall = false

    LoveJam.MechAng = ang
    LoveJam.UpdateVisOnMechMove()
end

function LoveJam.SetMechAngLerped(ang)
    lerpStartAng = LoveJam.MechAng
    lerpTargetAng = ang

    if lerpStartAng == 270 and lerpTargetAng == 0 then
        lerpTargetAng = 360
    elseif lerpStartAng == 0 and lerpTargetAng == 270 then
        lerpTargetAng = -90
    end
    lerpIsFall = false


    lerpDeltaAng = 0
    isMoving = true
    moveType = "ang"

    LoveJam.MechAng = ang
    LoveJam.UpdateVisOnMechMove()
end

function LoveJam.MoveMechForward()
    local forward = LoveJam.GetForwardTileDir()

    local newX = LoveJam.MechPos[1] + forward[1]
    local newY = LoveJam.MechPos[2] + forward[2]
    local tile = LoveJam.GetTileAtPos(newX, newY)

    if not tile then
        LoveJam.SetMechPosLerped(newX, newY) -- TODO make fancy
        return true
    end

    local tParams = LoveJam.GetTileParams(tile)
    if not tParams then
        return false
    end

    if tParams.solid then
        return false
    end


    if tParams.harmful then
        LoveJam.SetMechPosLerped(newX, newY)
        lerpIsFall = true
        return true
    end


    LoveJam.SetMechPosLerped(newX, newY)

    return true
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

local movesLeft = 0
function LoveJam.MultiMoveForward(count)
    movesLeft = math.floor(math.min(math.max(count, 0), 16))
end

function LoveJam.MultiMoveThink()
    if movesLeft <= 0 then
        return
    end


    if LoveJam.IsMechMoving() then
        return
    end
    movesLeft = movesLeft - 1

    local ok = LoveJam.MoveMechForward()
    if not ok then
        movesLeft = 0
        LoveJam.EditCurrentMessageOnTerminal("Obstacle detected, halting..")
    else
        LoveJam.EditCurrentMessageOnTerminal("Moving [OK]")
    end
    LoveJam.PushMessageToTerminal("")
end


function LoveJam.RotateMechLeft()
    local nextAng = rotLUT[LoveJam.MechAng][1]
    LoveJam.SetMechAngLerped(nextAng)
end


function LoveJam.RotateMechRight()
    local nextAng = rotLUT[LoveJam.MechAng][2]
    LoveJam.SetMechAngLerped(nextAng)
end