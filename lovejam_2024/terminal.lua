LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local fontLarge = love.graphics.newFont(64)
local fontSmall = love.graphics.newFont(10, "mono")


local lineCount = 24
local terminalBuffer = {}


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