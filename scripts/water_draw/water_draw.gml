// @desc
//
//
//
function water_draw(){


	//Don't do calcs if unnessesary
	if (instance_exists(oWater)) {
		
		//Shader Import
		var shd = shd_WaterDistort;
		var _water_displacement_sampler = water_displacement_sampler;
		var _water_time_uniform = water_time_uniform;
		
		//Create the distort texture
		water_draw_distort_surf();
		var distort_texture = surface_get_texture(waterDistortSurf);
		
		//Create Surface
		surface_set_target(effective_view_surf);
	
				//Setup
				//
				
				draw_clear(0);

				//Draw
				gpu_set_colorwriteenable(1,1,1,0); //don't override alpha
				draw_surface_ext(bkgSurf, 0, 0, 1, 1, 0, c_white, 1);
				draw_surface_ext(lightLayerSurf, 0, 0, 1, 1, 0, c_white, 1);

			//shader_reset();

		surface_reset_target();
		
		//
		//
		
		gpu_set_colorwriteenable(1,1,1,1);

		
		//
		// Setup For Drawing
		//

		var _reflectSurf = effective_view_surf;
		var _distortSurf = waterDistortSurf;
		var vx = realX;
		var vy = realY;	
		
		var t = Game.timeInGame / 200;



		with (oWater) {
		
			//
			//DRAW EVENT
			//
			if (wroteToBuffer) {
	
				//Get Shape
	
				if (!surface_exists(waterSurf)) {
					var b = 2*waterSurfaceEdgeBuffer;
					waterSurf = surface_create(sprite_width+b, sprite_height+b);
				}
	
				var c = Camera.id;
	
				var surfX = x-waterSurfaceEdgeBuffer;
				var surfY = y-waterSurfaceEdgeBuffer;
	
				//Set Surface
				surface_set_target(waterSurf);
		
					//Clear
					draw_clear(c_red);
		
				
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
					//Draw Surf Overtop
					if (surface_exists(_reflectSurf)) {
			
						gpu_set_colorwriteenable(1,1,1,0);
			
							//Setup Shader
							gpu_set_tex_filter(true);
							gpu_set_tex_repeat(true);
							shader_set(shd);
							texture_set_stage(_water_displacement_sampler, distort_texture);
							shader_set_uniform_f(_water_time_uniform, Game.timeInGame / 100);
			
								var xx = -surfX + vx;
								var yy =  -surfY + vy;
								draw_surface_ext(_reflectSurf, xx, yy, 1, 1, 0, c_aqua, 1);

							shader_reset();
							gpu_set_tex_filter(false);
							gpu_set_tex_repeat(false);
			
							//Overlay
							//draw_surface(_distortSurf, 0, 0);
			
						gpu_set_colorwriteenable(1,1,1,1);
					}
				
					surface_reset_target();

				//Steal Application Surface + Light
				//This will be one frame behind but like it shimmers who cares (maybe i'll fix)
	
				//Draw Surface w/ offset
				draw_surface(waterSurf, x-waterSurfaceEdgeBuffer-vx, y-waterSurfaceEdgeBuffer-vy);
			}

			
			
		
		}
	}

}
