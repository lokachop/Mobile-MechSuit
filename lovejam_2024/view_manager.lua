LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}


LoveJam.ViewTarget = Vector(0, -.7, 1.1)
LoveJam.AngTarget = Angle(0, 0, 0)
local CurrView = Vector(0, 0.75, 2)
local CurrAng = Angle(0, 0, 0)


local function length3D(x, y, z)
    return math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
end

local function moveTowards3D(ax, ay, az, bx, by, bz, delta)
    local dx = bx - ax
    local dy = by - ay
    local dz = bz - az

    local len = length3D(dx, dy, dz)

    if (len <= delta) or len == 0 then
        return bx, by, bz
    end

    return ax + (dx / len) * delta, ay + (dy / len) * delta, az + (dz / len) * delta
end

local function sign(x)
    return x < 0 and -1 or 1
end

local function moveTowards(a, b, delta)
    if math.abs(a - b) <= delta then
        return b
    end

    return a + (sign(b - a) * delta)
end

function LoveJam.InternalViewThink(dt)
    local tVal = dt * 1

    local vt = LoveJam.ViewTarget
    local nx, ny, nz = moveTowards3D(CurrView[1], CurrView[2], CurrView[3], vt[1], vt[2], vt[3], tVal)
    CurrView[1] = nx
    CurrView[2] = ny
    CurrView[3] = nz

    --print(CurrView)

    LvLK3D.SetCamPos(CurrView)

    local newYaw = moveTowards(CurrAng[2], LoveJam.AngTarget[2], tVal * 48)
    CurrAng[2] = newYaw
    LvLK3D.SetCamAng(CurrAng)
end


local viewRegistry = {}
function LoveJam.NewView(name)
    local view = {
        zones = {},
        zNameToID = {},
        onEnter = function() end,
        onExit = function() end,
        onThink = function(dt) end,
        onDraw = function() end,
        name = name
    }

    viewRegistry[name] = view
    return view
end

function LoveJam.GetViewByName(name)
    return viewRegistry[name]
end

function LoveJam.NewZone(view, params)
    local nID = #view.zones + 1

    view.zones[nID] = {
        x = params.x or 0,
        y = params.y or 0,
        w = params.w or 1,
        h = params.h or 1,
        target = params.target or "view_general",
        name = name,
    }
end



local function inrange(x, a, b)
    return x >= a and x <= b
end

local function inrange2D(x, y, ax, ay, bx, by)
    return inrange(x, ax, bx) and inrange(y, ay, by)
end

local nextSwitch = CurTime + 1.75
local function canSwitchView()
    if CurTime > nextSwitch then
        return true
    else
        return false
    end
end

local function applyNextSwitch()
    nextSwitch = CurTime + .75
end




local currView = "view_general"
function LoveJam.MouseZoneHandle(mx, my)
    if not canSwitchView() then
        return
    end


    local view = LoveJam.GetViewByName(currView)
    local sw, sh = love.graphics.getDimensions()

    for k, v in ipairs(view.zones) do
        if not inrange2D(mx, my, v.x * sw, v.y * sh, (v.x + v.w) * sw, (v.y + v.h) * sh) then
            goto _cont
        end

        if currView ~= v.target then
            local currData = LoveJam.GetViewByName(currView)
            if currData then
                currData.onExit()
            end

            currView = v.target
            local newData = LoveJam.GetViewByName(v.target)
            newData.onEnter()

            applyNextSwitch()
        end

        ::_cont::
    end
end


function LoveJam.ViewThink(dt)
    local view = LoveJam.GetViewByName(currView)
    view.onThink()
end

function LoveJam.ViewRender()
    local view = LoveJam.GetViewByName(currView)
    view.onDraw()
end




function LoveJam.RenderZones()
    if not canSwitchView() then
        return
    end


    local view = LoveJam.GetViewByName(currView)
    local sw, sh = love.graphics.getDimensions()

    love.graphics.setLineWidth(4)
    for k, v in ipairs(view.zones) do
        local mx, my = love.mouse.getPosition()

        if inrange2D(mx, my, v.x * sw, v.y * sh, (v.x + v.w) * sw, (v.y + v.h) * sh) then
            love.graphics.setColor(0, 1, 0, 0.5)
        else
            love.graphics.setColor(1, 0, 0, 0.5)
        end

        love.graphics.rectangle("fill", v.x * sw, v.y * sh, v.w * sw, v.h * sh)

        love.graphics.rectangle("line", v.x * sw, v.y * sh, v.w * sw, v.h * sh)
    end
end