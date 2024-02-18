LvLK3D = LvLK3D or {}
LvLK3D.Models = LvLK3D.Models or {}


function LvLK3D.GenerateNormals(name, invert, onlySmooth)
	local data = LvLK3D.Models[name]

	if not data then
		return
	end

	local verts = data.verts
	local ind = data.indices

	if not onlySmooth then
		data.normals = {}
		for i = 1, #ind do
			local index = ind[i]

			local v1 = verts[index[1][1]] * 1
			local v2 = verts[index[2][1]] * 1
			local v3 = verts[index[3][1]] * 1

			local norm = (v2 - v1):Cross(v3 - v1)
			norm:Normalize()
			if invert then
				norm = -norm
			end
			data["normals"][i] = norm
		end
	end

	data.s_normals = {}
	for i = 1, #data["normals"] do
		local n = data["normals"][i]
		local index = ind[i]


		local id1 = index[1][1]
		data.s_normals[id1] = (data.s_normals[id1] or Vector(0, 0, 0)) + n
		local id2 = index[2][1]
		data.s_normals[id2] = (data.s_normals[id2] or Vector(0, 0, 0)) + n
		local id3 = index[3][1]
		data.s_normals[id3] = (data.s_normals[id3] or Vector(0, 0, 0)) + n
	end


	for i = 1, #data["s_normals"] do
		if data["s_normals"][i] then
			data["s_normals"][i]:Normalize()
		else
			data["s_normals"][i] = Vector(0, 1, 0)
		end
	end
end


function LvLK3D.DeclareModel(name, data)
	LvLK3D.Models[name] = data
	LvLK3D.GenerateNormals(name)
	print("Declared model \"" .. name .. "\" with " .. #data.verts .. " verts! ^[TBL]")
end