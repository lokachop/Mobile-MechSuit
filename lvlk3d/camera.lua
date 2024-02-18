LvLK3D = LvLK3D or {}

LvLK3D.CamPos = Vector(0, 0, 0)
LvLK3D.CamAng = Angle(0, 0, 0)


LvLK3D.FOV = 90


LvLK3D.CamMatrix_Rot = LMAT.Matrix()
LvLK3D.CamMatrix_Trans = LMAT.Matrix()
LvLK3D.CamMatrix_Proj = LMAT.Matrix()

--[[
function LvLK3D.BuildProjectionMatrix(aspect, near, far)
	LvLK3D.CamMatrix_Proj:Identity()

	local scale = 1 / math.tan(math.rad(LvLK3D.FOV * 0.5))
	LvLK3D.CamMatrix_Proj[ 1] = scale / aspect
	LvLK3D.CamMatrix_Proj[ 6] = scale
	LvLK3D.CamMatrix_Proj[11] = far / (far - near)
	LvLK3D.CamMatrix_Proj[12] = far * near / (far - near)
	LvLK3D.CamMatrix_Proj[15] = 1
	LvLK3D.CamMatrix_Proj[16] = 0
end
]]--


function LvLK3D.BuildProjectionMatrix(aspectRatio, near, far)
	local top = near * math.tan(math.rad(LvLK3D.FOV * 0.5))
	local bottom = -1 * top
	local right = top * aspectRatio
	local left = -1 * right

	local _projMatrix = LvLK3D.CamMatrix_Proj

	_projMatrix[1],  _projMatrix[2],  _projMatrix[3],  _projMatrix[4]  = 2*near/(right-left), 0, (right+left)/(right-left), 0
	_projMatrix[5],  _projMatrix[6],  _projMatrix[7],  _projMatrix[8]  = 0, 2*near/(top-bottom), (top+bottom)/(top-bottom), 0
	_projMatrix[9],  _projMatrix[10], _projMatrix[11], _projMatrix[12] = 0, 0, -1*(far+near)/(far-near), -2*far*near/(far-near)
	_projMatrix[13], _projMatrix[14], _projMatrix[15], _projMatrix[16] = 0, 0, -1, 0
end




function LvLK3D.SetCamPos(pos)
	LvLK3D.CamPos = pos or LvLK3D.CamPos

	LvLK3D.CamMatrix_Trans:SetTranslation(-LvLK3D.CamPos)
end

function LvLK3D.SetCamAng(ang)
	LvLK3D.CamAng = ang or LvLK3D.CamAng

	LvLK3D.CamMatrix_Rot:SetAngles(LvLK3D.CamAng)
end

function LvLK3D.SetCamPosAng(pos, ang)
	LvLK3D.CamPos = pos or LvLK3D.CamPos
	LvLK3D.CamAng = ang or LvLK3D.CamAng

	LvLK3D.CamMatrix_Rot:SetAngles(LvLK3D.CamAng)
	LvLK3D.CamMatrix_Trans:SetTranslation(-LvLK3D.CamPos)
end

function LvLK3D.RotateCam(ang)
	local matRot = Matrix()
	matRot:SetAngles(ang)

	LvLK3D.CamMatrix_Rot = matRot * LvLK3D.CamMatrix_Rot

	LvLK3D.CamAng = LvLK3D.CamMatrix_Rot:GetAngles()
end

function LvLK3D.NoclipCam(dt)

	local dtMul = dt
	if love.keyboard.isDown("lshift") then
		dtMul = dt * 4
	end

	local fow = LvLK3D.CamMatrix_Rot:Forward()
	fow:Mul(dtMul)

	local rig = LvLK3D.CamMatrix_Rot:Right()
	rig:Mul(dtMul)

	local up = LvLK3D.CamMatrix_Rot:Up()
	up:Mul(dtMul)

	if love.keyboard.isDown("w") then
		LvLK3D.SetCamPos(LvLK3D.CamPos + fow)
	end

	if love.keyboard.isDown("s") then
		LvLK3D.SetCamPos(LvLK3D.CamPos - fow)
	end

	if love.keyboard.isDown("a") then
		LvLK3D.SetCamPos(LvLK3D.CamPos + rig)
	end

	if love.keyboard.isDown("d") then
		LvLK3D.SetCamPos(LvLK3D.CamPos - rig)
	end

	if love.keyboard.isDown("space") then
		LvLK3D.SetCamPos(LvLK3D.CamPos + up)
	end

	if love.keyboard.isDown("lctrl") then
		LvLK3D.SetCamPos(LvLK3D.CamPos - up)
	end


	--print(LvLK3D.CamMatrix_Rot:GetAngles(), LvLK3D.CamAng)

	if love.keyboard.isDown("left") then
		LvLK3D.RotateCam(Angle(0, -128 * dt, 0))
	end

	if love.keyboard.isDown("right") then
		LvLK3D.RotateCam(Angle(0, 128 * dt, 0))
	end

	if love.keyboard.isDown("up") then
		LvLK3D.RotateCam(Angle(128 * dt, 0, 0))
	end

	if love.keyboard.isDown("down") then
		LvLK3D.RotateCam(Angle(-128 * dt, 0, 0))
	end

	if love.keyboard.isDown("q") then
		LvLK3D.RotateCam(Angle(0, 0, -128 * dt))
	end

	if love.keyboard.isDown("e") then
		LvLK3D.RotateCam(Angle(0, 0, 128 * dt))
	end

	--[[
	if love.keyboard.isDown("left") then
		LvLK3D.SetCamAng(Vector(
			LvLK3D.CamAng[1],
			(LvLK3D.CamAng[2] - 128 * dt) % 360,
			LvLK3D.CamAng[3]
		))
	end

	if love.keyboard.isDown("right") then
		LvLK3D.SetCamAng(Vector(
			LvLK3D.CamAng[1],
			(LvLK3D.CamAng[2] + 128 * dt) % 360,
			LvLK3D.CamAng[3]
		))
	end

	if love.keyboard.isDown("up") then
		LvLK3D.SetCamAng(Vector(
			(LvLK3D.CamAng[1] + 128 * dt) % 360,
			LvLK3D.CamAng[2],
			LvLK3D.CamAng[3]
		))
	end

	if love.keyboard.isDown("down") then
		LvLK3D.SetCamAng(Vector(
			(LvLK3D.CamAng[1] - 128 * dt) % 360,
			LvLK3D.CamAng[2],
			LvLK3D.CamAng[3]
		))
	end


	if love.keyboard.isDown("q") then
		LvLK3D.SetCamAng(Vector(
			LvLK3D.CamAng[1],
			LvLK3D.CamAng[2],
			(LvLK3D.CamAng[3] - 128 * dt) % 360
		))
	end

	if love.keyboard.isDown("e") then
		LvLK3D.SetCamAng(Vector(
			LvLK3D.CamAng[1],
			LvLK3D.CamAng[2],
			(LvLK3D.CamAng[3] + 128 * dt) % 360
		))
	end
	]]--
end

if not love then
	return
end

function LvLK3D.ToggleMouseLock(key)
	if key == "tab" then
		LvLK3D.CamInputLock = not love.mouse.isGrabbed()
		love.mouse.setGrabbed(LvLK3D.CamInputLock)
		love.mouse.setRelativeMode(LvLK3D.CamInputLock)
	end
end

LvLK3D.CamInputLock = false
LvLK3D.CamVel = Vector(0, 0, 0)
function LvLK3D.MouseCamThink(dt)
	local vmul = 0.1
	if love.keyboard.isDown("lshift") then
		vmul = 1
	end

	local fow = LvLK3D.CamMatrix_Rot:Forward()
	fow:Mul(vmul)

	local rig = LvLK3D.CamMatrix_Rot:Right()
	rig:Mul(vmul)

	local up = LvLK3D.CamMatrix_Rot:Up()
	up:Mul(vmul)

	if love.keyboard.isDown("w") then
		LvLK3D.CamVel = LvLK3D.CamVel + fow
	end

	if love.keyboard.isDown("s") then
		LvLK3D.CamVel = LvLK3D.CamVel - fow
	end

	if love.keyboard.isDown("a") then
		LvLK3D.CamVel = LvLK3D.CamVel - rig
	end

	if love.keyboard.isDown("d") then
		LvLK3D.CamVel = LvLK3D.CamVel + rig
	end

	if love.keyboard.isDown("space") then
		LvLK3D.CamVel = LvLK3D.CamVel + up
	end

	if love.keyboard.isDown("lctrl") then
		LvLK3D.CamVel = LvLK3D.CamVel - up
	end

	if love.keyboard.isDown("q") then
		LvLK3D.RotateCam(Angle(0, 0, 128 * dt))
	end

	if love.keyboard.isDown("e") then
		LvLK3D.RotateCam(Angle(0, 0, -128 * dt))
	end

	LvLK3D.SetCamPos(LvLK3D.CamPos + LvLK3D.CamVel * dt)
	LvLK3D.CamVel = LvLK3D.CamVel / 1.1
end

function LvLK3D.MouseCamUpdate(mx, my)
	if not LvLK3D.CamInputLock then
		return
	end

	local mxReal = -mx / 2
	local myReal = -my / 2

	LvLK3D.RotateCam(Angle(myReal, mxReal, 0))
end