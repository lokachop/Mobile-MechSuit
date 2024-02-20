LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}

local levelData = {
	name = "none",
	gW = 0,
	gH = 0,
	deco = {
		[1] = {
			pos = Vector(4, 1, 0),
			ang =  Angle(0, 0, 0),
			scl = Vector(1, 1, 1),
			mat = "metal2",
			mdl = "push_box",
		},
		[2] = {
			pos = Vector(0, 0, 0),
			ang =  Angle(0, 0, 0),
			scl = Vector(1, 1, 1),
			mat = "metal3",
			mdl = "push_box",
		},
	},
	lights = {
		[1] = {
			pos = Vector(0, 4, 0),
			int = 4,
			col = Vector(1, 1, 1),
		},
		[2] = {
			pos = Vector(2, 6, 4),
			int = 4,
			col = Vector(0, 0, 1),
		},
	},
}