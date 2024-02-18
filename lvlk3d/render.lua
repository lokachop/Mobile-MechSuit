LvLK3D = LvLK3D or {}
-- TODO render meshes
local _MAX_OBJECTS = LvLK3D.MAX_OBJECTS * 1


local function renderObject(obj, shaderOverride)
    local shader = shaderOverride or LvLK3D.CurrShader
    local shaderObj = shader.shader

    love.graphics.setShader(shaderObj)
    shader.onRender(obj, shaderObj)

    local oCol = obj.col
    love.graphics.setColor(oCol[1], oCol[2], oCol[3])
    love.graphics.draw(obj.mesh)

    love.graphics.setShader()
end

local shadowShader = LvLK3D.GetShader("shadowvolume")
local shadowShaderCap = LvLK3D.GetShader("shadowcap")

local function renderShadowed(obj, lpos, shOverride, shVol, shCap)
    obj.SHADOW_LIGHT_POS = lpos

    local volumeShader = shVol or shadowShader
    local volumeShaderObj = volumeShader.shader

    local capShader = shCap or shadowShaderCap
    local capShaderObj = capShader.shader

    love.graphics.setDepthMode("gequal", false)
    love.graphics.stencil(function()
        -- cap
        love.graphics.setShader(capShaderObj)
        love.graphics.setColor(0, 1, 0.5)
        obj.SHADOW_INVERT = false
        obj.CAP_FLIP = true
        capShader.onRender(obj, capShaderObj)
        love.graphics.draw(obj.meshShadowCaps)


        -- volume
        love.graphics.setShader(volumeShaderObj)
        obj.SHADOW_INVERT = false
        volumeShader.onRender(obj, volumeShaderObj)
        love.graphics.setColor(0, 1, 0)
        love.graphics.draw(obj.meshShadow)
    end, "increment", 0, true)


    love.graphics.stencil(function()
        -- cap
        love.graphics.setShader(capShaderObj)
        love.graphics.setColor(1, 0, 0.5)
        obj.SHADOW_INVERT = true
        obj.CAP_FLIP = true
        capShader.onRender(obj, capShaderObj)
        love.graphics.draw(obj.meshShadowCaps)


        -- volume
        love.graphics.setShader(volumeShaderObj)
        obj.SHADOW_INVERT = true
        volumeShader.onRender(obj, volumeShaderObj)
        love.graphics.setColor(1, 0, 0)
        love.graphics.draw(obj.meshShadow)
    end, "decrement", 0, true)





    love.graphics.setShader()
    LvLK3D.SetShader("base")

    love.graphics.setDepthMode("lequal", true)
    renderObject(obj, shOverride)
end


local depthWriteShader = LvLK3D.GetShader("depthwrite")
local ambientWriteShader = LvLK3D.GetShader("ambientwrite")
local lightingShader = LvLK3D.GetShader("lit")
local lightingShaderSun = LvLK3D.GetShader("litsun")

local shadowShaderSun = LvLK3D.GetShader("shadowvolumesun")
local shadowShaderCapSun = LvLK3D.GetShader("shadowcapsun")


local function renderActiveUniverseLit()
    local worldParams = LvLK3D.CurrUniv["worldParameteri"]

    local _doShadow = LvLK3D.DO_SHADOWING
    local _renderShadowed = {}
    for i = 1, _MAX_OBJECTS do
        local obj = LvLK3D.CurrUniv["objects"][i]

        if obj and obj["FULLBRIGHT"] then
            renderObject(obj, depthWriteShader)
        elseif obj then
            obj["LIT_AMBIENT"] = worldParams.ambientCol
            renderObject(obj, ambientWriteShader)
        end

        if _doShadow and obj and obj.SHADOW_VOLUME then
            _renderShadowed[#_renderShadowed + 1] = obj
        end

        ::_contRenderLit1::
    end

    -- additive...
    love.graphics.setBlendMode("add")

    -- do sun pass first, if needed
    if worldParams["doSunLighting"] == true then
        love.graphics.clear(false, true, false)
        for i = 1, #_renderShadowed do
            renderShadowed(_renderShadowed[i], -worldParams["sunDir"], depthWriteShader, shadowShaderSun, shadowShaderCapSun)
        end

        -- shadow volume cutouts done! render with lights...
        love.graphics.setDepthMode("lequal", true)
        love.graphics.setStencilTest("equal", 0)
            for i = 1, _MAX_OBJECTS do
                local obj2 = LvLK3D.CurrUniv["objects"][i]

                if obj2 and obj2["FULLBRIGHT"] then
                    renderObject(obj2)
                elseif obj2 then
                    obj2["LIT_LIGHT_POS"] = -worldParams["sunDir"]
                    obj2["LIT_LIGHT_COL"] = worldParams["sunCol"]

                    renderObject(obj2, lightingShaderSun)
                end
            end
        love.graphics.setStencilTest()
    else
        for i = 1, _MAX_OBJECTS do
            local obj3 = LvLK3D.CurrUniv["objects"][i]

            if obj3 and obj3["FULLBRIGHT"] then
                renderObject(obj3)
            end
        end
    end


    -- now we loop thru each light
    for k, v in pairs(LvLK3D.CurrUniv["lights"]) do
        love.graphics.clear(false, true, false)
        for i = 1, #_renderShadowed do
            renderShadowed(_renderShadowed[i], v.pos, depthWriteShader)
        end

        -- shadow volume cutouts done! render with lights...
        love.graphics.setDepthMode("lequal", true)
        love.graphics.setStencilTest("equal", 0)
            for i = 1, _MAX_OBJECTS do
                local obj4 = LvLK3D.CurrUniv["objects"][i]

                if obj4 and not obj4["FULLBRIGHT"] then
                    obj4["LIT_LIGHT_POS"] = v.pos
                    obj4["LIT_LIGHT_COL"] = v.col
                    obj4["LIT_LIGHT_INT"] = v.intensity

                    renderObject(obj4, lightingShader)
                end
            end
        love.graphics.setStencilTest()
    end


    love.graphics.setBlendMode("alpha")



    --for k, v in ipairs(_renderShadowed) do
    --    renderShadowed(v)
    --end

    --love.graphics.setStencilTest("greater", 0)
    --    love.graphics.setColor(0, 0, 0, 0.75)
    --    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
    --love.graphics.setStencilTest()
end


local function renderActiveUniverseNonLit()
    local _renderShadowed = {}

    for i = 1, _MAX_OBJECTS do
        local obj = LvLK3D.CurrUniv["objects"][i]

        if obj then
            love.graphics.setDepthMode("lequal", true)
            renderObject(obj)
        end
    end

end



function LvLK3D.RenderActiveUniverse()
    if LvLK3D.DO_LIGHTING and ((LvLK3D.CurrUniv["lightCount"] > 0) or (LvLK3D.CurrUniv["worldParameteri"].doSunLighting == true)) then
        renderActiveUniverseLit()
    else
        renderActiveUniverseNonLit()
    end
end

