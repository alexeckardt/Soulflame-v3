/// @description 

repeat(5) {
	var newspd = random_range(0.25, 0.8);
	var life = irandom_range(10, 40);
	var c = essence_get_colour_emission(align);
	
	var part = point_light_create(x, y, newspd, 180, 180, life, c, 0);
	part.doGravity = false;
			
	part.spdIncrease = 0;
	part.spdAbsolute = true;
	
	part.str = 0.5;
	part.fadeThroughLife = true;
}