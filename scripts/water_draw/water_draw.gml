// @desc
//
//
//
function water_draw(){


	//Don't do calcs if unnessesary
	if (instance_exists(oWater)) {
		
		//Shader Import
		var shd = shd_WaterDistort;
		var _water_time_uniform = water_time_uniform;
		
		//Create Surface
		if (surface_exists(effective_view_surf)) {
			surface_set_target(effective_view_surf);
	
				//Setup
				//
				draw_clear(0);
			
				//Draw
				gpu_set_colorwriteenable(1,1,1,0); //don't override alpha
				draw_surface_ext(bkgSurf, 0, 0, 1, 1, 0, c_white, 1);
				draw_surface_ext(lightLayerSurf, 0, 0, 1, 1, 0, c_white, 1);

			surface_reset_target();
		} else {
			return 1;	
		}
		
		//
		//
		
		gpu_set_colorwriteenable(1,1,1,1);

		
		//
		// Setup For Drawing
		//

		var _reflectSurf = effective_view_surf;
		var _distortSurf = waterDistortSurf;
		var vx = viewX;
		var rx = realX;
		var vy = viewY;	
		var ry = realY;	
		var cw = view_width;
		var ch = view_height;
		
		var t = Game.timeInGame / 200;

		with (oWater) {
		
			//
			//DRAW EVENT
			//
			if (wroteToBuffer) {

				//Get Shape
				var b = 2*waterSurfaceEdgeBuffer;
				if (!surface_exists(waterSurf)) {
					waterSurf = surface_create(sprite_width+b, sprite_height+b);}

				//Surf
				var surfX = x-waterSurfaceEdgeBuffer;
				var surfY = y-waterSurfaceEdgeBuffer;
	
				//Set Surface
				surface_set_target(waterSurf);
		
					//Clear
					draw_clear_alpha(c_red, 0);
		
					//Translate Positions
					matrix_set(matrix_world, matrix_build(-surfX,-surfY,0,	0,0,0,	1,1,1));
	
						//Water Shape
						shader_set(shd_WaterShape);
							vertex_submit(vb, pr_trianglestrip, -1);
						shader_reset();
	
					//Reset Position
					matrix_set(matrix_world, matrix_build(0,0,0,	0,0,0,	1,1,1));
			
					//
					//
					//Draw Surf + Cols Overtop
					if (surface_exists(_reflectSurf)) {
			
						gpu_set_colorwriteenable(1,1,1,0);
			
							//Setup Shader
							shader_set(shd);
							
							shader_set_uniform_f(_water_time_uniform, Game.timeInGame * visualWaveSpeed);
							shader_set_uniform_f(shader_get_uniform(shd, "waveFreqY"), visualWaveFreq);
							shader_set_uniform_f(shader_get_uniform(shd, "waveAmplitude"), visualWaveAmp);
							shader_set_uniform_f(shader_get_uniform(shd, "myDims"), x, y, sprite_width+b, sprite_height+b);
							shader_set_uniform_f(shader_get_uniform(shd, "camDims"), rx, ry, cw, ch);
							
								draw_surface_part_ext(_reflectSurf, surfX - rx, surfY - ry, sprite_width+b, sprite_height+b, 0, 0, 1, 1, blendcol, 1);
							
							shader_reset();
							
							//
							//Fog the water
							//(normal blending, ignore water)
							gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_zero);
							draw_sprite_ext(sPixel, 0, 0, 0, sprite_width+b, sprite_height+b, 0, blendcol, 0.3);


							gpu_set_blendmode(bm_add);
							
							//
							//Draw Fake Godrays
							water_draw_godray(b div 2);
							
							//
							//
							var s = ds_list_size(links);
							for (var i = 0; i < s; i++) {
								
								//Get
								var l = links[| i];
								
								//
								l.draw(surfX, surfY);
								
							}
							
							gpu_set_blendmode(bm_normal);
							
							//
			
						//
						gpu_set_colorwriteenable(1,1,1,1);
						
						
					}
				
					surface_reset_target();

				//Steal Application Surface + Light
				//This will be one frame behind but like it shimmers who cares (maybe i'll fix)
	
				//Draw Surface w/ offset
				gpu_set_colorwriteenable(1,1,1,0);
				//gpu_set_blendenable(false);
				draw_surface(waterSurf, x-waterSurfaceEdgeBuffer-rx, y-waterSurfaceEdgeBuffer-ry);
				//gpu_set_blendenable(true);
				gpu_set_colorwriteenable(1,1,1,1);
			}

			
			
		
		}
	}

}
