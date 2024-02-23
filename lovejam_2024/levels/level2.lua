LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
local levelData = {
	name = "level2",
	nextLevel = "level3",
	isNoVis = false,
	gW = 0,
	gH = 0,
	gOX = 0,
	gOY = 0,
	deco = {
		[1] = {
			pos = Vector(4, 6, 8),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 6,
		},
		[2] = {
			pos = Vector(-4, 9, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 3, 6),
			mat = "metal_wall_stack2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 3,
		},
		[3] = {
			pos = Vector(48, 0, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 12, 6),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 12,
		},
		[4] = {
			pos = Vector(24, 6, -18),
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
			pos = Vector(32, 2.5, -24),
			ang =  Angle(0, 22.5, 0),
			scl = Vector(1.75, 2, 1.75),
			mat = "silo_sheet",
			mdl = "silo",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[6] = {
			pos = Vector(0, 0, 8),
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
		[7] = {
			pos = Vector(7, 7.5, -36),
			ang =  Angle(0, 67.5, 0),
			scl = Vector(1.5, 1.5, 1.5),
			mat = "metal2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = false,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[8] = {
			pos = Vector(0, 9, 8),
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
		[9] = {
			pos = Vector(24, 6, -24),
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
			pos = Vector(9, 12, -15),
			ang =  Angle(180, 0, 0),
			scl = Vector(40, 1, 44),
			mat = "metal4",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 40,
			uvScaleY = 44,
		},
		[11] = {
			pos = Vector(-16, 1.25, -32),
			ang =  Angle(0, 22.5, 0),
			scl = Vector(1.5, 1.25, 1.5),
			mat = "metal_wall_stack2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[12] = {
			pos = Vector(20, 9, -42),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 3, 4),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 3,
		},
		[13] = {
			pos = Vector(42, 0, -12),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 12, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 12,
		},
		[14] = {
			pos = Vector(0, 6, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 6,
		},
		[15] = {
			pos = Vector(42, -12, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 6),
			mat = "toxic",
			mdl = "plane",
			fullbright = true,
			shadow = false,
			shaded = false,
			uvScaleX = 4,
			uvScaleY = 6,
		},
		[16] = {
			pos = Vector(16, -1, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(22, 1, 6),
			mat = "grate2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 22,
			uvScaleY = 6,
		},
		[17] = {
			pos = Vector(8, 6, -12),
			ang =  Angle(0, 0, 0),
			scl = Vector(14, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 14,
			uvScaleY = 6,
		},
		[18] = {
			pos = Vector(-4, 3, -44),
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
		[19] = {
			pos = Vector(4, 6, -24),
			ang =  Angle(0, 0, 0),
			scl = Vector(18, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 18,
			uvScaleY = 6,
		},
		[20] = {
			pos = Vector(0, 3, 12),
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
		[21] = {
			pos = Vector(36, 2, -16),
			ang =  Angle(0, 22.5, 0),
			scl = Vector(1.5, 2, 1.5),
			mat = "metal2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[22] = {
			pos = Vector(12, 1.5, -5),
			ang =  Angle(0, 315, 0),
			scl = Vector(2, 2, 2),
			mat = "barrel_sheet",
			mdl = "barrel",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[23] = {
			pos = Vector(-20, -1, -30),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 1, 8),
			mat = "grate1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 5,
			uvScaleY = 8,
		},
		[24] = {
			pos = Vector(-20, 6, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 6, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 5,
			uvScaleY = 6,
		},
		[25] = {
			pos = Vector(10, 3, -36),
			ang =  Angle(0, 0, 0),
			scl = Vector(8, 3, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 8,
			uvScaleY = 3,
		},
		[26] = {
			pos = Vector(8, 0, -28),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 0.1, 2),
			mat = "toxic",
			mdl = "cube",
			fullbright = true,
			shadow = false,
			shaded = false,
			uvScaleX = 2,
			uvScaleY = 2,
		},
		[27] = {
			pos = Vector(-20, 6, -20),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 6, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 5,
			uvScaleY = 6,
		},
		[28] = {
			pos = Vector(-4, 6, 8),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 6,
		},
		[29] = {
			pos = Vector(24, 6, -12),
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
		[30] = {
			pos = Vector(6, -1, -30),
			ang =  Angle(0, 0, 0),
			scl = Vector(20, 1, 4),
			mat = "grate2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 20,
			uvScaleY = 4,
		},
		[31] = {
			pos = Vector(28, 6, -36),
			ang =  Angle(0, 0, 0),
			scl = Vector(10, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 10,
			uvScaleY = 6,
		},
		[32] = {
			pos = Vector(32, 0, -22),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 2, 12),
			mat = "grate2",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 12,
		},
		[33] = {
			pos = Vector(20, 2, -8),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 2, 2),
			mat = "metal3",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[34] = {
			pos = Vector(40, 6, -24),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 10),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 10,
			uvScaleY = 6,
		},
		[35] = {
			pos = Vector(20, 1, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 1, 2),
			mat = "metal2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[36] = {
			pos = Vector(37, -7, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(1, 5, 6),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 5,
		},
		[37] = {
			pos = Vector(42, 0, 4),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 12, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 12,
		},
		[38] = {
			pos = Vector(-28, 6, -30),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 8),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 8,
			uvScaleY = 6,
		},
		[39] = {
			pos = Vector(11, 9, -46),
			ang =  Angle(0, 0, 0),
			scl = Vector(9, 3, 0),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 9,
			uvScaleY = 3,
		},
		[40] = {
			pos = Vector(22, 6, 4),
			ang =  Angle(0, 0, 0),
			scl = Vector(16, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 16,
			uvScaleY = 6,
		},
		[41] = {
			pos = Vector(-10, 6, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 6, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 6,
		},
		[42] = {
			pos = Vector(12.5, 1.5, -3.25),
			ang =  Angle(0, 45, 0),
			scl = Vector(2, 2, 2),
			mat = "barrel_sheet",
			mdl = "barrel",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[43] = {
			pos = Vector(16, 0, -32),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 0.1, 2),
			mat = "toxic",
			mdl = "cube",
			fullbright = true,
			shadow = false,
			shaded = false,
			uvScaleX = 2,
			uvScaleY = 2,
		},
		[44] = {
			pos = Vector(-8, 6, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 6,
		},
		[45] = {
			pos = Vector(-4, 0, -40),
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
		[46] = {
			pos = Vector(0, 3, -9.75),
			ang =  Angle(270, 0, 0),
			scl = Vector(1, 1, 1),
			mat = "sign4",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = -1,
		},
		[47] = {
			pos = Vector(22, 3, -33.75),
			ang =  Angle(270, 0, 0),
			scl = Vector(1, 1, 1),
			mat = "sign1",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = -1,
		},
	},
	lights = {
		[1] = {
			pos = Vector(16, 0.5, -32),
			int = 4,
			col = Vector(96, 255, 64),
		},
		[2] = {
			pos = Vector(0, 10, -4),
			int = 4,
			col = Vector(255, 196, 128),
		},
		[3] = {
			pos = Vector(42, -8, -4),
			int = 12,
			col = Vector(64, 255, 64),
		},
		[4] = {
			pos = Vector(-4, 5, -43),
			int = 4,
			col = Vector(255, 16, 16),
		},
		[5] = {
			pos = Vector(24, 10, -8),
			int = 2,
			col = Vector(96, 196, 255),
		},
		[6] = {
			pos = Vector(32, 10, -19),
			int = 4,
			col = Vector(255, 196, 128),
		},
		[7] = {
			pos = Vector(8, 0.5, -28),
			int = 4,
			col = Vector(96, 255, 64),
		},
		[8] = {
			pos = Vector(-20, 10, -30),
			int = 4,
			col = Vector(255, 196, 128),
		},
		[9] = {
			pos = Vector(0, 5, 10),
			int = 6,
			col = Vector(255, 16, 16),
		},
		[10] = {
			pos = Vector(6, 11, -41),
			int = 8,
			col = Vector(64, 96, 255),
		},
	},
	tiles = {
		[0] = {[0] = 1, [1] = 1, [2] = 4, [3] = 2, [-2] = 1, [-11] = 2, [-10] = 2, [-9] = 2, [-8] = 1, [-3] = 2, [-7] = 1, [-1] = 1, [-6] = 2, },
		[1] = {[0] = 1, [1] = 2, [2] = 2, [3] = 2, [-2] = 1, [-6] = 2, [-3] = 2, [-7] = 1, [-1] = 1, [-8] = 1, [-9] = 2, },
		[2] = {[0] = 1, [1] = 2, [-2] = 1, [-6] = 2, [-3] = 2, [-7] = 3, [-1] = 1, [-8] = 1, [-9] = 2, },
		[-2] = {[0] = 2, [1] = 2, [-2] = 2, [-11] = 2, [-10] = 2, [-9] = 2, [-8] = 1, [-3] = 2, [-7] = 1, [-1] = 2, [-6] = 2, },
		[12] = {[0] = 2, [1] = 2, [-2] = 2, [-1] = 2, [-3] = 2, },
		[11] = {[0] = 6, [1] = 2, [-2] = 6, [-1] = 6, [-3] = 2, },
		[10] = {[0] = 6, [1] = 2, [-2] = 6, [-5] = 2, [-4] = 2, [-9] = 2, [-8] = 2, [-3] = 2, [-7] = 2, [-1] = 6, [-6] = 2, },
		[9] = {[0] = 1, [1] = 2, [-2] = 1, [-5] = 1, [-4] = 2, [-9] = 2, [-8] = 1, [-3] = 1, [-7] = 1, [-1] = 1, [-6] = 1, },
		[8] = {[0] = 1, [1] = 2, [-2] = 1, [-5] = 1, [-4] = 1, [-9] = 2, [-8] = 1, [-3] = 1, [-7] = 1, [-1] = 1, [-6] = 2, },
		[7] = {[0] = 1, [1] = 2, [-2] = 1, [-5] = 1, [-4] = 1, [-9] = 2, [-8] = 1, [-3] = 1, [-7] = 1, [-1] = 1, [-6] = 1, },
		[-1] = {[0] = 1, [1] = 2, [2] = 2, [3] = 2, [-2] = 1, [-11] = 2, [-10] = 5, [-9] = 1, [-8] = 1, [-3] = 2, [-7] = 1, [-1] = 1, [-6] = 2, },
		[6] = {[0] = 1, [1] = 2, [-2] = 1, [-5] = 2, [-4] = 2, [-9] = 2, [-8] = 1, [-3] = 2, [-7] = 1, [-1] = 1, [-6] = 2, },
		[5] = {[0] = 1, [1] = 2, [-2] = 2, [-6] = 2, [-3] = 2, [-7] = 1, [-1] = 2, [-8] = 1, [-9] = 2, },
		[4] = {[0] = 1, [1] = 2, [-8] = 3, [-6] = 2, [-3] = 2, [-7] = 1, [-1] = 1, [-2] = 1, [-9] = 2, },
		[-5] = {[-8] = 1, [-5] = 2, [-7] = 1, [-9] = 1, [-10] = 2, [-6] = 1, },
		[3] = {[0] = 1, [1] = 2, [-2] = 1, [-6] = 2, [-3] = 2, [-7] = 1, [-1] = 2, [-8] = 1, [-9] = 2, },
		[-3] = {[-7] = 1, [-8] = 1, [-9] = 2, [-6] = 2, },
		[-7] = {[-7] = 2, [-8] = 2, [-6] = 2, [-9] = 2, },
		[-4] = {[-8] = 2, [-5] = 2, [-7] = 1, [-9] = 1, [-10] = 2, [-6] = 1, },
		[-6] = {[-8] = 1, [-5] = 2, [-7] = 1, [-6] = 1, [-10] = 2, [-9] = 1, },
	},
}

LoveJam.DeclareLevel("level2", levelData)