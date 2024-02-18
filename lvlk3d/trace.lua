LvLK3D = LvLK3D or {}
local ffi = require("ffi")
-- trace module for LvLK3D
-- hopefully uses FFI to make it fast
local tracelib = ffi.load("lvlk3d/ffi/tracelib.so")
ffi.cdef([[
	typedef struct Vector {
		float x;
		float y;
		float z;
	} Vector;

	typedef struct Matrix4x4 {
		float m_0_0;
		float m_1_0;
		float m_2_0;
		float m_3_0;
	
		float m_0_1;
		float m_1_1;
		float m_2_1;
		float m_3_1;
	
		float m_0_2;
		float m_1_2;
		float m_2_2;
		float m_3_2;
	
		float m_0_3;
		float m_1_3;
		float m_2_3;
		float m_3_3;
	} Matrix4x4;

	typedef struct TraceResult {
		bool hit;
		float dist;
		Vector pos;
	} TraceResult;

	typedef struct TraceResultObject {
		bool hit;
		float dist;
		Vector pos;
		Vector normal;
	} TraceResultObject;
	
	typedef struct UV {
		float u;
		float v;
	} UV;
	
	typedef struct Face {
		unsigned long v1i;
		unsigned long v2i;
		unsigned long v3i;
	
		unsigned long v1ui;
		unsigned long v2ui;
		unsigned long v3ui;
	} Face;
	
	typedef struct Model {
		unsigned long vertCount;
		unsigned long faceCount;
	
		Vector 	vertList[8192];
		UV 		uvList[8192];

		Vector 	normalList[16384];
		Face 	faceList[16384];
	} Model;

	
	void declare_model(unsigned int index, unsigned long vertCount, unsigned long uvCount, unsigned long faceCount);

	void model_push_vertex(unsigned int index, unsigned int vertIndex, Vector vertex);
	void model_push_uv(unsigned int index, unsigned int uvIndex, UV uv);
	void model_push_normal(unsigned int index, unsigned int normIndex, Vector normal);
	void model_push_face(unsigned int index, unsigned int faceIndex, Face face);

	TraceResult rayIntersectsTriangle(Vector rayPos, Vector rayDir, Vector v1, Vector v2, Vector v3, bool backface_cull);
	TraceResultObject rayIntersectsModel(Vector rayPos, Vector rayDir, Matrix4x4 mdlMatrix, unsigned int mdlIndex, bool backface_cull, float minDistIn, bool normInvert);
]])
local ModelNameLUT = {}
local ModelIDLUT = {}

local function nameToCIndex(name)
	return ModelIDLUT[name]
end

local lastID = 0
local function pushModelToC(name)
	local mdlData = LvLK3D.Models[name]
	if not mdlData then
		print("No model \"" .. name .. "\"")
		return
	end


	print("Sending model \"" .. name .. "\" to C!")

	ModelNameLUT[lastID] = name
	ModelIDLUT[name] = lastID


	local vertCount = #mdlData.verts
	local uvCount = #mdlData.uvs
	local idxCount = #mdlData.indices

	print("     ID: " .. lastID)
	print("  Verts: " .. vertCount)
	print("Indices: " .. idxCount)


	tracelib.declare_model(lastID, vertCount, uvCount, idxCount)

	-- Vertices
	local verts = mdlData.verts
	for i = 1, vertCount do
		local vert = verts[i]:Copy()

		local vSend = ffi.new("Vector")
		vSend.x = vert[1]
		vSend.y = vert[2]
		vSend.z = vert[3]
		tracelib.model_push_vertex(lastID, i - 1, vSend)
	end

	-- UVs
	local uvs = mdlData.uvs
	for i = 1, uvCount do
		local uv = uvs[i]

		local uvSend = ffi.new("UV")
		uvSend.u = uv[1]
		uvSend.v = uv[2]

		tracelib.model_push_uv(lastID, i - 1, uvSend)
	end

	-- Normals
	local normals = mdlData.normals
	for i = 1, idxCount do
		local norm = normals[i]:Copy()

		local vSend = ffi.new("Vector")
		vSend.x = norm[1]
		vSend.y = norm[2]
		vSend.z = norm[3]


		tracelib.model_push_normal(lastID, i - 1, vSend)
	end

	-- Indices / Faces
	local indices = mdlData.indices
	for i = 1, idxCount do
		local idx = indices[i]

		local fSend = ffi.new("Face")
		fSend.v1i = idx[1][1] - 1
		fSend.v2i = idx[2][1] - 1
		fSend.v3i = idx[3][1] - 1

		fSend.v1ui = idx[1][2] - 1
		fSend.v2ui = idx[2][2] - 1
		fSend.v3ui = idx[3][2] - 1

		tracelib.model_push_face(lastID, i - 1, fSend)
	end


	--[[
	typedef struct Face {
		unsigned long v1i;
		unsigned long v2i;
		unsigned long v3i;
	
		unsigned long v1ui;
		unsigned long v2ui;
		unsigned long v3ui;
	} Face;
	]]

	lastID = lastID + 1
end


for k, v in pairs(LvLK3D.Models) do
	pushModelToC(k)
end

local function lmat2c(matrix)
	local matOut = ffi.new("Matrix4x4")

	matOut.m_0_0 = matrix[ 1]
	matOut.m_1_0 = matrix[ 2]
	matOut.m_2_0 = matrix[ 3]
	matOut.m_3_0 = matrix[ 4]

	matOut.m_0_1 = matrix[ 5]
	matOut.m_1_1 = matrix[ 6]
	matOut.m_2_1 = matrix[ 7]
	matOut.m_3_1 = matrix[ 8]

	matOut.m_0_2 = matrix[ 9]
	matOut.m_1_2 = matrix[10]
	matOut.m_2_2 = matrix[11]
	matOut.m_3_2 = matrix[12]

	matOut.m_0_3 = matrix[13]
	matOut.m_1_3 = matrix[14]
	matOut.m_2_3 = matrix[15]
	matOut.m_3_3 = matrix[16]

	return matOut
end


local _trace_bf_cull = true
local function traceObjC(obj, ro, rd, minDist)
	local cIdx = nameToCIndex(obj.mdl)


	local cMatrix = lmat2c(obj.mat_mdl)


	local vecRO = ffi.new("Vector")
	vecRO.x = ro[1]
	vecRO.y = ro[2]
	vecRO.z = ro[3]

	local vecRD = ffi.new("Vector")
	vecRD.x = rd[1]
	vecRD.y = rd[2]
	vecRD.z = rd[3]

	local traceResult = tracelib.rayIntersectsModel(vecRO, vecRD, cMatrix, cIdx, _trace_bf_cull, minDist or math.huge, obj["NORM_INVERT"] and true or false)

	local posVec = Vector(0, 0, 0)
	local normVec = Vector(0, 0, 0)
	if traceResult.hit then
		local posC = traceResult.pos
		posVec = Vector(posC.x or 0, posC.y or 0, posC.z or 0)

		local normC = traceResult.normal
		normVec = Vector(normC.x or 0, normC.y or 0, normC.z or 0)
	end

	return traceResult.hit, posVec, traceResult.dist, normVec
end


local function traceTriangleC(ro, rd, v1, v2, v3)
	local traceResult = tracelib.rayIntersectsTriangle(ro, rd, v1, v2, v3, _trace_bf_cull)

	return traceResult.hit, traceResult.pos, traceResult.dist
end


local function traceObj(obj, ro, rd, minDist)
	return traceObjC(obj, ro, rd, minDist)
end

local _MAX_OBJECTS = LvLK3D.MAX_OBJECTS * 1

function LvLK3D.TraceRay(ro, rd, maxDist)
	local min_dist = maxDist or math.huge
	local ret_hit = false
	local ret_pos = (ro + (rd * maxDist))
	local ret_norm = rd
	local ret_obj = nil

	for i = 1, _MAX_OBJECTS do
		local obj = LvLK3D.CurrUniv["objects"][i]

		if not obj then
			goto _contTraceScene
		end

		if obj["NO_TRACE"] then
			goto _contTraceScene
		end

		local hit, pos, dist, norm = traceObj(obj, ro, rd, maxDist)
		if hit and dist < min_dist then
			ret_hit = true
			ret_pos = pos
			ret_dist = dist
			ret_norm = norm

			min_dist = dist
			ret_obj = obj
		end


		::_contTraceScene::
	end

	return ret_hit, ret_pos, ret_norm, min_dist, ret_obj
end






local function traceObj_OLD(obj, ro, rd, minDist)
	--[[
	local obj = LvLK3D.CurrUniv["objects"][objName]
	if not obj then
		return
	end
	]]--

	local vecRO = ffi.new("Vector")
	vecRO.x = ro[1]
	vecRO.y = ro[2]
	vecRO.z = ro[3]

	local vecRD = ffi.new("Vector")
	vecRD.x = rd[1]
	vecRD.y = rd[2]
	vecRD.z = rd[3]


	local objMatrix = obj.mat_mdl

	local mdl = LvLK3D.Models[obj.mdl]

	local mdlVerts = mdl.verts
	--local mdlUVs = mdl.uvs
	local mdlIndices = mdl.indices
	local mdlNormals = mdl.normals


	local obj_v1 = ffi.new("Vector")
	local obj_v2 = ffi.new("Vector")
	local obj_v3 = ffi.new("Vector")


	local hit_out = false
	local pos_out = Vector(0, 0, 0)
	local norm_out = rd
	local dist_out_least = minDist or math.huge


	--local _posPers = ffi.new("Vector")
	for i = 1, #mdlIndices do
		local indCont = mdlIndices[i]
		local normFlat = mdlNormals[i]:Copy()


		local v1 = mdlVerts[indCont[1][1]]:Copy()
		local v2 = mdlVerts[indCont[2][1]]:Copy()
		local v3 = mdlVerts[indCont[3][1]]:Copy()

		v1 = v1 * objMatrix
		v2 = v2 * objMatrix
		v3 = v3 * objMatrix


		normFlat:Rotate(obj.ang)

		if (obj["NORM_INVERT"] == true) then
			normFlat = -normFlat
		end


		-- convert the vertices to the cpp format
		if (obj["NORM_INVERT"] == true) then
			obj_v1.x = v3[1]
			obj_v1.y = v3[2]
			obj_v1.z = v3[3]

			obj_v2.x = v2[1]
			obj_v2.y = v2[2]
			obj_v2.z = v2[3]

			obj_v3.x = v1[1]
			obj_v3.y = v1[2]
			obj_v3.z = v1[3]
		else
			obj_v1.x = v1[1]
			obj_v1.y = v1[2]
			obj_v1.z = v1[3]

			obj_v2.x = v2[1]
			obj_v2.y = v2[2]
			obj_v2.z = v2[3]

			obj_v3.x = v3[1]
			obj_v3.y = v3[2]
			obj_v3.z = v3[3]
		end

		local hit, pos, dist = traceTriangleC(vecRO, vecRD, obj_v1, obj_v2, obj_v3)
		if hit and (dist < dist_out_least) then
			--print(hit, pos.x, pos.y, pos.z, dist)
			hit_out = true
			--_posPers = pos
			pos_out = Vector(pos.x, pos.y, pos.z)

			norm_out = normFlat
			dist_out_least = dist
		end
	end
	--print(_posPers.x, _posPers.y, _posPers.z)
	--pos_out = Vector(_posPers.x, _posPers.y, _posPers.z)

	return hit_out, pos_out, dist_out_least, norm_out
end

