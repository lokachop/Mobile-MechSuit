LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local view = LoveJam.NewView("view_camera")
LoveJam.NewZone(view, {
    x = 0,
    y = 0,
    w = .2,
    h = 1,
    target = "view_general"
})



function view.onEnter()
    LoveJam.IsOnCamera = true
    LoveJam.ViewTarget = Vector(.375, -.725, .3)
    LoveJam.AngTarget = Angle(0, -25, 0)
    LoveJam.TutoSendTrigger("tutoCam1")
end

function view.onExit()
    LoveJam.IsOnCamera = false
end

local isPanMode = false
function view.onMouseMoved(mx, my, dx, dy)
    if not isPanMode then
        return
    end
    local w, h = love.graphics.getDimensions()

    LoveJam.CameraAng[1] = LoveJam.CameraAng[1] - (dy * 0.15)
    LoveJam.CameraAng[2] = LoveJam.CameraAng[2] - (dx * 0.15)

    LoveJam.CameraAng[1] = math.min(math.max(LoveJam.CameraAng[1], -90), 90)
    --love.mouse.setPosition(w, h)


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


    --if love.mouse.isDown(1) then
    --    love.mouse.setPosition()
    --end
end