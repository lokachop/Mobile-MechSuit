LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local view = LoveJam.NewView("view_general")
LoveJam.NewZone(view, {
    x = 0,
    y = 0,
    w = .1,
    h = 1,
    target = "view_terminal"
})

LoveJam.NewZone(view, {
    x = .9,
    y = 0,
    w = .1,
    h = 1,
    target = "view_camera"
})

LoveJam.NewZone(view, {
    x = .1,
    y = 0,
    w = .8,
    h = .1,
    target = "view_glass"
})


function view.onEnter()
    LoveJam.ViewTarget = Vector(0, -.725, 1.1)
    LoveJam.AngTarget = Angle(0, 0, 0)
end

function view.onExit()
end