//
//DESC:
//
//
//
function InventoryDrawItem(_key, _sprite, _index, _drawsection, _xx, _yy) constructor {

	sprite = _sprite;
	index = _index;
	xx = _xx;
	yy = _yy;
	section = _drawsection;
	
	//Text
	key = _key;

	sprw = sprite_get_width(_sprite);
	sprh = sprite_get_height(_sprite);

}