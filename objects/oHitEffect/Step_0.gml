/// @desc

var spd = index_speed*Game.delta;
image_index += index_speed*Game.delta;

//End Anim
if (image_index + spd > image_number - spd) {
	instance_destroy();	
}