/// @desc

//Update Spr
if (sprite_index == -1) {
	
	//Update Spr
	switch (damageType) {
		default:
			sprite_index = sHitEffectMedium;
			break;
	}
	
	surf = -1;
	
	var xW = (sprite_width),
	var yH = (sprite_height);
	surf = surface_create(xW,yH);

}

//Speed
var spd = index_speed*Game.delta;
image_index += spd;

//End Anim
if (image_number > 0) {
	if (image_index + spd > image_number - spd) {
		instance_destroy();	
	}
}