/// @desc

var xsc = directionFacing * (1 + squishX);
var ysc = (1 + squishY);
var dX = (x)
var sprAnchorAtBottomY = (y + (sprite_height - sprite_yoffset)*(-squishY))
var alpha = 1;
var b = (inControl || !Game.showDebugOverlay) ? c_white : c_red;

//Invulnerable Ticks Alpha
if (invulnerableTicks > 0) {
	alpha = sin(current_time/30)/2 + 0.5;
	b = merge_colour(c_black, merge_colour(c_black, b, 0.5), alpha);
}

//Draw Self
draw_sprite_ext(sprite_index, image_index, dX, sprAnchorAtBottomY, xsc, ysc, 0, b, alpha);

//Draw Weapon Overlay
//draw_text(x, y, Player.weaponUsing);

//Draw Weapon
if (weaponSprite != -1) {
	
	//Shaders and Such
		shader_set(shdEssenceMagic);
		var c = essence_get_colour(Player.weaponAlignment);
		draw_sprite_ext(weaponSprite, image_index, dX, sprAnchorAtBottomY, directionFacing, 1, 0, c, 1);
		shader_reset();
	//Reset
}