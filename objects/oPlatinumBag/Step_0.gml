/// @description 

event_inherited();

//Decide Sprite
if (!decidedIndex) {
	decidedIndex = true;
	
	
	image_index = platinum_get_bag_index(value);
	minPlat = value;
	maxPlat = value;
	
}

//
//Light Particles Random
if (irandom(100) < 2) {
	create_platinum_light_particles(1, bbox_left, bbox_right, bbox_top, bbox_bottom, 0.25);
}