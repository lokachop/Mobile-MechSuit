LvLK3D = LvLK3D or {}
LvLK3D.PPEffects = LvLK3D.PPEffects or {}
LvLK3D.PushedPPEffects = {}

function LvLK3D.DeclareNewPPEffect(name, data)
    local ppData = {
        ["parameteri"] = data.parameteri or {},
        ["buffers"] = {},
        ["onRender"] = data.onRender,
    }

    local w, h = love.graphics.getDimensions()

    local buffers = data.buffers
    for k, v in pairs(buffers) do
        local sw, sh = v[1], v[2]
        sw = sw == -1 and w or sw
        sh = sh == -1 and h or sw


        print("\"" .. k .. "\"", sw, sh)
        ppData["buffers"][k] = love.graphics.newCanvas(sw, sh)

        local currCanvas = love.graphics.getCanvas()
        love.graphics.setCanvas(ppData["buffers"][k])
            love.graphics.clear(0, 0, 0, 1, true, true)
        love.graphics.setCanvas(currCanvas)

    end

    LvLK3D.PPEffects[name] = ppData
end

function LvLK3D.ApplyPPEffects()
    for k, v in ipairs(LvLK3D.PushedPPEffects) do
        local eff = LvLK3D.PPEffects[v[1]]

        local parameteri = eff.parameteri

        for k2, v2 in pairs(v[2]) do
            parameteri[k2] = v2
        end


        eff.onRender(eff["buffers"], parameteri)
    end

    LvLK3D.PushedPPEffects = {}
end

function LvLK3D.PushPPEffect(name, params)
    if not LvLK3D.PPEffects[name] then
        print("Attempt to push non existent PP effect \"" .. name .. "\"!")
        return
    end

    LvLK3D.PushedPPEffects[#LvLK3D.PushedPPEffects + 1] = {name, params}
end


-- SCP: CB-like blur, god awful though
LvLK3D.DeclareNewPPEffect("cbBlur", {
    ["parameteri"] = {
        ["blendFactor"] = 0.95,
    },
    ["buffers"] = {
        ["temp"] = {-1, -1},
        ["temp2"] = {-1, -1},
    },
    ["onRender"] = function(buffers, parameteri)
        local w, h = love.graphics.getDimensions()
        local buff1 = buffers["temp"]
        local bw, bh = buff1:getDimensions()


        local buff2 = buffers["temp2"]

        local curr = love.graphics.getCanvas()
        local cw, ch = curr:getDimensions()

        local _off = 1
        local blendfactor = parameteri["blendFactor"]
        local _blendinverse = 1 - blendfactor


        love.graphics.setCanvas(buff2)
            love.graphics.clear(0, 0, 0, 1, true, true)
            love.graphics.setBlendMode("alpha", "premultiplied")
            love.graphics.setColor(1, 1, 1, blendfactor)
            love.graphics.draw(buff1, _off, _off, 0, w / cw, h / ch)

        love.graphics.setCanvas(buff1)
            love.graphics.clear(0, 0, 0, 1, true, true)
            love.graphics.setBlendMode("alpha", "premultiplied")
            love.graphics.setColor(blendfactor, blendfactor, blendfactor, 1)
            love.graphics.draw(buff2, 0, 0, 0, w / cw, h / ch)

            love.graphics.setBlendMode("alpha", "premultiplied")
            love.graphics.setColor(_blendinverse, _blendinverse, _blendinverse, _blendinverse)
            love.graphics.draw(curr, _off, _off, 0, w / cw, h / ch)

        love.graphics.setCanvas(curr)


        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setBlendMode("alpha", "premultiplied")
            love.graphics.draw(buff1, 0, 0, 0, w / bw, h / bh)
        love.graphics.setBlendMode("alpha")

    end
})


LvLK3D.DeclareNewPPEffect("frameAccum", {
    ["parameteri"] = {
        ["blendFactor"] = 0.95,
    },
    ["buffers"] = {
        ["accum"] = {-1, -1},
    },
    ["onRender"] = function(buffers, parameteri)
        local w, h = love.graphics.getDimensions()
        local buff1 = buffers["accum"]
        local bw, bh = buff1:getDimensions()

        local curr = love.graphics.getCanvas()
        local cw, ch = curr:getDimensions()

        local blendfactor = parameteri["blendFactor"]
        local _blendinverse = 1 - blendfactor

        love.graphics.setCanvas(buff1)
            love.graphics.setBlendMode("alpha")
            love.graphics.setColor(1, 1, 1, _blendinverse)
            love.graphics.draw(curr, 0, 0, 0, w / cw, h / ch)
        love.graphics.setCanvas(curr)


        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setBlendMode("alpha", "premultiplied")
            love.graphics.draw(buff1, 0, 0, 0, w / bw, h / bh)
        love.graphics.setBlendMode("alpha")

    end
})