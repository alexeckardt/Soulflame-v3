/// @desc

//Spawn Grasses
var c = sprite_width * density;

for (var i = 0; i < c; i++) {

	var hOff = irandom_range(-2, 2);

	var xx = x + i/density;
	var yy = y + sprite_height + hOff
	
	instance_create_depth(xx, yy, oKeira.depth - hOff*3 - 2, grassType);

}

//Clear and Destroy
instance_destroy();