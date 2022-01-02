/// @description Camera Other



//Switch To Full Screen
if (Controller.updateFullScreen) {
	window_set_fullscreen(!window_get_fullscreen());
	display_reset(0, false);
}

//photo Mode
if (keyboard_check_pressed(vk_f8)) {
	photoMode = !photoMode;
	x = viewX;
	y = viewY;
}

//FOLLOWING

//Combat Camera


/*
//Typical Following
if (follow != id) {
	if (instance_exists(follow)) {
		
		//var dirr	= round(point_direction(x, y, follow.x, follow.y));
		//var distt	= dist(x, y, follow.x, follow.y) / 10
		
		//x += lengthdir_x(distt, dirr);
		//y += lengthdir_y(distt, dirr);
		
		if (dist(x, y, follow.x, follow.y) > 5) {
			x += ((floor(follow.x) - x) * .1); //Limit On Edges
			y += ((floor(follow.y) - y) * .1);//Limit On Edges
		}
	}
}



//Camera Shake

//Freeze Camera If Paused