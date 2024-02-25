LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}



local lastTrack = "sounds/music/radio1_shit.wav"

LoveJam.RadioSource = love.audio.newSource("sounds/music/radio1_shit.wav", "stream")  --LvLK3D.PlaySound3D("sounds/music/radio1_shit_mono.wav", Vector(0.75, 0.75, 0.6), 1, 1)
--LoveJam.RadioSource:setRelative(true)


--LvLK3D.SetSourceEffect(LoveJam.RadioSource, "reverbInterior", true)
--LvLK3D.SetSourceFilter(LoveJam.RadioSource, {
--    ["volume"] = 0.0,
--    ["type"] = "lowpass"
--})
LoveJam.RadioSource:setLooping(true)

function LoveJam.StopRadio()
    LoveJam.RadioSource:stop()
end


function LoveJam.StartRadio()
    local track = LoveJam.GetCurrentLevelRadioTrack()
    if track ~= lastTrack then
        LoveJam.RadioSource = nil
        LoveJam.RadioSource = love.audio.newSource(track, "stream")
        LoveJam.RadioSource:setLooping(true)

        lastTrack = track
    end

    LoveJam.RadioSource:play()
end