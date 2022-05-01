// @desc
//
//
//
function create_platinum_light_particles(_am, x1, x2, y1, y2, spdMulti = 1) {

	repeat (_am) {

		var xx = irandom_range(x1, x2);
		var yy = irandom_range(y1, y2);
		var spd = random_range(0.25, 0.8)*spdMulti;
		var life = irandom_range(40, 90);
			
		var c = merge_colour(Game.platinumCol, c_aqua, 0.5);
			
		var part = light_source_particle_light_create(xx, yy, spd, 180, 180, life, c, 0);
		part.doGravity = true;
		part.gravStr = 0.001;
		part.gravDir = -90;
			
		part.spdIncrease = -0.005;
		part.spdAbsolute = true;

	}

}