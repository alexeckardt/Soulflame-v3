/// @desc

if (keyboard_check(vk_enter)) {
	
	var k = instance_nearest(x, y, oKeira);
	
	draw_text(20, 20, "(" + string(x) + ", " + string(y) + ")")
	draw_text(20, 40, "(" + string(k.STATE) + ")")
}