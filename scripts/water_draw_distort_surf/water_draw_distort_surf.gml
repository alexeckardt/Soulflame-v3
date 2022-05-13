// @desc
//
//Called by Camera when drawing water
//
function water_draw_distort_surf() {

	//Sprite
	var displaceMapSpr = sWaterDisplacementMap;
	var w = sprite_get_width(displaceMapSpr);	
	var sc  = waterCameraDistortOffsetScale;
	
	//Create
	if (!surface_exists(waterDistortSurf)) {
		waterDistortSurf = surface_create(w,w);
	}
		
	//Render Surf Tiled
	surface_set_target(waterDistortSurf);
		draw_clear( 255 div 2 );
		draw_sprite_tiled(displaceMapSpr, 0, realX*sc, realY*sc);
	surface_reset_target()

}