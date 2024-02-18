-- most based off LvLK3D
LvLK3D = LvLK3D or {}
LvLK3D.Textures = LvLK3D.Textures or {}
local canvasParams = {
    type = "2d",
    format = "normal",
    readable = true,
    msaa = 0,
    dpiscale = love.graphics.getDPIScale(),
    mipmaps = "manual",
}


function LvLK3D.NewTextureFunc(name, w, h, func)
    local canvasData = love.graphics.newCanvas(w, h, canvasParams)
    local _oldCanvas = love.graphics.getCanvas()
    local _oldShader = love.graphics.getShader()

    love.graphics.setShader()
    love.graphics.setCanvas(canvasData)
        love.graphics.setColor(1, 1, 1, 1)
        func(w, h)
    love.graphics.setCanvas(_oldCanvas)
    love.graphics.setShader(_oldShader)

    if canvasParams.mipmaps and canvasParams.mipmaps == "manual" then
        canvasData:generateMipmaps()
    end

    LvLK3D.Textures[name] = canvasData
end

function LvLK3D.RenderTexture(name, func)
    local canvasData = LvLK3D.Textures[name]
    local _oldCanvas = love.graphics.getCanvas()
    local _oldShader = love.graphics.getShader()

    love.graphics.setShader()
    love.graphics.setCanvas(canvasData)
        love.graphics.setColor(1, 1, 1, 1)
        func(canvasData:getDimensions())
    love.graphics.setCanvas(_oldCanvas)
    love.graphics.setShader(_oldShader)

    if canvasParams.mipmaps and canvasParams.mipmaps == "manual" then
        canvasData:generateMipmaps()
    end
end

function LvLK3D.CopyTexture(name, to)
    local otherCanvas = LvLK3D.Textures[name]

    local oW, oH = otherCanvas:getDimensions()

    local canvasData = love.graphics.newCanvas(oW, oH, canvasParams)
    local _oldCanvas = love.graphics.getCanvas()
    local _oldShader = love.graphics.getShader()

    love.graphics.setShader()
    love.graphics.setCanvas(canvasData)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setBlendMode("alpha", "premultiplied")
        love.graphics.draw(otherCanvas, 0, 0)
        love.graphics.setBlendMode("alpha")
    love.graphics.setCanvas(_oldCanvas)
    love.graphics.setShader(_oldShader)

    if canvasParams.mipmaps and canvasParams.mipmaps == "manual" then
        canvasData:generateMipmaps()
    end

    LvLK3D.Textures[to] = canvasData
end

local function readByte(fileObject)
    return string.byte(fileObject:read(1))
end

local function closeFile(fileObject)
    fileObject:close()
end

local function readAndGetFileObject(path)
    local f = love.filesystem.newFile(path)
    f:open("r")
    return f
end

local function readString(fileObject)
    -- read the 0A (10)
    local readCont = readByte(fileObject)
    if readCont ~= 10 then
        return "nostring :("
    end

    local buff = {}
    for i = 1, 4096 do -- read long strings
        readCont = readByte(fileObject)
        if readCont == 10 then
            break
        end

        buff[#buff + 1] = string.char(readCont)
    end

    return table.concat(buff, "")
end

local function readUntil(fileObject, stopNum)
    local readCont
    local buff = {}
    for i = 1, 2048 do -- read big nums
        readCont = readByte(fileObject)
        if readCont == stopNum then
            break
        end

        buff[#buff + 1] = string.char(readCont)
    end
    return table.concat(buff, "")
end

-- ppm files are header + raw data which is EZ
function LvLK3D.NewTexturePPM(name, path)
    print("---LvLK3D-PPMLoad---")
    print("Loading texture at \"" .. path .. "\"")


    local fObj = readAndGetFileObject(path)
    local readCont = readByte(fObj)
    if readCont ~= 80 then
        closeFile(fObj)
        error("PPM Decode error! (header no match!) [" .. readCont .. "]")
        return
    end

    readCont = readByte(fObj)
    if readCont ~= 54 then
        closeFile(fObj)
        error("PPM Decode error! (header no match!) [" .. readCont .. "]")
        return
    end
    readCont = readByte(fObj)
    -- string, read until next 10
    if readCont == 10 then
        local fComm = readUntil(fObj, 10)
        print("Comment; \"" .. fComm .. "\"")
    end

    -- read the width and height
    local w = tonumber(readUntil(fObj, 32))
    local h = tonumber(readUntil(fObj, 10))

    local cDepth = tonumber(readUntil(fObj, 10))
    print("Texture is " .. w .. "x" .. h .. " with a coldepth of " .. cDepth)


    local canvasData = love.graphics.newCanvas(w, h, canvasParams)
    local _oldCanvas = love.graphics.getCanvas()
    local _oldShader = love.graphics.getShader()
    -- slow pixel loading
    love.graphics.setShader()
    love.graphics.setCanvas(canvasData)
    local pixToRead = w * h
    for i = 0, (pixToRead - 1) do
        local r = readByte(fObj) / cDepth
        local g = readByte(fObj) / cDepth
        local b = readByte(fObj) / cDepth


        love.graphics.setColor(r, g, b)
        local xc = (i % w)
        local yc = math.floor(i / w)


        love.graphics.rectangle("fill", xc, yc, 1, 1)
    end
    closeFile(fObj)

    love.graphics.setCanvas(_oldCanvas)
    love.graphics.setShader(_oldShader)

    if canvasParams.mipmaps and canvasParams.mipmaps == "manual" then
        canvasData:generateMipmaps()
    end

    LvLK3D.Textures[name] = canvasData
end

function LvLK3D.NewTexturePNG(name, path)
    print("---LvLK3D-PNGLoad---")
    print("Loading texture at \"" .. path .. "\"")

    local imgDraw = love.graphics.newImage(path)
    if not imgDraw then
        LvLK3D.CopyTexture("fail", name)
    end

    local w, h = imgDraw:getDimensions()
    local canvasData = love.graphics.newCanvas(w, h, canvasParams)
    local _oldCanvas = love.graphics.getCanvas()
    local _oldShader = love.graphics.getShader()

    love.graphics.setShader()
    love.graphics.setCanvas(canvasData)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(imgDraw, 0, 0)
    love.graphics.setCanvas(_oldCanvas)
    love.graphics.setShader(_oldShader)

    if canvasParams.mipmaps and canvasParams.mipmaps == "manual" then
        canvasData:generateMipmaps()
    end

    LvLK3D.Textures[name] = canvasData
end



function LvLK3D.GetTexture(name)
    local tex = LvLK3D.Textures[name]
    if not tex then
        return LvLK3D.Textures["none"]
    end

    return tex
end

function LvLK3D.NewTextureEmpty(name, w, h, col)
    local canvasData = love.graphics.newCanvas(w, h, canvasParams)
    local _oldCanvas = love.graphics.getCanvas()
    local _oldShader = love.graphics.getShader()

    love.graphics.setShader()
    love.graphics.setCanvas(canvasData)
        love.graphics.clear(col[1] / 255, col[2] / 255, col[3] / 255)
    love.graphics.setCanvas(_oldCanvas)
    love.graphics.setShader(_oldShader)


    if canvasParams.mipmaps and canvasParams.mipmaps == "manual" then
        canvasData:generateMipmaps()
    end

    LvLK3D.Textures[name] = canvasData
end

function LvLK3D.NewTexturePixel(name, w, h, func)
    local canvasData = love.graphics.newCanvas(w, h, canvasParams)
    local _oldCanvas = love.graphics.getCanvas()
    local _oldShader = love.graphics.getShader()

    love.graphics.setShader()
    love.graphics.setCanvas(canvasData)
        for i = 0, ((w * h) - 1) do
            local xc = i % w
            local yc = math.floor(i / w)
            local fine, dataFunc = pcall(func, xc, yc)
            if not fine then
                print("TextureInit error!;" .. dataFunc)
                dataFunc = {255, 255, 0}
            end

            love.graphics.setColor(dataFunc[1] / 255, dataFunc[2] / 255, dataFunc[3] / 255)
            love.graphics.rectangle("fill", xc, yc, 1, 1)
        end
    love.graphics.setCanvas(_oldCanvas)
    love.graphics.setShader(_oldShader)

    if canvasParams.mipmaps and canvasParams.mipmaps == "manual" then
        canvasData:generateMipmaps()
    end

    LvLK3D.Textures[name] = canvasData
end


function LvLK3D.SetTextureFilter(name, near, far)
    LvLK3D.Textures[name]:setFilter(near, far or near)
end

function LvLK3D.SetTextureWrap(name, mode)
    LvLK3D.Textures[name]:setWrap(mode)
end

LvLK3D.NewTextureFunc("none", 2, 2, function(w, h)
    love.graphics.setColor(0.6, 0.6, 0.6)
    love.graphics.rectangle("fill", 0, 0, w * .5, h * .5)
    love.graphics.rectangle("fill", w * .5, h * .5, w * .5, h * .5)

    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", w * .5, 0, w * .5, h * .5)
    love.graphics.rectangle("fill", 0, h * .5, w * .5, h * .5)
end)
LvLK3D.SetTextureFilter("none", "nearest", "nearest")

LvLK3D.NewTextureFunc("fail", 2, 2, function(w, h)
    love.graphics.setColor(0.6, 0.3, 0.7)
    love.graphics.rectangle("fill", 0, 0, w * .5, h * .5)
    love.graphics.rectangle("fill", w * .5, h * .5, w * .5, h * .5)

    love.graphics.setColor(0.15, 0.1, 0.2)
    love.graphics.rectangle("fill", w * .5, 0, w * .5, h * .5)
    love.graphics.rectangle("fill", 0, h * .5, w * .5, h * .5)
end)
LvLK3D.SetTextureFilter("fail", "nearest", "nearest")

LvLK3D.NewTextureEmpty("white", 2, 2, {255, 255, 255})
LvLK3D.NewTextureEmpty("indigo", 2, 2, {51, 0, 153})


--[[
LvLK3D.NewTexturePPM("cubemap",            "textures/cubemap_lq.ppm")
LvLK3D.NewTexturePPM("jelly",      "textures/jelly.ppm")
LvLK3D.NewTexturePPM("jet",        "textures/jet.ppm")
]]--