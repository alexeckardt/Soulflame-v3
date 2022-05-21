//
//DESC:
//
//
//
function flower_object_create(xx, yy, depthh, flowerType) {
	
	var instt = instance_create_depth(xx, yy, depthh, oFlower);
	
	//Set Flower
	instt.flowerType = flowerType;
	
	//Set Sprite
	instt.sprite_index = flower_object_get_sprite(flowerType);
	instt.image_index = irandom(instt.image_number);
	
	//Storename
	var flowerstore = "flower." + string(flowerType);
	storename = game_persistence_create_name_room_specific(flowerstore);
	
}