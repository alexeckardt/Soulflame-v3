/// @desc

//Squish and Squash
squishX = lerp(squishX, 0, squishReturnSpeed);
squishY = lerp(squishY, 0, squishReturnSpeed);

var xsc = directionFacing * (1 + squishX);
var ysc = (1 + squishY);

var dX = (x)
var sprAnchorAtBottomY = (y + (sprite_height - sprite_yoffset)*(-squishY))

//Draw Self
var b = (inControl) ? c_white : c_red;
draw_sprite_ext(sprite_index, image_index, dX, sprAnchorAtBottomY, xsc, ysc, 0, b, 1);

//Draw Weapon Overlay
draw_text(x, y, Player.weaponUsing);

//Draw Weapon
if (weaponSprite != -1) {
	
	//Shaders and Such

		draw_sprite_ext(weaponSprite, image_index, dX, sprAnchorAtBottomY, directionFacing, 1, 0, c_white, 1);

	//Reset
}