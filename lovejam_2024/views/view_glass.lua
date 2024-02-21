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



function view.onEnter()
    LoveJam.ViewTarget = Vector(0, 0, 0)
    LoveJam.AngTarget = Angle(0, 0, 0)
end

function view.onExit()
end