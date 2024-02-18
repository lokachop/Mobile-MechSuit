LoveJam = LoveJam or {}
LoveJam.States = LoveJam.States or {}

LoveJam.CurrState = -99
function LoveJam.GetStateParameters(state)
    return LoveJam.States[state]
end

function LoveJam.NewState(id)
    LoveJam.States[id] = {}
    return LoveJam.States[id]
end

function LoveJam.StateThink(dt)
    local currParams = LoveJam.GetStateParameters(LoveJam.CurrState)
    if currParams and currParams.onThink then
        currParams.onThink(dt)
    end
end

function LoveJam.StateRender()
    local currParams = LoveJam.GetStateParameters(LoveJam.CurrState)
    if currParams and currParams.onRender then
        currParams.onRender()
    end
end

function LoveJam.StateMouseMoved(mx, my, dx, dy)
    local currParams = LoveJam.GetStateParameters(LoveJam.CurrState)
    if currParams and currParams.onMouseMoved then
        currParams.onMouseMoved(mx, my, dx, dy)
    end
end

function LoveJam.StateKeyPressed(key)
    local currParams = LoveJam.GetStateParameters(LoveJam.CurrState)
    if currParams and currParams.onKeyPressed then
        currParams.onKeyPressed(key)
    end
end


function LoveJam.SetState(new)
    local prevParams = LoveJam.GetStateParameters(LoveJam.CurrState)
    if prevParams and prevParams.onExit then
        prevParams.onExit(new)
    end

    LoveJam.CurrState = new
    local currParams = LoveJam.GetStateParameters(LoveJam.CurrState)
    if currParams and currParams.onEnter then
        currParams.onEnter(new)
    end
end