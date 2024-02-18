LvLK3D = LvLK3D or {}
--[[
    procedural texture module
    really shit
]]

local _baseVsh = LvLK3D.RelaPath .. "/shader/proctex/baseimg.vert"

local procTex_shaderRegistry = {}
local function procTex_newShader(name, fsh)
    if not name then
        return
    end

    if not fsh then
        return
    end

    local shader = love.graphics.newShader(fsh, _baseVsh)
    procTex_shaderRegistry[name] = shader

    print("ProcTex: New shader \"" .. name .. "\"")
end


local _lastCanvasStack = {}
local _lastShaderStack = {}
local function pushCanvas(canvas)
    _lastCanvasStack[#_lastCanvasStack + 1] = love.graphics.getCanvas()
    _lastShaderStack[#_lastShaderStack + 1] = love.graphics.getShader()
    love.graphics.setCanvas(canvas)
    love.graphics.setShader()
end

local function popCanvas()
    local oldCanvas = _lastCanvasStack[#_lastCanvasStack]
    local oldShader = _lastShaderStack[#_lastShaderStack]

    love.graphics.setCanvas(oldCanvas)
    love.graphics.setShader(oldShader)

    _lastCanvasStack[#_lastCanvasStack] = nil
    _lastShaderStack[#_lastShaderStack] = nil
end

local function applyShader(name, data)
    if not procTex_shaderRegistry[name] then
        print("ProcTex: /!\\ no shader \"" .. name .. "\"!")
        return
    end


    local prevShader = love.graphics.getShader()
    local shader = procTex_shaderRegistry[name]
    love.graphics.setShader(shader)

    if not data then
        print("ProcTex: /!\\ no data given when applying shader \"" .. name .. "\"!")
    end

    -- apply parameteri
    for k, v in pairs(data) do
        if shader:hasUniform(k) then
            shader:send(k, v)
        else
            print("ProcTex: /!\\ Attempt to send non-existant uniform \"" .. k .. "\" to shader \"" .. name .. "\"!")
        end
    end


    local canvasCurr = love.graphics.getCanvas()
    local w, h = canvasCurr:getDimensions()
    if shader:hasUniform("screenRes") then
        shader:send("screenRes", {w, h})
    end


    -- render current to buffer then back with shader
    local canvasIntermediary = love.graphics.newCanvas(w, h)

    love.graphics.setCanvas(canvasIntermediary)
    love.graphics.setBlendMode("alpha", "premultiplied")
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(canvasCurr, 0, 0)

    love.graphics.setShader(prevShader)
    love.graphics.setCanvas(canvasCurr)
        love.graphics.draw(canvasIntermediary, 0, 0)

    love.graphics.setBlendMode("alpha")
end

procTex_newShader("worleyMultiply", LvLK3D.RelaPath .. "/shader/proctex/worley.frag")
procTex_newShader("worleyNormal", LvLK3D.RelaPath .. "/shader/proctex/worleynormal.frag")

procTex_newShader("invert", LvLK3D.RelaPath .. "/shader/proctex/invert.frag")
procTex_newShader("clamp", LvLK3D.RelaPath .. "/shader/proctex/clamp.frag")
procTex_newShader("treshold", LvLK3D.RelaPath .. "/shader/proctex/treshold.frag")
procTex_newShader("normalify", LvLK3D.RelaPath .. "/shader/proctex/normalify.frag")

procTex_newShader("simplexMultiply", LvLK3D.RelaPath .. "/shader/proctex/simplexmul.frag")
procTex_newShader("simplexAdd", LvLK3D.RelaPath .. "/shader/proctex/simplexadd.frag")

procTex_newShader("colourMul", LvLK3D.RelaPath .. "/shader/proctex/colourmul.frag")
procTex_newShader("colourAdd", LvLK3D.RelaPath .. "/shader/proctex/colouradd.frag")

procTex_newShader("mergeAdd", LvLK3D.RelaPath .. "/shader/proctex/mergeadd.frag")
procTex_newShader("multiply", LvLK3D.RelaPath .. "/shader/proctex/multiply.frag")

procTex_newShader("distort", LvLK3D.RelaPath .. "/shader/proctex/distort.frag")

procTex_newShader("gaussianblur", LvLK3D.RelaPath .. "/shader/proctex/gaussianblur.frag")

procTex_newShader("lightdot", LvLK3D.RelaPath .. "/shader/proctex/lightdot.frag")

-- creates a temp texture
function LvLK3D.ProcTexNewTemp(w, h, r, g, b)
    local canvasTemp = love.graphics.newCanvas(w, h)

    if r then
        pushCanvas(canvasTemp)
            love.graphics.setColor(r or 1, g or 1, b or 1)
            love.graphics.rectangle("fill", 0, 0, w, h)
        popCanvas()
    end

    return canvasTemp
end

function LvLK3D.ProcTexCopyTex(canvas)
    local w, h = canvas:getDimensions()
    local canvasTemp = love.graphics.newCanvas(w, h)

    pushCanvas(canvasTemp)
        love.graphics.setBlendMode("alpha", "premultiplied")
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(canvas, 0, 0)
    popCanvas()

    return canvasTemp
end

function LvLK3D.ProcTexApplyColour(canvas, r, g, b)
    pushCanvas(canvas)
        love.graphics.setColor(r or 1, g or 1, b or 1)
        love.graphics.rectangle("fill", 0, 0, canvas:getDimensions())
    popCanvas()
end


function LvLK3D.ProcTexApplyImage(canvas, img)
    pushCanvas(canvas)
        local iw, ih = img:getDimensions()
        local w, h = canvas:getDimensions()

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(img, 0, 0, 0, w / iw, h / ih)
    popCanvas()
end

function LvLK3D.ProcTexApplyColourMul(canvas, r, g, b)
    pushCanvas(canvas)
        applyShader("colourMul", {
            ["colourMul"] = {r or 1, g or 1, b or 1},
        })
    popCanvas()
end

function LvLK3D.ProcTexApplyColourAdd(canvas, r, g, b)
    pushCanvas(canvas)
        applyShader("colourAdd", {
            ["colourAdd"] = {r or 1, g or 1, b or 1},
        })
    popCanvas()
end

function LvLK3D.ProcTexWorleyMultiply(canvas, sx, sy, minDist)
    pushCanvas(canvas)
        applyShader("worleyMultiply", {
            ["minDist"] = minDist or 1,
            ["scale"] = {sx or 3, sy or 3},
        })
    popCanvas()
end

function LvLK3D.ProcTexWorleyNormal(canvas, sx, sy, minDist)
    pushCanvas(canvas)
        applyShader("worleyNormal", {
            ["minDist"] = minDist or 1,
            ["scale"] = {sx or 3, sy or 3},
        })
    popCanvas()
end

function LvLK3D.ProcTexSimplexMultiply(canvas, sx, sy, ox, oy)
    pushCanvas(canvas)
        applyShader("simplexMultiply", {
            ["scale"] = {sx or 1, sy or 1},
            ["offset"] = {ox or 0, oy or 0},
        })
    popCanvas()
end

function LvLK3D.ProcTexSimplexAdd(canvas, sx, sy, ox, oy)
    pushCanvas(canvas)
        applyShader("simplexAdd", {
            ["scale"] = {sx or 1, sy or 1},
            ["offset"] = {ox or 0, oy or 0},
        })
    popCanvas()
end

function LvLK3D.ProcTexInvert(canvas)
    pushCanvas(canvas)
        applyShader("invert", {})
    popCanvas()
end

function LvLK3D.ProcTexBlur(canvas, size, quality, directions)
    pushCanvas(canvas)
        applyShader("gaussianblur", {
            ["size"] = size or 8;
            ["quality"] = quality or 3;
            ["dirs"] = dirs or 16;
        })
    popCanvas()
end

function LvLK3D.ProcTexTreshold(canvas, target, maxDist)
    pushCanvas(canvas)
        applyShader("treshold", {
            ["target"] = target or 0.5,
            ["maxDist"] = maxDist or 0.2,
        })
    popCanvas()
end

function LvLK3D.ProcTexNormalify(canvas)
    pushCanvas(canvas)
        applyShader("normalify", {})
    popCanvas()
end

function LvLK3D.ProcTexClamp(canvas, min, max)
    pushCanvas(canvas)
        applyShader("clamp", {
            ["minVal"] = min or 0,
            ["maxVal"] = max or 1,
        })
    popCanvas()
end


function LvLK3D.ProcTexMask(canvas, mask, texA)
    if (not texA) or (not mask) then
        return
    end

    local tAw, tAh = texA:getDimensions()
    local tMw, tMh = mask:getDimensions()

    pushCanvas(canvas)
        applyShader("mask", {
            ["texA"] = texA,
            ["texASize"] = {tAw, tAh},

            ["mask"] = mask,
            ["maskSize"] = {tMw, tMh},
        })
    popCanvas()
end

function LvLK3D.ProcTexMergeAdd(canvas, texA)
    if not texA then
        return
    end

    local tAw, tAh = texA:getDimensions()

    pushCanvas(canvas)
        applyShader("mergeAdd", {
            ["texA"] = texA,
            ["texASize"] = {tAw, tAh},
        })
    popCanvas()
end

function LvLK3D.ProcTexMultiply(canvas, texA)
    if not texA then
        return
    end

    local tAw, tAh = texA:getDimensions()

    pushCanvas(canvas)
        applyShader("multiply", {
            ["texA"] = texA,
            ["texASize"] = {tAw, tAh},
        })
    popCanvas()
end


function LvLK3D.ProcTexLightDot(canvas, texA, sunDir, specMul, specConst)
    if not texA then
        return
    end

    local tAw, tAh = texA:getDimensions()

    pushCanvas(canvas)
        applyShader("lightdot", {
            ["texA"] = texA,
            ["texASize"] = {tAw, tAh},
            ["sunDir"] = sunDir or {0.25, 0.5, -0.25},
            ["specMul"] = specMul or 1,
            ["specConst"] = specConst or 4,
        })
    popCanvas()
end

function LvLK3D.ProcTexDistort(canvas, texA, mul)
    if not texA then
        return
    end

    local tAw, tAh = texA:getDimensions()

    pushCanvas(canvas)
        applyShader("distort", {
            ["texA"] = texA,
            ["texASize"] = {tAw, tAh},
            ["texDistortMul"] = mul or 0.015,
        })
    popCanvas()
end


function LvLK3D.ProcTexDeclareTexture(name, canvas)
    LvLK3D.Textures[name] = canvas
end