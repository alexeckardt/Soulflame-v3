/// @desc

//Spawn Grasses
var c = flowersToCreate;
var density = c / sprite_width;

for (var i = 0; i < c; i++) {

	var hOff = irandom_range(-2, 2);

	var xx = x + i/density;
	var yy = y + sprite_height + hOff
	
	flower_object_create(xx, yy, oKeira.depth - hOff*3 - 2, flowerType);
}

//Clear and Destroy
instance_destroy();