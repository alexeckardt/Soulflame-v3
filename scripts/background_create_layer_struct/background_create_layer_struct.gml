// @desc
//
//
//
function background_create_layer_struct(_sprite, _index, _index_speed, _paralaxAmountStruct, _xoffset, _yoffset) {

	//Create
	var struct = new BackgroundLayer();
	
	//Modify
	struct.sprite = _sprite;
	struct.index = _index;
	struct.indexSpeed = _index_speed;
	
	struct.spriteWidth = sprite_get_width(_sprite);
	struct.spriteHeight = sprite_get_height(_sprite);
	
	struct.hParalaxAmount = _paralaxAmountStruct.hParalax;
	struct.vParalaxAmount = _paralaxAmountStruct.vParalax;
	struct.scrollXAmount = _paralaxAmountStruct.xScroll;
	struct.scrollYAmount = _paralaxAmountStruct.yScroll;
	delete _paralaxAmountStruct;
	
	struct.xoffset = _xoffset;
	struct.yoffset = _yoffset;
	
	//Return
	return struct;

}