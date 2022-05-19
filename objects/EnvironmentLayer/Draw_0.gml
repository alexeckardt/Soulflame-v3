/// @description 


//Choose Surf
//(Dynamic In case it changed)
surfDrawingOn = (paralaxAmount >= 0) ? Camera.frgSurf : Camera.bkgSurf;
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
			var structObj = paralaxObjList[| i];

			//var objW = structObj.sprWidth;
			//var objH = structObj.sprHeight;
			var objx = structObj.xx;
			var objy = structObj.yy;
			
			var leftX = structObj.xx - structObj.xoffset;
			var leftY = structObj.yy - structObj.yoffset;

			//Culling
			if (leftX+structObj.leftbbox < surfX+(surfaceWidth/z)+drawSurfaceBuffer && leftX+structObj.rightbbox > surfX-drawSurfaceBuffer) {
				if (leftY+structObj.topbbox < surfY+(surfaceHeight/z)+drawSurfaceBuffer && leftY+structObj.bottombbox > surfY-drawSurfaceBuffer) {

					//Set Shader
					var shader = structObj.shader;
					if (shader != -1) {
						shader_set(shader);	
					}
	
					//Draw Sprite
					draw_sprite_ext(structObj.sprite, structObj.index, (objx-surfX)*z, (objy-surfY)*z, 
										structObj.xscale*z, structObj.yscale*z, structObj.rot, 
										structObj.blend, structObj.alpha);
								
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