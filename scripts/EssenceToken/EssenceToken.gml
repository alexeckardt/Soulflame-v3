//
//DESC:
//
//
//
function EssenceToken(_alignment) constructor {

	alignment = _alignment;
	percent = 0;
	
	sprite = essence_token_get_sprite(_alignment);
	animate = false;
	index = 0;
	
	markedAsDeleted = false;
	
	blendCol = essence_get_colour_bright(_alignment);
	blendPercent = 0;

	
	//Flash 50% at under 100; Full Flash at 100	

}