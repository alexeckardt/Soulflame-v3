/// @description 

repeat(5) {
	var newspd = random_range(0.25, 0.8);
	var life = irandom_range(10, 40);
			
	var part = light_source_particle_light_create(x, y, newspd, 180, 180, life, colour, 0);
	part.doGravity = false;
			
	part.spdIncrease = 0;
	part.spdAbsolute = true;
}