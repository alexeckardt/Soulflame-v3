// @desc
//
//
//
function point_light_create_ext(xmin, xmax, ymin, ymax, spdmin, spdmax, movedir, dirfov, lifemin, lifemax, c1, c2, gravAmount, gravDir) {

	//Light Particle
	var xx = irandom_range(xmin, xmax);
	var yy = irandom_range(ymin, ymax);
	var spd = random_range(spdmin, spdmax);
	var life = irandom_range(lifemin, lifemax);
			
	var part = point_light_create(xx, yy, spd, movedir, dirfov, life, c1, c2);
	part.doGravity = (gravAmount != 0);
	part.gravDir = gravDir;
	part.gravStr = gravAmount;
	part.fadeThroughLife = true;
	
	return part;
}