LvLK3D = LvLK3D or {}

-- glua
local function string_ToTable(str)
	local tbl = {}

	for i = 1, #str do
		tbl[i] = string.sub(str, i, i)
	end

	return tbl
end

local string_sub = string.sub
local string_find = string.find
local string_len = string.len
local function string_explode( separator, str, withpattern)
	if (separator == "") then
		return string_ToTable(str)
	end

	if withpattern == nil then
		withpattern = false
	end

	local ret = {}
	local current_pos = 1

	for i = 1, string_len(str) do
		local start_pos, end_pos = string_find(str, separator, current_pos, not withpattern)
		if not start_pos then
			break
		end
		ret[i] = string_sub(str, current_pos, start_pos - 1)
		current_pos = end_pos + 1
	end

	ret[#ret + 1] = string_sub(str, current_pos)

	return ret
end

local function string_trim( s, char )
	if ( char ) then char = string.PatternSafe( char ) else char = "%s" end
	return string.match( s, "^" .. char .. "*(.-)" .. char .. "*$" ) or s
end

function LvLK3D.DeclareModelOBJ(name, objData)
	local data = {}
	data["verts"] = {}
	data["uvs"] = {}
	data["indices"] = {}
	data["normals"] = {}
	data["s_normals"] = {}

	local verts = data["verts"]
	local uvs = data["uvs"]
	local indices = data["indices"]
	local normals = data["normals"]
	local s_normals = data["s_normals"]

	local hadNormal = false

	local _tempNormals = {}

	-- its obj so parse each line
	for k, v in ipairs(string_explode("\n", objData, false)) do
		local ident = string.sub(v, 1, 2)
		ident = string_trim(ident)
		local cont = string.sub(v, #ident + 2) -- shit code
		if not cont then
			goto _cont
		end

		if ident == "#" then
			print("[Comment]: " .. cont)
		elseif ident == "v" then
			local expVars = string_explode(" ", cont, false)

			local x = tonumber(string_trim(expVars[1]))
			local y = tonumber(string_trim(expVars[2]))
			local z = tonumber(string_trim(expVars[3]))

			local vecBuild = Vector(x, y, z)
			verts[#verts + 1] = vecBuild
		elseif ident == "vt" then
			local expVars = string_explode(" ", cont, false)

			local uR = tonumber(string_trim(expVars[1]))
			local vR = tonumber(string_trim(expVars[2]))

			uvs[#uvs + 1] = {uR, vR}
		elseif ident == "vn" then
			hadNormal = true

			local expVars = string_explode(" ", cont, false)
			local x = tonumber(string_trim(expVars[1]))
			local y = tonumber(string_trim(expVars[2]))
			local z = tonumber(string_trim(expVars[3]))

			local vecBuild = Vector(x, y, z)
			_tempNormals[#_tempNormals + 1] = vecBuild
		elseif ident == "f" then
			local expVars = string_explode(" ", cont, false)

			local bInd = {}

			local normAvgBuild = {}
			local hadNorm = false
			for i = 1, 3 do
				local datExp2 = string_explode("/", expVars[i], false)
				local iP, iTN, iT = tonumber(datExp2[1]), tonumber(datExp2[2]), tonumber(datExp2[3])

				if iP and (not iTN) and (not iTN) then -- pos only
					bInd[#bInd + 1] = {iP, 1}
				end

				if iP and iTN and (not iT) then -- pos / tex
					bInd[#bInd + 1] = {iP, iTN}
				end

				if iP and iTN and iT then -- pos / tex / norm
					bInd[#bInd + 1] = {iP, iTN}

					s_normals[#s_normals + 1] = _tempNormals[iT] * 1
					normAvgBuild[i] = _tempNormals[iT] * 1
					hadNorm = true
				end

				if iP and (not iTN) and iT then -- pos // norm
					bInd[#bInd + 1] = {iP, 1}

					s_normals[#s_normals + 1] = _tempNormals[iT] * 1
					normAvgBuild[i] = _tempNormals[iT] * 1
					hadNorm = true
				end
			end

			indices[#indices + 1] = bInd

			if hadNorm then
				local norm = (normAvgBuild[1] + normAvgBuild[2] + normAvgBuild[3])
				norm:Normalize()
				normals[#normals + 1] = norm
			end
		end

		::_cont::
	end

	LvLK3D.Models[name] = data
	LvLK3D.GenerateNormals(name, false, hadNormal)
	print("Declared model \"" .. name .. "\" with " .. #data.verts .. " verts! ^[OBJ]")
end

function LvLK3D.LoadModelFromOBJ(name, path)
	local data = love.filesystem.read(path)
	if not data then
		error("Could not read model \"" .. path .. "\"")
		return
	end

	LvLK3D.DeclareModelOBJ(name, data)
end