LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}



local GridEditTarget = Vector(0, 0, 0)
local GridEditCamZoom = 4
function LKEdit.GECamThink(dt)
	LvLK3D.SetCamPos(Vector(GridEditTarget[1] * GRID_SZ, GridEditCamZoom * 4, GridEditTarget[2] * GRID_SZ))
	LvLK3D.SetCamAng(Angle(-90, 0, 0))
end

local UniverseEditPlaneRef = LvLK3D.GetUniverseByTag("UniverseEditPlaneRef")
local function pushTile(x, y, mat)
	LvLK3D.PushUniverse(UniverseEditPlaneRef)
		local objPrev = LvLK3D.GetObjectByName("objtile_x" .. x .. "y" .. y)
		if objPrev ~= nil then
			LvLK3D.RemoveObjectFromUniv(objPrev)
		end


		local pObj = LvLK3D.AddObjectToUniv("objtile_x" .. x .. "y" .. y, "plane")
		LvLK3D.SetObjectPos(pObj, Vector(x * GRID_SZ, 0, y * GRID_SZ))
		LvLK3D.SetObjectAng(pObj, Angle(0, 0, 0))
		LvLK3D.SetObjectScl(pObj, Vector(GRID_SZ * .5, 1, GRID_SZ * .5))
		LvLK3D.SetObjectMat(pObj, mat)
		LvLK3D.SetObjectFlag(pObj, "FULLBRIGHT", true)
		LvLK3D.SetObjectFlag(pObj, "NO_TRACE", true)
	LvLK3D.PopUniverse()
end


function LKEdit.RebuildVisTiles()
	local cLevel = LKEdit.CurrLevel
	if not cLevel.tiles then
		return
	end

	for k, v in pairs(cLevel.tiles) do
		for k2, v2 in pairs(v) do
			local tParams = LoveJam.GetTileParams(v2)
			pushTile(k, k2, tParams.editorTex)
		end
	end
end




local function addTileToLevel(x, y, tType)
	local cLevel = LKEdit.CurrLevel
	local tilePtr = cLevel.tiles

	if not tilePtr[x] then
		tilePtr[x] = {}
	end

	tilePtr[x][y] = tType
	local tParams = LoveJam.GetTileParams(tType)
	pushTile(x, y, tParams.editorTex)
end




local function printShadow(text, x, y)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.print(text, x + 2, y + 2)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print(text, x, y)
end


local function updateCursor()
	LvLK3D.PushUniverse(UniverseEditPlaneRef)
		local objCursor = LvLK3D.GetObjectByName("planeCursor")
		LvLK3D.SetObjectPos(objCursor, Vector(GridEditTarget[1] * GRID_SZ, 0, GridEditTarget[2] * GRID_SZ))
	LvLK3D.PopUniverse()
end


function LKEdit.GEPaint()
	local w, h = love.graphics.getDimensions()

	printShadow("GEdit keys; \nkp-/kp+:zoom in / out\nkp8/kp5/kp4/kp6: move\n1: Tile ground\n2: Tile wall\n3: Tile kill\n4: Tile spawn", w * .5, 64)
end


function LKEdit.GEKeys(key)
	if key == "kp-" then
		GridEditCamZoom = GridEditCamZoom * 1.1
	elseif key == "kp+" then
		GridEditCamZoom = GridEditCamZoom / 1.1
	end

	if key == "kp8" then
		GridEditTarget[2] = GridEditTarget[2] - 1
	elseif key == "kp5" then
		GridEditTarget[2] = GridEditTarget[2] + 1
	end

	if key == "kp4" then
		GridEditTarget[1] = GridEditTarget[1] - 1
	elseif key == "kp6" then
		GridEditTarget[1] = GridEditTarget[1] + 1
	end
	updateCursor()


	-- BAD
	if key == "1" then
		addTileToLevel(GridEditTarget[1], GridEditTarget[2], TILE_GROUND)
	end

	if key == "2" then
		addTileToLevel(GridEditTarget[1], GridEditTarget[2], TILE_WALL)
	end

	if key == "3" then
		addTileToLevel(GridEditTarget[1], GridEditTarget[2], TILE_KILL)
	end

	if key == "4" then
		addTileToLevel(GridEditTarget[1], GridEditTarget[2], TILE_SPAWN)
	end
end



function LKEdit.ToggleGridEdit(key)
	if key ~= "kp9" then
		return
	end

	LKEdit.GridEdit = not LKEdit.GridEdit
	love.mouse.setGrabbed(false)
	love.mouse.setRelativeMode(false)
	LvLK3D.CamInputLock = false


	print("GridEdit now " .. tostring(LKEdit.GridEdit))
end