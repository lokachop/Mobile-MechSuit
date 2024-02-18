LvLK3D = LvLK3D or {}
LvLK3D.UniverseRegistry = LvLK3D.UniverseRegistry or {}

function LvLK3D.NewUniverse(tag)
	if not tag then
		error("Attempt to make a universe without a tag!")
	end

	local univData = {
		["objectIDLUT"] = {},
		["objects"] = {},
		["objectCount"] = 0,
		["lights"] = {},
		["lightCount"] = 0,
		["tag"] = tag,
		["worldParameteri"] = {
			["doSunLighting"] = true,
			["sunCol"] = {1, 1, 1},
			["sunDir"] = Vector(0, -2, 0):GetNormalized(),
			["ambientCol"] = {0.0, 0.0, 0.0}
		}
	}

	print("new universe, \"" .. tag .. "\"")
	LvLK3D.UniverseRegistry[tag] = univData

	return LvLK3D.UniverseRegistry[tag]
end

LvLK3D.BaseUniv = LvLK3D.NewUniverse("LvLK3D_base_univ")

LvLK3D.CurrUniv = LvLK3D.BaseUniv
LvLK3D.UniverseStack = LvLK3D.UniverseStack or {}

function LvLK3D.PushUniverse(univ)
	LvLK3D.UniverseStack[#LvLK3D.UniverseStack + 1] = LvLK3D.CurrUniv
	LvLK3D.CurrUniv = univ
end

function LvLK3D.PopUniverse()
	local _prev = LvLK3D.CurrUniv
	LvLK3D.CurrUniv = LvLK3D.UniverseStack[#LvLK3D.UniverseStack] or LvLK3D.BaseUniv
	LvLK3D.UniverseStack[#LvLK3D.UniverseStack] = nil

	return _prev
end

function LvLK3D.ClearUniverse(univ)
	univ = univ or LvLK3D.CurrUniv

	for k, v in pairs(univ["objects"]) do
		univ[k] = nil
	end

	for k, v in pairs(univ["lights"]) do
		univ[k] = nil
	end
end

function LvLK3D.GetUniverseByTag(tag)
	return LvLK3D.UniverseRegistry[tag]
end

function LvLK3D.GetUniverseParams(univ)
	univ = univ or LvLK3D.CurrUniv

	return univ.worldParameteri
end


function LvLK3D.SetSunLighting(bool, univ)
	univ = univ or LvLK3D.CurrUniv

	univ.worldParameteri["doSunLighting"] = bool
end

function LvLK3D.SetSunCol(col, univ)
	univ = univ or LvLK3D.CurrUniv

	univ.worldParameteri["sunCol"] = col or {1, 1, 1}
end

function LvLK3D.SetSunDir(dir, univ)
	univ = univ or LvLK3D.CurrUniv

	univ.worldParameteri["sunDir"] = dir or Vector(1, 2, 4):GetNormalized()
end

function LvLK3D.SetAmbientCol(col, univ)
	univ = univ or LvLK3D.CurrUniv

	univ.worldParameteri["ambientCol"] = col or {0, 0, 0}
end


function LvLK3D.GetObjectCount(univ)
	univ = univ or LvLK3D.CurrUniv

	return univ["objectCount"]
end