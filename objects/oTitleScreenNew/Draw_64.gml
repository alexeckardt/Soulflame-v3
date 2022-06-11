/// @description Background
display_set_gui_size(room_width, room_height);

draw_clear_alpha(0, 1);

//Pre
var count = sprite_get_number(backgroundSprite);
var c = c_white;
var sprW = sprite_get_width(backgroundSprite);
var sprH = sprite_get_height(backgroundSprite);

//Setup
var surfW = room_width + 5;
var surfH = room_height + 5;
backgroundSurf = surface_create_check(backgroundSurf, surfW, surfH);
blurredSurf = surface_create_check(blurredSurf, surfW, surfH);

surface_set_target(backgroundSurf);
//gpu_set_colorwriteenable(1, 1, 1, 0);

	//Stretch Bottom Left Pixel of Background 
	draw_sprite_part_ext(backgroundSprite, 0, 0, sprH-1, 1, 1, 0, 0, surfW, surfH, c, 1);
	
	//Draw Indexes
	for (var i = count; i > -1; i--) {
		for (var xx = 0; xx < surfW; xx += sprW) {
			draw_sprite_ext(backgroundSprite, i, xx, 0, 1, 1, 0, c, 1);
		}
	}
	
//gpu_set_colorwriteenable(1, 1, 1, 1);
surface_reset_target();	
	
//Blur Shader Within Surface
surface_set_target(blurredSurf);

	draw_clear_alpha(0, 0);
	shader_set(shd_Guassian);
	shader_set_uniform_f(uniSize, surfW, surfH, s);
		draw_surface(backgroundSurf, 0, 0);
	shader_reset();
surface_reset_target();	

	
application_surface_draw_enable(true);
application_surface_enable(true);
surface_set_target(application_surface);
	
	//Draw Surface Normally
	c = merge_colour(c_dkgray, c_black, clamp(transitionAlpha, 0, 0.7));
	draw_surface_ext(blurredSurf, 0, 0, 1, 1, 0, c, 1);

surface_reset_target();
