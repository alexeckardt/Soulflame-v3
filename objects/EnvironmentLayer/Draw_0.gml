/// @description 

//Surface Create
if (!surface_exists(layerSurf)) {
	layerSurf = surface_create(Camera.view_width, Camera.view_height);
}

var surfX = Camera.x;
var surfY = Camera.y;


//Swt
surface_set_target(layerSurf);

//Reset
draw_clear_alpha(0, 0);

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
		draw_sprite_ext(objId.sprite_index, objId.image_index, floor(objId.x-surfX), floor(objId.y-surfY), 
							objId.image_xscale, objId.image_yscale, objId.image_angle, 
							objId.image_blend, objId.image_alpha);
	}

	//Reset Shader
	shader_reset();
	
//Exit
surface_reset_target();

//Draw Surface
draw_surface(layerSurf, surfX, surfY);