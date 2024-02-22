LvLK3D = LvLK3D or {}
LvLK3D.RTRegistry = LvLK3D.RTRegistry or {}

function LvLK3D.NewRenderTarget(tag, w, h)
    if not tag then
        error("Attempt to make a renderTarget without a tag!")
    end

    if not w or not h then
        error("Dimensions for rendertarget \"" .. tag .. "\" not specified!")
    end



    LvLK3D.RTRegistry[tag] = love.graphics.newCanvas(w, h)
    LvLK3D.RTRegistry[tag]:setFilter(LvLK3D.FilterMode, LvLK3D.FilterMode)
    return LvLK3D.RTRegistry[tag]
end

function LvLK3D.SetRenderTargetFilter(rt, filterNear, filterFar)
    rt:setFilter(filterNear, filterFar)
end

LvLK3D.BaseRT = LvLK3D.NewRenderTarget("LvLK3D_base_rt", 512, 512)

function LvLK3D.GetRenderTargetByName(name)
    return LvLK3D.RTRegistry[name]
end

LvLK3D.CurrRT = LvLK3D.BaseRT
LvLK3D.RTStack = LvLK3D.RTStack or {}


function LvLK3D.PushRenderTarget(rt)
    LvLK3D.RTStack[#LvLK3D.RTStack + 1] = LvLK3D.CurrRT
    LvLK3D.CurrRT = rt


    love.graphics.setCanvas({LvLK3D.CurrRT, depth = true, stencil = true})
end

function LvLK3D.PopRenderTarget()
    LvLK3D.CurrRT = LvLK3D.RTStack[#LvLK3D.RTStack] or LvLK3D.BaseRT
    LvLK3D.RTStack[#LvLK3D.RTStack] = nil

    if #LvLK3D.RTStack <= 0 then
        love.graphics.setCanvas()
    else
        love.graphics.setCanvas({LvLK3D.CurrRT, depth = true, stencil = true})
    end
end

function LvLK3D.Clear(r, g, b, depth)
        love.graphics.clear(r, g, b, 0, depth or true, true)
    --love.graphics.setCanvas()
end


function LvLK3D.ClearDepth()
    --love.graphics.setCanvas({LvLK3D.CurrRT, depth = true, stencil = true})
        love.graphics.clear(false, false, true)
    --love.graphics.setCanvas()
end


function LvLK3D.ClearStencil()
    --love.graphics.setCanvas({LvLK3D.CurrRT, depth = true, stencil = true})
        love.graphics.clear(false, true, false)
    --love.graphics.setCanvas()
end


function LvLK3D.RenderRTFullScreen(rt)
    local currRT = rt or LvLK3D.CurrRT

    local rtW, rtH = currRT:getDimensions()
    local w, h = love.graphics.getDimensions()

    local curr = love.graphics.getCanvas()
    love.graphics.setCanvas(currRT)
        LvLK3D.ApplyPPEffects(currRT)
    love.graphics.setCanvas(curr)


    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(currRT, 0, 0, 0, w / rtW, h / rtH)
    love.graphics.setBlendMode("alpha")
end