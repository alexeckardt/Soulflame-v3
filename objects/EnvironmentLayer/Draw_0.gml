/// @description 


//Choose Surf
//(Dynamic In case it changed)
var surf = (paralaxAmount >= 0) ? Camera.frgSurf :  Camera.bkgSurf;

if (surface_exists(surf)) {

	var surfX = (Camera.x);
	var surfY = (Camera.y);
	var z = Camera.zoom;

	//Swt
	surface_set_target(surf);

	//Surface Resets in Background

		//Loop Through
		var s = ds_list_size(paralaxObjList);
		for (var i = 0; i < s; i++) {
	
			//Get Object
			var sprInfo = paralaxObjList[| i];
			var objId = sprInfo[0];

			//Set Shader
			var shader = objId.shader;
			if (shader != -1) {
				shader_set(shader);	
			} else {
				shader_reset();
			}
	
			//Draw Sprite
			draw_sprite_ext(objId.sprite_index, objId.image_index, (objId.x-surfX)*z, (objId.y-surfY)*z, 
								objId.image_xscale*z, objId.image_yscale*z, objId.image_angle, 
								objId.image_blend, objId.image_alpha);
		}

		//Reset Shader
		shader_reset();
	
	//Exit
	surface_reset_target();
	
}

//Draw Surface
//draw_surface(layerSurf, surfX, surfY);