LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local prevMove = false
local moveSoundSource = LvLK3D.PlaySound3D("sounds/mech/move.wav", Vector(0, -2, 0), 1, 8)
moveSoundSource:setLooping(true)


local rotateSoundSource = LvLK3D.PlaySound3D("sounds/mech/rotates.wav", Vector(0, -2, 0), 1, 8)

local function setMoveSound(state)
    if state == true then
        moveSoundSource:play()
    else
        moveSoundSource:stop()
    end
end

local function setRotSound(state)
    if state == true then
        rotateSoundSource:play()
    end
end

local function sign(x)
    return x < 0 and -1 or 1
end

local lastSign = 1
local function playSteps(dt)
    local timerMove = LoveJam.GetMechLerpTimers()
    local tyCalc = math.sin((timerMove * 4) * math.pi)

    local signCalc = sign(tyCalc)
    if signCalc == lastSign then
        return
    end
    lastSign = signCalc
    local src = LvLK3D.PlaySound3D("sounds/mech/step" .. math.random(1, 4) .. ".wav", Vector(0, -2.2, 0), 1, 16)
    src:play()

end


function LoveJam.SoundInteriorThink(dt)
    local moveState = LoveJam.IsMechMoving()
    local moveType = LoveJam.GetMechMovementType()
    if moveState and moveType == "pos" then
        playSteps(dt)
    end

    if moveState == prevMove then
        return
    end
    prevMove = moveState

    if moveType == "pos" then
        setMoveSound(moveState)
    else
        setRotSound(moveState)
    end

    
end