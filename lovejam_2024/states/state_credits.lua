LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}



local creditsLoop = love.audio.newSource("sounds/music/credits.wav", "stream")
creditsLoop:setLooping(true)
local function beginMusic()
	creditsLoop:play()
end

local function endMusic()
	creditsLoop:stop()
end

local id, state = LoveJam.NewState()
STATE_CREDITS = id


local sw, sh = love.graphics.getDimensions()


local function cbrtf(n)
	return n ^ 0.3333333333333333333333
end

local function lerp(t, a, b)
	return a * (1 - t) + b * t
end


--https://bottosson.github.io/posts/oklab/
local function lerp_oklab(t, from, to)
	return {
		L = lerp(t, from.L, to.L),
		a = lerp(t, from.a, to.a),
		b = lerp(t, from.b, to.b),
	}
end


local function linear_srgb_to_oklab(c)
	local l = 0.4122214708 * c[1] + 0.5363325363 * c[2] + 0.0514459929 * c[3]
	local  m = 0.2119034982 * c[1] + 0.6806995451 * c[2] + 0.1073969566 * c[3]
	local s = 0.0883024619 * c[1] + 0.2817188376 * c[2] + 0.6299787005 * c[3]

	local  l_ = cbrtf(l)
	local  m_ = cbrtf(m)
	local  s_ = cbrtf(s)

	return {
		L = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
		a = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
		b = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.808675766 * s_,
	}
end

local function oklab_to_linear_srgb(c)
	local l_ = c.L + 0.3963377774 * c.a + 0.2158037573 * c.b
	local m_ = c.L - 0.1055613458 * c.a - 0.0638541728 * c.b
	local s_ = c.L - 0.0894841775 * c.a - 1.2914855480 * c.b

	local l = l_ * l_ * l_
	local m = m_ * m_ * m_
	local s = s_ * s_ * s_

	return {
		4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
		-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
		-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
	}
end





local function renderOKLabGradient(x, y, w, h, cS, cE, steps)
	local col_s = linear_srgb_to_oklab(cS)
	local col_f = linear_srgb_to_oklab(cE)
	steps = steps or 128

	local hDiv = h / steps
	for i = 0, steps - 1 do
		local d = i / (steps - 1)
		local colLerped = oklab_to_linear_srgb(lerp_oklab(d, col_s, col_f))

		love.graphics.setColor(colLerped[1] / 255, colLerped[2] / 255, colLerped[3] / 255, (cS[4] or 255) / 255)
		love.graphics.rectangle("fill", x, y + i * hDiv, w, hDiv)
	end
end


local fontSize = (sw / 1920) * 32


local fontBold = love.graphics.newFont("fonts/InterDisplay-Bold.ttf", fontSize * 2)
local fontRegular = love.graphics.newFont("fonts/InterDisplay-Regular.ttf", fontSize)

local creditsBlob = [[
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
[LOGO]
 
 
 
 
#A game by Lokachop & Lefton
 
Entry for the LÖVE JAM 2024
 
 
 
 
 
#---[Lefton]---
 
Textures
Reactor Core level (last level)
 
 
 
 
 
 
 
#---[Lokachop]---
 
LvLK3D (3D engine)
LvLKUI (UI system)
Rest of the game
 
 
 
 
 
 
 
 
 
#==== Tools Used ====
 
- Texture Creation -
Aseprite (https://www.aseprite.org/)
GIMP (https://www.gimp.org/)
 
 
 
 
- Sound Creation -
LMMS (https://lmms.io/)
Audacity (https://www.audacityteam.org/)
Wavosaur (https://www.wavosaur.com/)
 
 
 
 
- Model Creation -
Blender (https://www.blender.org/)
 
 
 
 
 
#==== Fonts Used ====
 
Inter (https://github.com/rsms/inter)
Perfect DOS VGA 437 (https://www.dafont.com/perfect-dos-vga-437.font)
 
 
 
 
 
#==== Special Thanks ====
 
Lefton: For somehow enduring the map editor
The LÖVE2D Team: For making an awesome framework
You: For playing the game
 
 
 
 
 
 
 
#Thank you for playing!
]]


local texLogo = love.graphics.newImage("textures/logo.png")
texLogo:setFilter("nearest", "nearest")


local lineData = {}
local lines = string.gmatch(creditsBlob, "([^\n]+)")
local lineID = 0
local lineCount = 0
for line in lines do
	lineID = lineID + 1

	if line == "[LOGO]" then
		lineData[lineID] = "title"
	elseif string.sub(line, 1, 1) == "#" then
		lineData[lineID] = love.graphics.newText(fontBold, string.sub(line, 2))
	else
		lineData[lineID] = love.graphics.newText(fontRegular, line)
	end
end
lineCount = lineID

local scrollSpeed = 128
local textSpace = fontSize * 1.5
local cTime = 0

local function renderCredits()
	for k, v in ipairs(lineData) do
		if v == "title" then
			local lw, lh = texLogo:getDimensions()
			local sclMul = 12
			love.graphics.draw(texLogo, sw * .5 - lw * .5 * sclMul, (k * textSpace) - (cTime * scrollSpeed) - lh * .5 * sclMul, 0, sclMul, sclMul)
		else
			local tw, th = v:getDimensions()
			love.graphics.setColor(0, 0, 0, 1)
			love.graphics.draw(v, (sw * .5 - tw * .5) + 2, ((k * textSpace) - (cTime * scrollSpeed)) + 2)


			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(v, sw * .5 - tw * .5, (k * textSpace) - (cTime * scrollSpeed))
		end
	end
end


function state.onThink(dt)
	cTime = cTime + dt


	local eTime = ((lineCount * textSpace) / scrollSpeed) + 3
	if cTime >= eTime then
		LoveJam.SetState(STATE_MAINMENU)
	end

	if love.keyboard.isDown("escape") then -- they want to escape
		LoveJam.SetState(STATE_MAINMENU)
	end
end



function state.onRender()
	love.graphics.clear(.1, .1, .2, 1, true, true)
	renderOKLabGradient(0, 0, sw, sh, {16, 64, 96, 255}, {16, 96, 64}, sh * .25)
	renderCredits()
end


function state.onEnter()
	cTime = 0
	beginMusic()
end

function state.onExit()
	endMusic()
end
