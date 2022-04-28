/// @description 
if (!enable) exit;

//Surf Size
var worldCamW = (Camera.view_width) + 1;
var worldCamH = (Camera.view_height) + 1;
var _vb = vb;

//Camera Pos
cX = Camera.realX;
cY = Camera.realY;
var _cx = (cX);
var _cy = (cY);

//Uniform Imports
var _u_pos = u_pos;
var _u_pos2 = u_pos2;
var _u_zz = u_zz;
var _u_str = u_str;
var _u_dir = u_dir;
var _u_fov = u_fov;

var izoom = 1 / Camera.zoom;


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
	draw_clear_alpha(0,0);
	draw_surface_ext(application_surface, 0, 0, izoom, izoom, 0, c_white, 1);
surface_reset_target();
gpu_set_colorwriteenable(1,1,1,1);

var _fakeAppSurf = fakeAppSurf;

//-------------------------------
//
// LIGHTING
//
//-------------------------------------

//Create Surface
if (!surface_exists(lightLayerSurf)) {
	lightLayerSurf = surface_create(worldCamW,worldCamH);}

//Draw In Lighting Surf
surface_set_target(lightLayerSurf);


	//Translate All
	matrix_set(matrix_world, matrix_build(-_cx, -_cy, 0, 0, 0, 0, 1, 1, 1));

	//Draw Bkg At 0,0 on surf (clear other)
	draw_clear_alpha(0,0);
	draw_surface_ext(_fakeAppSurf, _cx, _cy, 1, 1, 0, ambientLightingColour, ambientBrightnesssValue);

	//Turn on the Zbuffer (3D)
	with(Light){

		var fx = round(x);
		var fy = round(y);


		//Draw the shadows (AKA light blockers)
		gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_one);
		shader_set(shd_shadow);
		shader_set_uniform_f(_u_pos2,fx,fy);
		vertex_submit(_vb,pr_trianglelist,-1);
	
		//Draw the Light Source
		gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha, bm_one, bm_zero, bm_zero);
		shader_set(shd_light);
			shader_set_uniform_f(_u_pos,fx,fy);
			shader_set_uniform_f(_u_zz,size);
			shader_set_uniform_f(_u_str,str);
			shader_set_uniform_f(_u_dir,dir);
			shader_set_uniform_f(_u_fov,fov);
	
		//draw_sprite_ext(sPixel,1,_cx, _cy,worldCamW,worldCamH,0, colour, 1); //canvas for drawing the light
		draw_surface_ext(_fakeAppSurf,_cx, _cy, 1, 1, 0, colour, 1);
	
	}
	shader_reset();
	
surface_reset_target();

matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));
gpu_set_blendmode(bm_normal);