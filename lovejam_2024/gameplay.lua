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
		LoveJam.SetState(STATE_CREDITS)
		return
	end


	LoveJam.BeginLevel(nextLevel)
	LoveJam.SetState(STATE_GAME)
end