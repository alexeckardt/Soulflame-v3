/// @description 

display_set_gui_size(view_width*zoom, view_height*zoom);

var m = 0;
var ax = floor(viewX) - viewX;
var ay = floor(viewY) - viewY;

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
gpu_set_colorwriteenable(1,1,1,1); //may need to be 0 alpha
draw_surface(application_surface, ax*m, ay*m);
gpu_set_colorwriteenable(1,1,1,1);

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
