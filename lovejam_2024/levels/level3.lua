LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
local levelData = {
	name = "level3",
	nextLevel = "level4",
	isNoVis = true,
	gW = 0,
	gH = 0,
	gOX = 0,
	gOY = 0,
	deco = {
		[1] = {
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
		[2] = {
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
		[3] = {
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
		[4] = {
			pos = Vector(0, 9, 8),
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
		[5] = {
			pos = Vector(0, 0, -8),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 1, 10),
			mat = "concrete1",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 10,
		},
		[6] = {
			pos = Vector(-10, 0, -14),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 4),
			mat = "concrete1",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 4,
		},
		[7] = {
			pos = Vector(-18, -1, -20),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 10),
			mat = "concrete1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 10,
		},
		[8] = {
			pos = Vector(-20, -1, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 1, 4),
			mat = "grate2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 4,
		},
		[9] = {
			pos = Vector(-8, 5, -24),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 7, 6),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 7,
		},
		[10] = {
			pos = Vector(-12, -12, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 1, 4),
			mat = "toxic",
			mdl = "plane",
			fullbright = true,
			shadow = false,
			shaded = false,
			uvScaleX = 6,
			uvScaleY = 4,
		},
		[11] = {
			pos = Vector(-12, -7, -28),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 5, 2),
			mat = "metal_wall1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 5,
		},
		[12] = {
			pos = Vector(2, -1, -28),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 10),
			mat = "concrete1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 10,
		},
		[13] = {
			pos = Vector(-4, -1, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 1, 4),
			mat = "concrete2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 4,
		},
		[14] = {
			pos = Vector(-4, -7, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 5, 4),
			mat = "metal_wall1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 5,
		},
		[15] = {
			pos = Vector(-2, 5, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(8, 7, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 8,
			uvScaleY = 7,
		},
		[16] = {
			pos = Vector(-12, 5, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 7, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 7,
		},
		[17] = {
			pos = Vector(-12, -7, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 5, 2),
			mat = "metal_wall1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 5,
		},
		[18] = {
			pos = Vector(-18, -1, -52),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 14),
			mat = "tile2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 14,
		},
		[19] = {
			pos = Vector(-20, -7, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 5, 4),
			mat = "metal_wall1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 5,
		},
		[20] = {
			pos = Vector(12, 0, -14),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 1, 4),
			mat = "tile1",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 4,
		},
		[21] = {
			pos = Vector(14, 0, -28),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 10),
			mat = "tile1",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 10,
		},
		[22] = {
			pos = Vector(8, 6, -30),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 8),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 8,
			uvScaleY = 6,
		},
		[23] = {
			pos = Vector(8, 6, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 6,
		},
		[24] = {
			pos = Vector(-8, 6, -4),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 6,
		},
		[25] = {
			pos = Vector(8, 6, -20),
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
		[26] = {
			pos = Vector(14, 6, -8),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 6,
		},
		[27] = {
			pos = Vector(22, -1, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 4),
			mat = "tile1",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 4,
		},
		[28] = {
			pos = Vector(20, 6, -20),
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
		[29] = {
			pos = Vector(22, 0, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(12, 12, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 12,
			uvScaleY = 12,
		},
		[30] = {
			pos = Vector(36, 0, -28),
			ang =  Angle(0, 0, 0),
			scl = Vector(14, 12, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 14,
			uvScaleY = 12,
		},
		[31] = {
			pos = Vector(40, -1, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 1, 4),
			mat = "grate2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 4,
		},
		[32] = {
			pos = Vector(48, 6, -40),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 10),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 10,
			uvScaleY = 6,
		},
		[33] = {
			pos = Vector(36, 6, -44),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 2,
			uvScaleY = 6,
		},
		[34] = {
			pos = Vector(42, 0, -44),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 6),
			mat = "grate2",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 6,
		},
		[35] = {
			pos = Vector(30, -12, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 1, 4),
			mat = "toxic",
			mdl = "plane",
			fullbright = true,
			shadow = false,
			shaded = false,
			uvScaleX = 4,
			uvScaleY = 4,
		},
		[36] = {
			pos = Vector(24, -7, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 5, 4),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 5,
		},
		[37] = {
			pos = Vector(36, -7, -34),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 5, 4),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 4,
			uvScaleY = 5,
		},
		[38] = {
			pos = Vector(-16, 6, -8),
			ang =  Angle(0, 0, 0),
			scl = Vector(6, 6, 2),
			mat = "metal_wall3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 6,
		},
		[39] = {
			pos = Vector(-24, 6, -38),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 28),
			mat = "metal_wall_stack3",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 28,
			uvScaleY = 6,
		},
		[40] = {
			pos = Vector(-12, 6, -48),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 6,
		},
		[41] = {
			pos = Vector(-2, 6, -68),
			ang =  Angle(0, 0, 0),
			scl = Vector(20, 6, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 20,
			uvScaleY = 6,
		},
		[42] = {
			pos = Vector(10, 6, -52),
			ang =  Angle(0, 0, 0),
			scl = Vector(20, 6, 2),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 20,
			uvScaleY = 6,
		},
		[43] = {
			pos = Vector(8, 0, -60),
			ang =  Angle(0, 0, 0),
			scl = Vector(22, 1, 6),
			mat = "tile2",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 22,
			uvScaleY = 6,
		},
		[44] = {
			pos = Vector(32, 6, -60),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 6, 6),
			mat = "metal_wall2",
			mdl = "cube",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 6,
			uvScaleY = 6,
		},
		[45] = {
			pos = Vector(20, 6, -72),
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
		[46] = {
			pos = Vector(28, 6, -72),
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
		[47] = {
			pos = Vector(24, 0, -72),
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
		[48] = {
			pos = Vector(24, 9, -72),
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
		[49] = {
			pos = Vector(4, 2, -24),
			ang =  Angle(0, 337.5, 0),
			scl = Vector(1.5, 2, 1.5),
			mat = "metal2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[50] = {
			pos = Vector(12, 2.5, -36),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 2, 2),
			mat = "silo_sheet",
			mdl = "silo",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[51] = {
			pos = Vector(-4.5, 1.5, -36.75),
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
		[52] = {
			pos = Vector(-3.2, 1.5, -35.3),
			ang =  Angle(0, 157.5, 0),
			scl = Vector(2, 2, 2),
			mat = "barrel_sheet",
			mdl = "barrel",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[53] = {
			pos = Vector(-20, 2.5, -24),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 2, 2),
			mat = "silo_sheet",
			mdl = "silo",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[54] = {
			pos = Vector(-16, 2, -44),
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
		[55] = {
			pos = Vector(-20, 1, -56),
			ang =  Angle(0, 337.5, 0),
			scl = Vector(1.5, 1, 1.5),
			mat = "metal2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[56] = {
			pos = Vector(-16, 1.5, -63.5),
			ang =  Angle(0, 112.5, 0),
			scl = Vector(2, 2, 2),
			mat = "barrel_sheet",
			mdl = "barrel",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[57] = {
			pos = Vector(-4.5, 1.5, -55),
			ang =  Angle(0, 337.5, 0),
			scl = Vector(2, 2, 2),
			mat = "barrel_sheet",
			mdl = "barrel",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[58] = {
			pos = Vector(-3.2, 1.5, -56.5),
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
		[59] = {
			pos = Vector(-8, 0, -60),
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
		[60] = {
			pos = Vector(2, 0, -64),
			ang =  Angle(0, 0, 0),
			scl = Vector(4, 0.1, 2),
			mat = "toxic",
			mdl = "cube",
			fullbright = true,
			shadow = false,
			shaded = false,
			uvScaleX = 4,
			uvScaleY = 2,
		},
		[61] = {
			pos = Vector(0, 0, -56),
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
		[62] = {
			pos = Vector(12, 3, -56),
			ang =  Angle(0, 22.5, 0),
			scl = Vector(1.5, 3, 1.5),
			mat = "metal2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 2,
		},
		[63] = {
			pos = Vector(20, 1, -60),
			ang =  Angle(0, 67.5, 0),
			scl = Vector(1.5, 1, 1.5),
			mat = "metal2",
			mdl = "push_box",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[64] = {
			pos = Vector(28, 2.5, -64),
			ang =  Angle(0, 0, 0),
			scl = Vector(2, 2, 2),
			mat = "silo_sheet",
			mdl = "silo",
			fullbright = false,
			shadow = true,
			shaded = true,
			uvScaleX = 1,
			uvScaleY = 1,
		},
		[65] = {
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
		[66] = {
			pos = Vector(24, 3, -76),
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
		[67] = {
			pos = Vector(12, 12, -32),
			ang =  Angle(180, 0, 0),
			scl = Vector(38, 1, 46),
			mat = "tile3",
			mdl = "plane",
			fullbright = false,
			shadow = false,
			shaded = true,
			uvScaleX = 38,
			uvScaleY = 46,
		},
	},
	lights = {
		[1] = {
			pos = Vector(0, 5, 10),
			int = 4,
			col = Vector(255, 16, 16),
		},
		[2] = {
			pos = Vector(0, 10, -13),
			int = 4,
			col = Vector(255, 196, 128),
		},
		[3] = {
			pos = Vector(-12, -9, -34),
			int = 8,
			col = Vector(64, 255, 64),
		},
		[4] = {
			pos = Vector(-17, 10, -23),
			int = 4,
			col = Vector(255, 196, 128),
		},
		[5] = {
			pos = Vector(15, 10, -33),
			int = 4,
			col = Vector(255, 196, 128),
		},
		[6] = {
			pos = Vector(30, -9, -34),
			int = 8,
			col = Vector(64, 255, 64),
		},
		[7] = {
			pos = Vector(11, 10, -60),
			int = 4,
			col = Vector(255, 196, 128),
		},
		[8] = {
			pos = Vector(24, 5, -74),
			int = 4,
			col = Vector(255, 16, 16),
		},
		[9] = {
			pos = Vector(-8, 1, -60),
			int = 2,
			col = Vector(64, 255, 64),
		},
		[10] = {
			pos = Vector(2, 1, -64),
			int = 4,
			col = Vector(64, 255, 64),
		},
		[11] = {
			pos = Vector(0, 1, -56),
			int = 2,
			col = Vector(64, 255, 64),
		},
		[12] = {
			pos = Vector(-17, 10, -44),
			int = 4,
			col = Vector(255, 196, 128),
		},
	},
	tiles = {
		[0] = {[0] = 1, [1] = 1, [2] = 4, [3] = 2, [-14] = 3, [-2] = 1, [-5] = 1, [-13] = 2, [-4] = 1, [-10] = 2, [-9] = 1, [-17] = 2, [-8] = 1, [-16] = 3, [-3] = 1, [-7] = 1, [-1] = 1, [-15] = 1, [-6] = 1, },
		[1] = {[0] = 1, [1] = 2, [2] = 2, [3] = 2, [-14] = 1, [-2] = 1, [-5] = 1, [-13] = 2, [-4] = 1, [-10] = 2, [-9] = 1, [-17] = 2, [-8] = 1, [-16] = 3, [-3] = 1, [-7] = 1, [-1] = 1, [-15] = 1, [-6] = 2, },
		[2] = {[0] = 2, [-2] = 2, [-5] = 2, [-17] = 2, [-14] = 1, [-4] = 1, [-10] = 2, [-9] = 2, [-13] = 2, [-8] = 2, [-16] = 1, [-3] = 1, [-7] = 2, [-1] = 2, [-15] = 1, [-6] = 2, },
		[3] = {[-14] = 2, [-2] = 2, [-5] = 1, [-4] = 1, [-10] = 2, [-9] = 2, [-17] = 2, [-8] = 1, [-13] = 2, [-3] = 1, [-7] = 1, [-16] = 1, [-15] = 1, [-6] = 1, },
		[4] = {[-14] = 1, [-2] = 2, [-5] = 1, [-4] = 1, [-10] = 2, [-9] = 1, [-17] = 2, [-8] = 1, [-13] = 2, [-3] = 1, [-7] = 1, [-16] = 1, [-15] = 1, [-6] = 1, },
		[5] = {[-14] = 1, [-2] = 2, [-5] = 2, [-19] = 2, [-18] = 2, [-4] = 2, [-10] = 2, [-9] = 1, [-17] = 2, [-8] = 1, [-13] = 2, [-3] = 2, [-7] = 2, [-16] = 1, [-15] = 2, [-6] = 2, },
		[6] = {[-14] = 1, [-13] = 2, [-10] = 2, [-9] = 1, [-8] = 1, [-17] = 1, [-18] = 5, [-7] = 2, [-16] = 1, [-15] = 1, [-19] = 1, },
		[7] = {[-14] = 1, [-13] = 2, [-10] = 2, [-9] = 6, [-8] = 6, [-7] = 2, [-19] = 2, [-17] = 2, [-16] = 2, [-15] = 1, [-18] = 2, },
		[8] = {[-14] = 2, [-8] = 6, [-13] = 2, [-15] = 2, [-7] = 2, [-16] = 2, [-10] = 2, [-9] = 6, },
		[9] = {[-8] = 1, [-12] = 2, [-7] = 2, [-11] = 2, [-10] = 2, [-9] = 1, },
		[10] = {[-8] = 1, [-12] = 1, [-11] = 1, [-7] = 2, [-10] = 1, [-9] = 1, },
		[11] = {[-8] = 1, [-12] = 1, [-11] = 1, [-7] = 2, [-10] = 1, [-9] = 1, },
		[12] = {[-8] = 2, [-12] = 2, [-7] = 2, [-11] = 2, [-10] = 2, [-9] = 2, },
		[-2] = {[0] = 2, [1] = 2, [-14] = 1, [-2] = 2, [-5] = 2, [-4] = 1, [-10] = 2, [-9] = 6, [-13] = 2, [-8] = 6, [-17] = 2, [-3] = 1, [-7] = 2, [-1] = 2, [-15] = 3, [-16] = 1, },
		[-5] = {[-14] = 2, [-2] = 2, [-5] = 1, [-12] = 1, [-11] = 1, [-4] = 1, [-10] = 1, [-9] = 1, [-17] = 2, [-8] = 1, [-13] = 1, [-3] = 1, [-7] = 1, [-16] = 1, [-15] = 1, [-6] = 2, },
		[-3] = {[-14] = 1, [-2] = 2, [-5] = 2, [-12] = 2, [-11] = 2, [-4] = 1, [-10] = 2, [-9] = 6, [-17] = 2, [-8] = 6, [-13] = 2, [-3] = 1, [-7] = 2, [-16] = 1, [-15] = 1, [-6] = 2, },
		[-4] = {[-14] = 1, [-2] = 2, [-5] = 1, [-12] = 1, [-11] = 2, [-4] = 1, [-10] = 1, [-9] = 6, [-17] = 2, [-8] = 6, [-13] = 1, [-3] = 1, [-7] = 1, [-16] = 2, [-15] = 1, [-6] = 1, },
		[-1] = {[0] = 1, [1] = 2, [2] = 2, [3] = 2, [-14] = 2, [-2] = 1, [-5] = 2, [-13] = 2, [-4] = 1, [-10] = 2, [-9] = 2, [-17] = 2, [-8] = 1, [-16] = 1, [-3] = 1, [-7] = 2, [-1] = 1, [-15] = 1, [-6] = 2, },
		[-6] = {[-14] = 2, [-2] = 2, [-5] = 2, [-12] = 2, [-11] = 2, [-4] = 2, [-10] = 2, [-9] = 2, [-17] = 2, [-8] = 2, [-13] = 2, [-3] = 2, [-7] = 2, [-16] = 2, [-15] = 2, [-6] = 2, },
	},
}

LoveJam.DeclareLevel("level3", levelData)