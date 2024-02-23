LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}


local view = LoveJam.NewView("view_terminal")
LoveJam.NewZone(view, {
    x = .8,
    y = 0,
    w = .2,
    h = 1,
    target = "view_general",
})



function view.onEnter()
    LoveJam.ViewTarget = Vector(-.375, -.725, .3)
    LoveJam.AngTarget = Angle(0, 25, 0)
    LoveJam.TutoSendTrigger("tutoView")
end

function view.onExit()
end

function view.onKeyPressed(key)
    LoveJam.TerminalOnKey(key)
end