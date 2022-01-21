/// @description 


//Choose Surf
//(Dynamic In case it changed)
surfDrawingOn = (paralaxAmount >= 0) ? Camera.frgSurf :  Camera.bkgSurf;
var surfaceWidth = 0
var surfaceHeight = 0;


var surf = surfDrawingOn;
if (surface_exists(surf)) {

	var surfX = (Camera.realX);
	var surfY = (Camera.realY);
	var z = Camera.zoom;
	surfaceWidth = surface_get_width(surfDrawingOn);
	surfaceHeight = surface_get_height(surfDrawingOn);

	//Swt
	surface_set_target(surf);

	//Surface Resets in Background

		//Loop Through
		var s = ds_list_size(paralaxObjList);
		for (var i = 0; i < s; i++) {
	
			//Get Object
			var sprInfo = paralaxObjList[| i];
			var objId = sprInfo[0];

			var objW = objId.sprite_width;
			var objH = objId.sprite_height;

			//Culling
			if (objId.bbox_right > surfX-drawSurfaceBuffer && objId.bbox_left < surfX+surfaceWidth/z+drawSurfaceBuffer) {
				if (objId.bbox_bottom > surfY-drawSurfaceBuffer && objId.bbox_top < surfY+surfaceHeight/z+drawSurfaceBuffer) {

					//Set Shader
					var shader = objId.shader;
					if (shader != -1) {
						shader_set(shader);	
					}
	
					//Draw Sprite
					draw_sprite_ext(objId.sprite_index, objId.image_index, (objId.x-surfX)*z, (objId.y-surfY)*z, 
										objId.image_xscale*z, objId.image_yscale*z, objId.image_angle, 
										objId.image_blend, objId.image_alpha);
								
					//Reset Shader For Next Sprite
					if (shader != -1) {
						shader_reset();	
					}
				}
			}
		}
	
	//Exit
	surface_reset_target();
	
}

//Draw Surface
//draw_surface(layerSurf, surfX, surfY);