LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

LvLK3D.NewTextureFunc("camera_tex", 256, 256, function()
end)

function LoveJam.UpdateCameraTex(rt)
    LvLK3D.RenderTexture("camera_tex", function()
        local rtW, rtH = rt:getDimensions()
        local w, h = love.graphics.getCanvas():getDimensions()
        love.graphics.clear(0, 0, 0, 1, true, true)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setBlendMode("alpha", "premultiplied")
        love.graphics.draw(rt, 0, 0, 0, w / rtW, h / rtH)
        love.graphics.setBlendMode("alpha")
    end)
end

LvLK3D.SetTextureFilter("camera_tex", "nearest", "nearest")