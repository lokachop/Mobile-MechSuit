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
    LoveJam.ViewTarget = Vector(.375, -.725, .3)
    LoveJam.AngTarget = Angle(0, -25, 0)
end

function view.onExit()
end