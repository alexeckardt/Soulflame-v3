/// @description 

var cZoom = Camera.zoom;
var worldCamW = Camera.view_width*cZoom + 1;
var worldCamH = Camera.view_height*cZoom + 1;
cX = Camera.realX;
cY = Camera.realY;
var _cx = cX;
var _cy = cY;

//Uniform Imports
var _u_pos	= u_pos;
var _u_dir	= u_dir;
var _u_str	= u_str;
var _u_fov	= u_fov;
var _u_zz	= u_zz;
var _u_falloff = u_falloff;
var _u_range = u_range;

//---------------------------------------------
//
// SCALE APP SURFACE
//
//------------------------------------------------

//Create Surf
if (!surface_exists(fakeAppSurf)) {
	fakeAppSurf = surface_create(worldCamW-1, worldCamH-1);
}

//Draw App Surface, Scaled 1:1 Pixels
gpu_set_colorwriteenable(1,1,1,1);
surface_set_target(fakeAppSurf);
gpu_set_blendmode(bm_normal);

	draw_clear_alpha(0, 0);
	draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
	
	//if (surface_exists(Game.particleViewer.particleSurf)) {
		//draw_surface_ext(Game.particleViewer.particleSurf, 0, 0, 1, 1, 0, c_white, 1);
	//}
	
surface_reset_target();
gpu_set_colorwriteenable(1,1,1,1);

var _fakeAppSurf = fakeAppSurf;

//-----------------------------------
//
// LIGHTING
//
//-----------------------------------

//Keep Track
var lightsDrawnLocal = 0;

//
if (!surface_exists(lightLayerSurf)) {
	lightLayerSurf = surface_create(worldCamW,worldCamH);	
}

//Translate
//matrix_set(matrix_world, matrix_build(-_cx, -_cy, 0, 0, 0, 0, 1, 1, 1));

//Set
surface_set_target(lightLayerSurf);

	//Prep
	draw_clear_alpha(0, 0);
	draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
	draw_surface_ext(application_surface, 0, 0, 1, 1, 0, shadowColour, maxDarknessOpacity);
	
	//gpu_set_blendmode_ext_sepalpha(bm_one, bm_one, bm_zero, bm_one);

	if (keyboard_check_pressed(vk_space)) {
		var hi = 0;	
	}
	
	//Setup
	gpu_set_blendmode(bm_add);
	shader_set(shd_light);

	//Draw Each
	with(Light) {

		var xx = (x - _cx) * cZoom;
		var yy = (y - _cy) * cZoom;
	
		//Draw Light
		shader_set_uniform_f(_u_pos, xx, yy);
		shader_set_uniform_f(_u_zz, size);
		shader_set_uniform_f(_u_fov, fov);
		shader_set_uniform_f(_u_dir, dir);
		shader_set_uniform_f(_u_str, str);
		shader_set_uniform_f(_u_falloff, falloff);
		shader_set_uniform_f(_u_range, range);
			
		draw_surface_ext(application_surface, 0, 0, 1, 1, 0, colour, 1);
		lightsDrawnLocal++;
			
	}
	
	shader_reset();
	
	//Cut Out No Alphas
	//gpu_set_blendmode_ext_sepalpha(bm_dest_colour, bm_zero, bm_inv_src_alpha, bm_src_alpha);
	gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
	draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
	gpu_set_blendmode(bm_normal);
	
surface_reset_target();

//Move Back
//matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));