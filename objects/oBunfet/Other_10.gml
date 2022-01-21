/// @desc Anim

if (jumped) {
	sprite_index = jumpSprite;
	image_index = 0;
	jumped = false;
}



if (sprite_index == jumpSprite) {


	index_speed = 0.2;

	//Reset
	var n = sprite_get_number(jumpSprite);
	if (image_index + index_speed >= n - index_speed) {
	
		sprite_index = idleSprite;
		image_index = 0;
		index_speed = 0.05;
	
	}

}