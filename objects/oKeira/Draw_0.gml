/// @desc

var z = 1

var xsc = round(10 * directionFacing * (1 + squishX)) / 10;
var ysc = round(10 * (1 + squishY)) / 10;
var dX = floor(x * z) / z;
var sprAnchorAtBottomY = floor(z * (y + (sprite_height - sprite_yoffset)*(-squishY)))/z
var alpha = 1;
var b = (inControl || !Game.showDebugOverlay) ? c_white : c_red;

//Scarf Draw Before Any Shaders / Effects
keira_scarf_surf_draw();

//Invulnerable Ticks Alpha
if (invulnerableTicks > 0 && !dead) {
	var fakealpha = sin(current_time/30)/2 + 0.5;
	b = merge_colour(c_black, merge_colour(c_black, b, 0.5), fakealpha);
}


//Draw Self
keira_scarf_draw(b, alpha);
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
