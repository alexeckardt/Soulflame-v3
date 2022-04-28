/// @description 

display_set_gui_size(view_width*zoom, view_height*zoom);

var worldCamW = (view_width) + 1;
var worldCamH = (view_height) + 1;
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

var izoom = 1 / zoom;


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
	
	//App Surf
	draw_surface_ext(application_surface, 0, 0, izoom, izoom, 0, c_white, 1);
	
	//Draw Particles w Lighting in mind
	if (surface_exists(Game.particleViewer.particleSurf)) {
		draw_surface_ext(Game.particleViewer.particleSurf, 0, 0, 1, 1, 0, c_white, 1);
	}
	
surface_reset_target();
gpu_set_colorwriteenable(1,1,1,1);

//Save For Later
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
	draw_clear_alpha(ambientLightingColour,0);
	draw_surface_ext(_fakeAppSurf, _cx, _cy, 1, 1, 0, c_white, ambientBrightnesssValue);

	//Turn on the Zbuffer (3D)
	with(Light){

		var fx = (x);
		var fy = (y);

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


//Combine Lighting Layer + App Surface Onto Single Surface
//
gpu_set_blendmode(bm_normal);
surface_set_target(gameLayerSurf);
	draw_clear_alpha(0,0);
	
	//Base
	draw_surface(fakeAppSurf, 0, 0);

	//Lighting
	gpu_set_colorwriteenable(1,1,1,0);
	gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_dest_alpha);
	draw_surface(lightLayerSurf, 0, 0);
	gpu_set_blendmode(bm_normal);
	gpu_set_colorwriteenable(1,1,1,1);
	
surface_reset_target();

//
//
//
//
// GAME LAYER RENDERING
//
//
//
//


//Clear
//draw_clear_alpha(0, 1);

//Background
if (surface_exists(bkgSurf)) {
	draw_surface_ext(bkgSurf, 0, 0, 1, 1, 0, c_white, 1);	
	
	//Reset Surface
		surface_set_target(bkgSurf);
			draw_clear_alpha(c_dkgray, 1);
		surface_reset_target();
}

//Draw Stuff, only overlaying colour
//gpu_set_blendenable(true);

//gpu_set_colorwriteenable(1,1,1,1); //may need to be 0 alpha
//gpu_set_colorwriteenable(1,1,1,1);



display_set_gui_size(view_width, view_height);



//GAME LAYER SURFACE
draw_surface(gameLayerSurf, 0, 0);





display_set_gui_size(view_width*zoom, view_height*zoom);

//Draw Glowing 
gpu_set_blendmode(bm_normal);
shader_set(shdEssenceMagic);
draw_surface(fireSurf, 0, 0);
		surface_set_target(fireSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
shader_reset();
gpu_set_blendmode(bm_normal);


//
//PARTICLE LAYERS
//
display_set_gui_size(view_width, view_height);


//GLOW PARTICLES

display_set_gui_size(view_width*zoom, view_height*zoom);

//Foreground Paralax
if (surface_exists(frgSurf)) {
	draw_surface_ext(frgSurf, 0, 0, 1, 1, 0, c_white, 1);	
	
	//Reset Surface
		surface_set_target(frgSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
}

//Clear Application Surface
surface_set_target(application_surface);
	draw_clear_alpha(0, 0);
surface_reset_target();


/*
draw_clear(c_red);

//Get Camera Dimenstionsddddd
var vw = camera_get_view_width(camera);
var vh = camera_get_view_height(camera);
display_set_gui_size(camW, camH);

//if (surface_exists(view_surf)) {
	//Get Offset based on smooth movement
	
	
	//ax = 0;
	//ay = 0;
	
	//draw_clear_alpha(c_teal, 0);
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(1, 1, 1, 0);
		draw_surface(application_surface, ax, ay);
	gpu_set_colorwriteenable(1, 1, 1, 1);
	gpu_set_blendenable(true)
	
	//Clear
	surface_set_target(application_surface);
		//shader_set(replaceBlack);
		//draw_clear_alpha(0, 1);
		//shader_reset();
		
		draw_clear_alpha(0, 0);
	surface_reset_target();
//}
