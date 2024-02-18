LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

LoveJam.RadioSource = LvLK3D.PlaySound3D("sounds/music/radio1_shit_mono.wav", Vector(0.75, 0.75, 0.6), 1, 1)
LvLK3D.SetSourceEffect(LoveJam.RadioSource, "reverbInterior", true)
LvLK3D.SetSourceFilter(LoveJam.RadioSource, {
    ["volume"] = 0.0,
    ["type"] = "lowpass"
})
LoveJam.RadioSource:setLooping(true)

function LoveJam.StopRadio()
    LoveJam.RadioSource:stop()
end


function LoveJam.StartRadio()
    LoveJam.RadioSource:play()
end