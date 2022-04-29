/// @description

//Size
display_set_gui_size(view_width*zoom, view_height*zoom);

//Lighting Imports
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
//Clear
//draw_clear_alpha(0, 1);

//---------------------------------------------
//
// GAME LAYER CREATE
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

	//Draw App Surface
	draw_clear_alpha(0, 0);
	draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);

	//Draw Particles
	if (surface_exists(Game.particleViewer.particleSurf)) {
		draw_surface_ext(Game.particleViewer.particleSurf, 0, 0, zoom, zoom, 0, c_white, 1);
	}

surface_reset_target();
gpu_set_colorwriteenable(1,1,1,1);

//We draw with Fake App Surf because we combine other layers that should
//Be affected with lighting
var _fakeAppSurf = fakeAppSurf;

//-----------------------------------
//
// LIGHTING
//
//-----------------------------------

//Keep Track
var lightsDrawnLocal = 0;

//Create Surface
if (!surface_exists(lightLayerSurf)) {
	lightLayerSurf = surface_create(worldCamW,worldCamH);
}


//Set
surface_set_target(lightLayerSurf);

	//Prep
	draw_clear_alpha(0, 0);
	draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, c_white, 1);
	draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, shadowColour, maxDarknessOpacity);

	//Setup Light Drawing
	gpu_set_blendmode(bm_add);
	shader_set(shd_light);

	//Draw Each Light
	with(Light) {

		//pos
		var xx = (x - _cx) * cZoom;
		var yy = (y - _cy) * cZoom;

		//update light vars
		shader_set_uniform_f(_u_pos, xx, yy);
		shader_set_uniform_f(_u_zz, size);
		shader_set_uniform_f(_u_fov, fov);
		shader_set_uniform_f(_u_dir, dir);
		shader_set_uniform_f(_u_str, str);
		shader_set_uniform_f(_u_falloff, falloff);
		shader_set_uniform_f(_u_range, range);

		//Draw Light as overlay on surface
		draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, colour, 1);
		lightsDrawnLocal++;

	}

	shader_reset();

	//Cut Out No Alphas
	//gpu_set_blendmode_ext_sepalpha(bm_dest_colour, bm_zero, bm_inv_src_alpha, bm_src_alpha);
	gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
	draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
	gpu_set_blendmode(bm_normal);

surface_reset_target();


//
//
// DRAW TO SCREEN
//
//

//
//Background
if (surface_exists(bkgSurf)) {
	draw_surface_ext(bkgSurf, 0, 0, 1, 1, 0, c_white, 1);

	//Reset Surface
		surface_set_target(bkgSurf);
			draw_clear_alpha(c_dkgray, 1);
		surface_reset_target();
}


//GAME LAYER
gpu_set_colorwriteenable(1,1,1,0);
draw_surface_ext(lightLayerSurf, 0, 0, 1, 1, 0, c_white, 1);
gpu_set_colorwriteenable(1,1,1,1);


//anything below is above game layer
//Draw Glowing
gpu_set_blendmode(bm_normal);
shader_set(shdEssenceMagic);
draw_surface(fireSurf, 0, 0);
		surface_set_target(fireSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
shader_reset();
gpu_set_blendmode(bm_normal);


//GLOW PARTICLES


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
