LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LoveJam.CameraAng = Angle(0, 0, 0)



function LoveJam.KillPlayer()
	LoveJam.SetState(STATE_DEATH)
end

function LoveJam.KillPlayerFall()
	LoveJam.SetState(STATE_DEATH)
end

function LoveJam.BeginLevel(name)
	LoveJam.LoadLevel(name)
end


function LoveJam.SwitchToNextLevel()
	local levelData = LoveJam.GetCurrentLevelData()
	local nextLevel = levelData.nextLevel
	if not nextLevel or nextLevel == "none" then
		-- CREDITS TODO
		return
	end


	LoveJam.BeginLevel(nextLevel)
end