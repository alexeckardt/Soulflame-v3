/// @description 

event_inherited();

//Update (Stolen from Magpie etc)
if (valueChanged) {
	decidedIndex = false;
	}

//Decide Sprite
if (!decidedIndex) {
	decidedIndex = true;
	valueLast = value;
	
	image_index = platinum_get_bag_index(value);
	
	//Destroy Bags if Zero (pots won't be default)
	if (value == 0) {
		event_user(0);	
	}
}

//
//Light Particles Random
if (irandom(100) < 2) {
	create_platinum_light_particles(1, bbox_left, bbox_right, bbox_top, bbox_bottom, 0.25);
}

