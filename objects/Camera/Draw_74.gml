/// @description 

//Size
display_set_gui_size(view_width*zoom, view_height*zoom);

//Lighting Imports
var cZoom = Camera.zoom;
var cRes = 1;
var worldCamW = Camera.view_width*cRes + 1;
var worldCamH = Camera.view_height*cRes + 1;
cX = Camera.realX;
cY = Camera.realY ;
var _cx = cX;
var _cy = cY;

draw_surface(view_surf, 0, 0);

//---------------------------------------------
//
// GAME LAYER CREATE
//
//------------------------------------------------

//
//Create Surfaces
if (!surface_exists(lightLayerSurf)) { lightLayerSurf = surface_create(worldCamW,worldCamH); }


//We draw with Fake App Surf because we combine other layers that should
//Be affected with lighting
var _fakeAppSurf = view_surf;

//-----------------------------------
//
// LIGHTING
//
//-----------------------------------

//Keep Track

//Set
surface_set_target(lightLayerSurf);

if (drawLighting) {

	//Prep
	draw_clear_alpha(shadowColour, 1);
	
	if (surface_exists(_fakeAppSurf)) {
		draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, c_white, 1-maxDarknessOpacity);
		//draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, shadowColour, maxDarknessOpacity);
	
		//Setup Light Drawing
		gpu_set_blendmode(bm_add);
		shader_set(shd_light);

			//Draw Each Light
			renderedLights = camera_draw_lights(cRes, _cx, _cy, _fakeAppSurf);
	
			shader_reset();
	
			//Cut Out No Alphas
			if (fastLighting) gpu_set_blendmode_ext_sepalpha(bm_dest_colour, bm_zero, bm_inv_src_alpha, bm_src_alpha);
			else gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
			draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, c_white, 1);
			gpu_set_blendmode(bm_normal);
	}
	
} else {
	
	//
	draw_clear_alpha(0, 0);
	
	if (surface_exists(_fakeAppSurf)) {
		draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, c_white, 1);
	}
	
}
	
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
display_set_gui_size(view_width, view_height);
gpu_set_colorwriteenable(1,1,1,1);
draw_surface_ext(lightLayerSurf, -frac(realX), -frac(realY), 1, 1, 0, c_white, 1);	
gpu_set_colorwriteenable(1,1,1,1);
display_set_gui_size(view_width*zoom, view_height*zoom);

//anything below is above game layer
//Draw Glowing 
gpu_set_blendmode(bm_add);
shader_set(shdEssenceMagic);
draw_surface(fireSurf, 0, 0);
		surface_set_target(fireSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
shader_reset();
gpu_set_blendmode(bm_normal);

//Foreground Paralax
if (surface_exists(frgSurf)) {
	draw_surface_ext(frgSurf, 0, 0, 1, 1, 0, c_white, 1);	
	
	//Reset Surface
		surface_set_target(frgSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
}


//Clear Application Surface
if (surface_exists(view_surf)) {
	surface_set_target(view_surf);
		draw_clear_alpha(0, 0);
	surface_reset_target();
}


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
