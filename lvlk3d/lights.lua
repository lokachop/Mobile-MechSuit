LvLK3D = LvLK3D or {}

function LvLK3D.AddLightToUniv(name, pos, intensity, col)
	LvLK3D.CurrUniv["lights"][name] = {
		pos = pos or Vector(0, 0, 0),
		intensity = 1 / intensity or 1,
		col = col or {1, 1, 1},
		tag = name,
	}

	LvLK3D.CurrUniv["lightCount"] = LvLK3D.CurrUniv["lightCount"] + 1
end

function LvLK3D.SetLightPos(name, pos)
	if not LvLK3D.CurrUniv["lights"][name] then
		return
	end

	LvLK3D.CurrUniv["lights"][name].pos = pos or Vector(0, 0, 0)
end

function LvLK3D.SetLightIntensity(name, intensity)
	if not LvLK3D.CurrUniv["lights"][name] then
		return
	end

	LvLK3D.CurrUniv["lights"][name].intensity = (1 / intensity) or 1
end

function LvLK3D.SetLightCol(name, col)
	if not LvLK3D.CurrUniv["lights"][name] then
		return
	end

	LvLK3D.CurrUniv["lights"][name].col = col or {1, 1, 1}
end


function LvLK3D.RemoveLight(name)
	if not LvLK3D.CurrUniv["lights"][name] then
		return
	end

	LvLK3D.CurrUniv["lights"][name] = nil

	LvLK3D.CurrUniv["lightCount"] = LvLK3D.CurrUniv["lightCount"] - 1
end