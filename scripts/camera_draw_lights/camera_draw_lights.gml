// @desc
//
//
//
function camera_draw_lights(cZoom, _cx, _cy, _fakeAppSurf) {

	//s
	var surfW = surface_get_width(lightLayerSurf);
	var surfH = surface_get_height(lightLayerSurf);

	//Uniform Imports
	var _u_pos	= u_pos;
	var _u_dir	= u_dir;
	var _u_str	= u_str;
	var _u_fov	= u_fov;
	var _u_zz	= u_zz;
	var _u_falloff = u_falloff;

	//Count
	var iterations = 0;

	//
	//Draw Lights!!
	//
	with(Light) {

		//pos
		if (active) {
			
			var xx = (x - _cx) * cZoom;
			var yy = (y - _cy) * cZoom;
	
			//update light vars
			shader_set_uniform_f(_u_pos, xx, yy);
			shader_set_uniform_f(_u_zz, size);
			shader_set_uniform_f(_u_fov, fov);
			shader_set_uniform_f(_u_dir, dir);
			shader_set_uniform_f(_u_str, str);
			shader_set_uniform_f(_u_falloff, falloff);
			
			//Draw Light as overlay on surface
			draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, colour, 1);
			//draw_sprite_ext(sPixel, 0, 0, 0, surfW, surfH, 0, colour, 1);
			iterations++;
			
		}
			
	}
	
	//Draw Fake pointlights
	var list = pointLightController.pointLights;
	var c = pointLightController.lightCount;
	for (var i = 0; i < c; i++) {
		
		var pointLight = list[| i];
		
		var xx = (pointLight.xx - _cx) * cZoom;
		var yy = (pointLight.yy - _cy) * cZoom;
	
		//update light vars
		shader_set_uniform_f(_u_pos, xx, yy);
		shader_set_uniform_f(_u_zz, pointLight.size);
		shader_set_uniform_f(_u_fov, pointLight.fov);
		shader_set_uniform_f(_u_dir, pointLight.dir);
		shader_set_uniform_f(_u_str, pointLight.str);
		shader_set_uniform_f(_u_falloff, pointLight.falloff);
			
		//Draw Light as overlay on surface
		draw_surface_ext(_fakeAppSurf, 0, 0, 1, 1, 0, pointLight.colour, 1);
		//draw_sprite_ext(sPixel, 0, 0, 0, surfW, surfH, 0, pointLight.colour, 1);
		iterations++;
	}

	return iterations;

}