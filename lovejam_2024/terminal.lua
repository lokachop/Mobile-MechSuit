LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local fontLarge = love.graphics.newFont(64)
local fontSz = 10
local fontSmall = love.graphics.newFont(fontSz, "mono")
LvLK3D.NewTextureFunc("terminal_tex", 256, 256, function()
    local okSpacing = string.rep(" ", 6)
    love.graphics.clear(0.0, 0.05, 0.0, 1, true, true)
    love.graphics.setColor(0, 1, 0)

    local yBuff = 0
    love.graphics.print("MECH::LOAD", fontSmall, 0, yBuff)
    yBuff = yBuff + 10
    love.graphics.print("->HYDRAULICS" .. okSpacing .. "[OK]", fontSmall, 0, yBuff)
    yBuff = yBuff + 10
    love.graphics.print("->TEST" .. okSpacing .. "[OK]", fontSmall, 0, yBuff)
    yBuff = yBuff + 10
end)
LvLK3D.SetTextureFilter("terminal_tex", "nearest", "nearest")


local lineCount = 24
local terminalBuffer = {}
local function refreshTerminal()
    LvLK3D.RenderTexture("camera_tex", function()
        local w, h = love.graphics.getCanvas():getDimensions()
        love.graphics.clear(0.0, 0.05, 0.0, 1, true, true)


        love.graphics.setColor(0, 1, 0)
        local yBuff = h - fontSz
        for k, v in ipairs(terminalBuffer) do
            love.graphics.print(v, fontSmall, 0, yBuff)
            yBuff = yBuff - fontSz
        end
    end)
end


function LoveJam.PushMessageToTerminal(msg)
    terminalBuffer[#terminalBuffer + 1] = msg
    terminalBuffer[lineCount + 1] = nil

    refreshTerminal()
end


function LoveJam.EditCurrentMessageOnTerminal(msg)
    terminalBuffer[#terminalBuffer + 1] = msg
    terminalBuffer[lineCount + 1] = nil

    refreshTerminal()
end
