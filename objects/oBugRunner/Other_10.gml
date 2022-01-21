/// @desc Anim

switch (STATE) {
	default:
		sprite_switch_to(idleSprite);
		index_speed = 0.05;
	break;
	case state.chase:
		sprite_switch_to(runSprite);
		index_speed = 0.2;
		
		//Run Particles
		particle_create_dust(bbox_left, bbox_bottom, bbox_right, bbox_bottom, -5);
	break;
	case state.breaking:
		sprite_switch_to(breakSprite);
		index_speed = 0;
		
		//Break Particles
		particle_create_dust(bbox_left, bbox_bottom, bbox_right, bbox_bottom, 3);
	break;
}