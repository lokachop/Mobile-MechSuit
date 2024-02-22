LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local view = LoveJam.NewView("view_glass")
LoveJam.NewZone(view, {
    x = 0,
    y = .8,
    w = 1,
    h = .2,
    target = "view_general",
})



local yawTarget = 0
function view.onEnter()
    LoveJam.ViewTarget = Vector(0, 0, 0)
    LoveJam.AngTarget = Angle(0, 0, 0)
end

function view.onExit()
    yawTarget = 0
end



local isPanMode = false
function view.onMouseMoved(mx, my, dx, dy)
    if not isPanMode then
        return
    end
    yawTarget = yawTarget - (dx * 0.15)

    if yawTarget > 360 then
        yawTarget = yawTarget - 360
    elseif yawTarget < -180 then
        yawTarget = yawTarget + 360
    end

    LvLK3D.CamAng[2] = yawTarget
    LoveJam.AngTarget[2] = yawTarget

    return true
end



function view.onThink()
    local isDown = love.mouse.isDown(1)
    if not isPanMode and isDown then
        love.mouse.setRelativeMode(true)
        isPanMode = true
    elseif isPanMode and not isDown then
        love.mouse.setRelativeMode(false)
        isPanMode = false

        local w, h = love.graphics.getDimensions()
        love.mouse.setPosition(w * .5, h * .5)
    end
end