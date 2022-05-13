/// @description 


//Get on Surface Draw
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
			
		//Draw Surf under
		if (surface_exists(c.lightLayerSurf)) {
			
			gpu_set_colorwriteenable(1,1,1,0);
			
				var reflecX = surfX-c.viewX;
				draw_surface(c.lightLayerSurf, -surfX + c.realX, -surfY + c.realY);
			
			gpu_set_colorwriteenable(1,1,1,1);
		}
			
			
		surface_reset_target();

		
	//Steal Application Surface + Light
	//This will be one frame behind but like it shimmers who cares (maybe i'll fix)
	
	
	//Draw Surface w/ offset
	draw_surface(waterSurf, x-waterSurfaceEdgeBuffer, y-waterSurfaceEdgeBuffer);
}


