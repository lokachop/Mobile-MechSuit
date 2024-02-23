LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
local levelData = {
	name = "level1",
	nextLevel = "level2",
	isNoVis = false,
	gW = 0,
	gH = 0,
	gOX = 0,
	gOY = 0,
	deco = {
		[1] = {
			pos = Vector(-14, 9, -12),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 3, 2),
			mat = "metal2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 3,
		},
		[2] = {
			pos = Vector(-8, 7.1, -18),
			ang =  Angle(0, 22.5, 0),
			scl = Vector(2, 1.5, 2),
			mat = "barrel_sheet",
			mdl = "barrel",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[3] = {
			pos = Vector(-8, 3, -20),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 3, 6),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 3,
		},
		[4] = {
			pos = Vector(28, 6, -22),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 4),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 6,
		},
		[5] = {
			pos = Vector(-5, 6, -28),
			ang =  Angle(0, 0, 0),
			scl = Vector(19, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 19,
			uvScaleY = 6,
		},
		[6] = {
			pos = Vector(16, 0, -22),
			ang =  Angle(0, 0, 0),
			scl = Vector(10, 1, 4),
			mat = "grate2",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 10,
			uvScaleY = 4,
		},
		[7] = {
			pos = Vector(18, 6, -16),
			ang =  Angle(0, 0, 0),
			scl = Vector(8, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 8,
			uvScaleY = 6,
		},
		[8] = {
			pos = Vector(20, 9, -32),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 3, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 3,
		},
		[9] = {
			pos = Vector(8, 6, -16),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 6,
		},
		[10] = {
			pos = Vector(-8, 7.1, -20),
			ang =  Angle(0, 337.5, 0),
			scl = Vector(2, 1.5, 2),
			mat = "barrel_sheet",
			mdl = "barrel",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[11] = {
			pos = Vector(0, 6, 8),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 6,
		},
		[12] = {
			pos = Vector(8, 6, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 10),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 10,
			uvScaleY = 6,
		},
		[13] = {
			pos = Vector(-8, 6, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 10),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 10,
			uvScaleY = 6,
		},
		[14] = {
			pos = Vector(-8, 9, -15.5),
			ang =  Angle(0, 0, 0),
			scl = Vector(0.5, 3, 1.5),
			mat = "metal3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1.5,
			uvScaleY = 3,
		},
		[15] = {
			pos = Vector(20, 3, -36),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 3, 0.5),
			mat = "metal3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 3,
		},
		[16] = {
			pos = Vector(4, 12, -10),
			ang =  Angle(180, 0, 0),
			scl = Vector(26, 1, 20),
			mat = "metal4",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 26,
			uvScaleY = 20,
		},
		[17] = {
			pos = Vector(0, 0, -10),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 1, 16),
			mat = "grate2",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 16,
		},
		[18] = {
			pos = Vector(20, 0, -32),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 1, 6),
			mat = "grate1",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 6,
		},
		[19] = {
			pos = Vector(24, 3, -32),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 3, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 3,
		},
		[20] = {
			pos = Vector(16, 3, -32),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 3, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 3,
		},
		[21] = {
			pos = Vector(-20, 9, -20),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 3, 6),
			mat = "metal2",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 3,
		},
	},
	lights = {
		[1] = {
			pos = Vector(20, 5, -34.5),
			int = 3,
			col = Vector(255, 24, 16),
		},
		[2] = {
			pos = Vector(0, 10, 0),
			int = 4,
			col = Vector(255, 196, 127),
		},
		[3] = {
			pos = Vector(-12, 10, -18),
			int = 6,
			col = Vector(96, 128, 255),
		},
		[4] = {
			pos = Vector(14, 10, -22),
			int = 1.5,
			col = Vector(255, 196, 128),
		},
	},
	tiles = {
		[0] = {[0] = 4, [1] = 1, [2] = 2, [-2] = 1, [-5] = 1, [-3] = 1, [-7] = 2, [-4] = 1, [-1] = 1, [-6] = 1, },
		[1] = {[0] = 1, [1] = 1, [2] = 2, [-2] = 1, [-5] = 1, [-3] = 1, [-7] = 2, [-1] = 1, [-4] = 1, [-6] = 1, },
		[2] = {[0] = 2, [1] = 2, [-2] = 2, [-5] = 1, [-3] = 2, [-7] = 2, [-4] = 2, [-1] = 2, [-6] = 1, },
		[-2] = {[0] = 2, [1] = 2, [-2] = 2, [-5] = 2, [-3] = 2, [-4] = 2, [-1] = 2, [-6] = 2, },
		[5] = {[-8] = 5, [-5] = 1, [-7] = 1, [-4] = 2, [-6] = 1, [-9] = 1, },
		[4] = {[-8] = 2, [-5] = 1, [-7] = 2, [-4] = 2, [-6] = 1, [-9] = 2, },
		[3] = {[-7] = 2, [-4] = 2, [-5] = 1, [-6] = 1, },
		[7] = {[-5] = 2, [-6] = 2, },
		[-1] = {[0] = 1, [1] = 1, [2] = 2, [-2] = 1, [-5] = 1, [-3] = 1, [-7] = 2, [-4] = 1, [-1] = 1, [-6] = 1, },
		[6] = {[-8] = 2, [-5] = 1, [-7] = 2, [-4] = 2, [-6] = 1, [-9] = 2, },
	},
}

LoveJam.DeclareLevel("level1", levelData)