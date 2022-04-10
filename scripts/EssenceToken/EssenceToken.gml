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

}