/// @description Render the Game Stage

var cZoom = zoom;
var cRes = 1;
var worldCamW = view_width*cRes + 1;
var worldCamH = view_height*cRes + 1;
cX = realX;
cY = realY;
var _cx = cX;
var _cy = cY;

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
	draw_clear_alpha(0, 0);
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

//Draw Surface on Surface
water_draw();
	
surface_reset_target();
//



