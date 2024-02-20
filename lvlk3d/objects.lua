LvLK3D = LvLK3D or {}

local vertFormat = {
	{"VertexPosition", "float", 3},
	{"VertexTexCoord", "float", 2},
	{"VertexNormal", "float", 3},
	--{"VCol", "byte", 4},
}


local function initMesh(obj)
	local mdl = LvLK3D.Models[obj.mdl]

	-- get the verts flat
	local finalMesh = {}
	local mdlVerts = mdl.verts
	local mdlUVs = mdl.uvs
	local mdlIndices = mdl.indices
	local mdlNormals = mdl.normals
	local mdlSmoothNormals = mdl.s_normals


	local isSmooth = obj["SHADING_SMOOTH"] == true
	for i = 1, #mdlIndices do
		local indCont = mdlIndices[i]

		local normFlat = mdlNormals[i]



		local v1 = mdlVerts[indCont[1][1]]
		local uv1 = mdlUVs[indCont[1][2]]
		local norm1 = isSmooth and mdlSmoothNormals[indCont[1][1]] or normFlat

		local v2 = mdlVerts[indCont[2][1]]
		local uv2 = mdlUVs[indCont[2][2]]
		local norm2 = isSmooth and mdlSmoothNormals[indCont[2][1]] or normFlat

		local v3 = mdlVerts[indCont[3][1]]
		local uv3 = mdlUVs[indCont[3][2]]
		local norm3 = isSmooth and mdlSmoothNormals[indCont[3][1]] or normFlat

		if (obj["NORM_INVERT"] == true) then
			norm1 = -norm1
			norm2 = -norm2
			norm3 = -norm3
		end


		finalMesh[#finalMesh + 1] = {v1[1], v1[2], v1[3], uv1[1], uv1[2], norm1[1], norm1[2], norm1[3]}
		finalMesh[#finalMesh + 1] = {v2[1], v2[2], v2[3], uv2[1], uv2[2], norm2[1], norm2[2], norm2[3]}
		finalMesh[#finalMesh + 1] = {v3[1], v3[2], v3[3], uv3[1], uv3[2], norm3[1], norm3[2], norm3[3]}
	end


	obj.mesh = love.graphics.newMesh(vertFormat, finalMesh, "triangles")
	obj.mesh:setTexture(LvLK3D.Textures[obj.mat])
end

function LvLK3D.AddObjectToUniv(name, mdl)
	local mat_rot = Matrix()
	mat_rot:SetAngles(Angle(0, 0, 0))

	local mat_trs = Matrix()
	mat_trs:Identity()

	local mat_scl = Matrix()
	mat_scl:SetScale(Vector(1, 1, 1))

	local mat_mdl = Matrix()
	mat_mdl:Identity()

	local objs = LvLK3D.CurrUniv["objects"]
	local index = #objs + 1

	LvLK3D.CurrUniv["objectIDLUT"][name] = index


	objs[index] = {
		name = name,
		mdl = mdl,
		pos = Vector(0, 0, 0),
		ang = Angle(0, 0, 0),
		scl = Vector(1, 1, 1),
		col = {1, 1, 1},
		mat = "none",
		mat_rot = mat_rot,
		mat_trs = mat_trs,
		mat_scl = mat_scl,
		mat_mdl = mat_mdl,
		shader = "base",
	}

	--[[
	local obj = LvLK3D.CurrUniv["objects"][name]
	setupModelMatrix(obj.mat_mdl, obj.pos, obj.ang, obj.scl)
	]]--

	initMesh(LvLK3D.CurrUniv["objects"][index])

	LvLK3D.CurrUniv["objectCount"] = LvLK3D.CurrUniv["objectCount"] + 1

	return index
end

local function recalculateObjectMatrices(obj)
	obj.mat_mdl = obj.mat_trs * obj.mat_rot * obj.mat_scl
end

-- DONT USE THIS, INTERNAL
function LvLK3D.__recalculateObjectMatrices(index)
	recalculateObjectMatrices(LvLK3D.CurrUniv["objects"][index])
end

function LvLK3D.SetObjectPos(index, pos)
	local obj = LvLK3D.CurrUniv["objects"][index]

	obj.pos = pos or Vector(0, 0, 0)

	obj.mat_trs:SetTranslation(pos)

	recalculateObjectMatrices(obj)
end

function LvLK3D.SetObjectAng(index, ang)
	local obj = LvLK3D.CurrUniv["objects"][index]

	obj.ang = ang or Angle(0, 0, 0)

	obj.mat_rot:SetAngles(ang)
	recalculateObjectMatrices(obj)
	---mat_mdl
end

function LvLK3D.SetObjectPosAng(index, pos, ang)
	local obj = LvLK3D.CurrUniv["objects"][index]

	obj.pos = pos or Vector(0, 0, 0)
	obj.ang = ang or Angle(0, 0, 0)

	obj.mat_trs:SetTranslation(pos)
	obj.mat_rot:SetAngles(ang)

	recalculateObjectMatrices(obj)
end

function LvLK3D.SetObjectScl(index, scl)
	local obj = LvLK3D.CurrUniv["objects"][index]

	obj.scl = scl or Vector(0, 0, 0)
	obj.mat_scl:SetScale(scl)

	recalculateObjectMatrices(obj)
end

function LvLK3D.SetObjectCol(index, col)
	LvLK3D.CurrUniv["objects"][index].col = col and {col[1], col[2], col[3]} or {1, 1, 1}
end

function LvLK3D.SetObjectMat(index, mat)
	local obj = LvLK3D.CurrUniv["objects"][index]

	obj.mat = mat or "none"
	obj.mesh:setTexture(LvLK3D.Textures[obj.mat])
end

function LvLK3D.SetObjectShader(index, shader)
	local obj = LvLK3D.CurrUniv["objects"][index]

	if not shader then
		obj.cShader = nil
		return
	end


	local shObj = LvLK3D.GetShader(shader)
	if not shObj then
		return
	end

	obj.cShader = shader
end

function LvLK3D.SetObjectBlend(index, blendMode)
	local obj = LvLK3D.CurrUniv["objects"][index]
	obj.bMode = blendMode
end

function LvLK3D.SetObjectFlag(index, flag, value)
	LvLK3D.CurrUniv["objects"][index][flag] = value
end

function LvLK3D.SetObjectModel(index, mdl)
	local obj = LvLK3D.CurrUniv["objects"][index]

	obj.mdl = mdl or "cube"
end


function LvLK3D.UpdateObjectMesh(index)
	initMesh(LvLK3D.CurrUniv["objects"][index])
end

function LvLK3D.GetObjectByName(name)
	return LvLK3D.CurrUniv["objectIDLUT"][name]
end

function LvLK3D.RemoveObjectFromUniv(index)
	LvLK3D.CurrUniv["objectIDLUT"][LvLK3D.CurrUniv["objects"][index].name] = nil
	LvLK3D.CurrUniv["objects"][index] = nil
	LvLK3D.CurrUniv["objectCount"] = LvLK3D.CurrUniv["objectCount"] - 1
end