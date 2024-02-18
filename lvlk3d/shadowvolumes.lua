LvLK3D = LvLK3D or {}

local vertFormat = {
	{"VertexPosition", "float", 3},
	{"VertexNormal", "float", 3},
	--{"VCol", "byte", 4},
}


local he_begin = "["
local he_separator = ":"
local he_separator2 = "|"
local he_concat_tbl = {
	[1] = "[",
	[3] = ":",
	[5] = ":",
	[7] = "|",
	[9] = ":",
	[11] = ":",
}
local he_empty_connect = ""
local function hashEdge(e)
	he_concat_tbl[2] = math.floor(e[1][1] * 1000) / 1000
	he_concat_tbl[4] = math.floor(e[1][2] * 1000) / 1000
	he_concat_tbl[6] = math.floor(e[1][3] * 1000) / 1000

	he_concat_tbl[8] = math.floor(e[2][1] * 1000) / 1000
	he_concat_tbl[10] = math.floor(e[2][2] * 1000) / 1000
	he_concat_tbl[12] = math.floor(e[2][3] * 1000) / 1000


	return table.concat(he_concat_tbl, he_empty_connect)
end



local function insertDegenerate(tbl, e1, e2, e3, e4, norm1, norm2)
	tbl[#tbl + 1] = {e1[1], e1[2], e1[3], norm1[1], norm1[2], norm1[3]}
	tbl[#tbl + 1] = {e2[1], e2[2], e2[3], norm1[1], norm1[2], norm1[3]}
	tbl[#tbl + 1] = {e3[1], e3[2], e3[3], norm2[1], norm2[2], norm2[3]}


	tbl[#tbl + 1] = {e1[1], e1[2], e1[3], norm1[1], norm1[2], norm1[3]}
	tbl[#tbl + 1] = {e3[1], e3[2], e3[3], norm2[1], norm2[2], norm2[3]}
	tbl[#tbl + 1] = {e4[1], e4[2], e4[3], norm2[1], norm2[2], norm2[3]}
end

local function initMeshShadowVolume(obj)
	local mdl = LvLK3D.Models[obj.mdl]

	-- get the verts flat
	local finalMesh = {}
	local mdlVerts = mdl.verts
	local mdlUVs = mdl.uvs
	local mdlIndices = mdl.indices
	local mdlNormals = mdl.normals
	local mdlSmoothNormals = mdl.s_normals

	local isSmooth = obj["SHADING_SMOOTH"] == true



	--[[
	   v1      v2
		______
	  /|     /
	 / |    /
	/  |T2 /
   /T1 |  /
  /    | /
 /_____|/
v3      v4
	]]--

	--[[
	For each face
		Calculate face normal
		Create 3 new vertices for this face and face normal
		Insert the face into the draw list
		For each edge of face
			If (edge has been seen before)
				Insert degenerate quad into draw list
				Remove edge from checklist
			Else
				Insert edge into a checklist
		If (any edges are left in checklist)
			flag an error because the geometry is not a closed volume.
	]]--



	local checkList = {}
	local cntCheck = 0
	local degenCount = 0
	local invertCount = 0

	-- gen the new data
	for i = 1, #mdlIndices do
		local indCont = mdlIndices[i]

		local normFlat = mdlNormals[i]
		local v1 = mdlVerts[indCont[1][1]]
		local v2 = mdlVerts[indCont[2][1]]
		local v3 = mdlVerts[indCont[3][1]]

		finalMesh[#finalMesh + 1] = {v1[1], v1[2], v1[3], normFlat[1], normFlat[2], normFlat[3]}
		finalMesh[#finalMesh + 1] = {v2[1], v2[2], v2[3], normFlat[1], normFlat[2], normFlat[3]}
		finalMesh[#finalMesh + 1] = {v3[1], v3[2], v3[3], normFlat[1], normFlat[2], normFlat[3]}

		local edges = {
			{v3, v2, normFlat, false},
			{v2, v3, normFlat, true},

			{v2, v1, normFlat, false},
			{v1, v2, normFlat, true},

			{v1, v3, normFlat, false},
			{v3, v1, normFlat, true}
		}

		for j = 1, #edges do
			local currEdge = edges[j]
			local oursFlip = currEdge[4]

			local e1 = currEdge[1]
			local e2 = currEdge[2]

			local hashCurr = hashEdge(currEdge)
			if checkList[hashCurr] then
				local other = checkList[hashCurr]
				local e3 = other[1]
				local e4 = other[2]
				local normOther = other[3]
				local isFlip = other[4]

				if isFlip then
					invertCount = invertCount + 1
					local _temp = e3
					e3 = e4
					e4 = _temp
				end

				if oursFlip then
					invertCount = invertCount + 1
					local _temp = e1
					e1 = e2
					e2 = _temp
				end


				insertDegenerate(finalMesh, e1, e2, e3, e4, normFlat, normOther)
				checkList[hashCurr] = nil

				cntCheck = cntCheck - 1
				degenCount = degenCount + 1
			else
				cntCheck = cntCheck + 1
				checkList[hashCurr] = currEdge
			end
		end
	end

	print("--==shadows for obj. " .. obj.name .. " ==--")
	print("original tris    : " .. #mdlIndices)
	print("tri count (main) : " .. #finalMesh / 3)
	local mainCount = #finalMesh / 3


	obj.meshShadow = love.graphics.newMesh(vertFormat, finalMesh, "triangles")

	-- caps
	finalMesh = {}
	for i = 1, #mdlIndices do
		local indCont = mdlIndices[i]

		local normFlat = mdlNormals[i]
		local v1 = mdlVerts[indCont[1][1]]
		local v2 = mdlVerts[indCont[2][1]]
		local v3 = mdlVerts[indCont[3][1]]

		finalMesh[#finalMesh + 1] = {v1[1], v1[2], v1[3], normFlat[1], normFlat[2], normFlat[3]}
		finalMesh[#finalMesh + 1] = {v2[1], v2[2], v2[3], normFlat[1], normFlat[2], normFlat[3]}
		finalMesh[#finalMesh + 1] = {v3[1], v3[2], v3[3], normFlat[1], normFlat[2], normFlat[3]}
	end

	obj.meshShadowCaps = love.graphics.newMesh(vertFormat, finalMesh, "triangles")



	print("tri count (caps) : " .. #finalMesh / 3)
	print("final tri count  : " .. mainCount + (#finalMesh / 3))
	print("degenerates      : " .. degenCount)
	print("inverted         : " .. invertCount)


	if cntCheck > 0 then
		print("/!\\ model is non-closed, PANIC! (" .. cntCheck .. " edges left...) /!\\")
	end
end



function LvLK3D.SetObjectShadow(index, shouldCast)
	local obj = LvLK3D.CurrUniv["objects"][index]
	obj.SHADOW_VOLUME = shouldCast

	if shouldCast == true then
		initMeshShadowVolume(obj)
	end
end


LvLK3D.NewShader("shadowvolume", "lvlk3d/shader/mesh/shadowvolume.frag", "lvlk3d/shader/mesh/shadowvolume.vert", function(obj, shader)
	shader:send("mdlRotationMatrix", obj.mat_rot)
	shader:send("mdlTranslationMatrix", obj.mat_trs)
	shader:send("mdlScaleMatrix", obj.mat_scl)

	--shader:send("mdlMatrix", obj.mat_mdl)
	shader:send("viewMatrix", LvLK3D.CamMatrix_Rot * LvLK3D.CamMatrix_Trans)
	shader:send("projectionMatrix", LvLK3D.CamMatrix_Proj)

	shader:send("normInvert", (obj["SHADOW_INVERT"] == true) and true or false)
	--shader:send("isCap", (obj["_shadowCap"] == true) and true or false)

	shader:send("lightPos", obj.SHADOW_LIGHT_POS)
end)

LvLK3D.NewShader("shadowcap", "lvlk3d/shader/mesh/shadowcap.frag", "lvlk3d/shader/mesh/shadowcap.vert", function(obj, shader)
	shader:send("mdlRotationMatrix", obj.mat_rot)
	shader:send("mdlTranslationMatrix", obj.mat_trs)
	shader:send("mdlScaleMatrix", obj.mat_scl)

	--shader:send("mdlMatrix", obj.mat_mdl)
	shader:send("viewMatrix", LvLK3D.CamMatrix_Rot * LvLK3D.CamMatrix_Trans)
	shader:send("projectionMatrix", LvLK3D.CamMatrix_Proj)

	shader:send("normInvert", (obj["SHADOW_INVERT"] == true) and true or false)
	if shader:hasUniform("capFlip") then
		shader:send("capFlip", (obj["CAP_FLIP"] == true) and true or false)
	end

	shader:send("lightPos", obj.SHADOW_LIGHT_POS)
end)


LvLK3D.NewShader("shadowvolumesun", "lvlk3d/shader/mesh/shadowvolume.frag", "lvlk3d/shader/mesh/shadowvolumesun.vert", function(obj, shader)
	shader:send("mdlRotationMatrix", obj.mat_rot)
	shader:send("mdlTranslationMatrix", obj.mat_trs)
	shader:send("mdlScaleMatrix", obj.mat_scl)

	--shader:send("mdlMatrix", obj.mat_mdl)
	shader:send("viewMatrix", LvLK3D.CamMatrix_Rot * LvLK3D.CamMatrix_Trans)
	shader:send("projectionMatrix", LvLK3D.CamMatrix_Proj)

	shader:send("normInvert", (obj["SHADOW_INVERT"] == true) and true or false)
	if shader:hasUniform("capFlip") then
		shader:send("capFlip", (obj["CAP_FLIP"] == true) and true or false)
	end

	shader:send("lightDir", obj.SHADOW_LIGHT_POS)
end)

LvLK3D.NewShader("shadowcapsun", "lvlk3d/shader/mesh/shadowcap.frag", "lvlk3d/shader/mesh/shadowcapsun.vert", function(obj, shader)
	shader:send("mdlRotationMatrix", obj.mat_rot)
	shader:send("mdlTranslationMatrix", obj.mat_trs)
	shader:send("mdlScaleMatrix", obj.mat_scl)

	--shader:send("mdlMatrix", obj.mat_mdl)
	shader:send("viewMatrix", LvLK3D.CamMatrix_Rot * LvLK3D.CamMatrix_Trans)
	shader:send("projectionMatrix", LvLK3D.CamMatrix_Proj)

	shader:send("normInvert", (obj["SHADOW_INVERT"] == true) and true or false)
	if shader:hasUniform("capFlip") then
		shader:send("capFlip", (obj["CAP_FLIP"] == true) and true or false)
	end

	shader:send("lightDir", obj.SHADOW_LIGHT_POS)
end)