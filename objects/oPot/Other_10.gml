/// @desc Destory -- Drop

//Mark as Destroyed
game_persistence_set(storename, -4);
		
//Platinum Create
randomize();
platinum_create(x, y-12, value, 0.5, 1, 4, 90, 45, 2);
		
		
//Create Particles
//

	particle_create_dust(bbox_left, bbox_bottom-5, bbox_right, bbox_bottom+5, 5);
		if (potPartTypeSpr != undefined) {
			particle_create_frag(bbox_left, bbox_top, bbox_right, bbox_bottom+5, 8, potPartTypeSpr, partTypeKey);}
		
	//Light Particles
	create_platinum_light_particles(choose(1, 1, 2, 3), bbox_left, bbox_right, bbox_top, bbox_bottom);

instance_destroy();	
