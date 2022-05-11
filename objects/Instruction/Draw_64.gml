/// @description

//Don't Draw pre maturley
if (createdInstructionText) {

	//Create Surface
	if (!surface_exists(surf)) {
		surf = surface_create(viewW, Camera.view_height);
	}
	display_set_gui_size(viewW, Camera.view_height);

	
	surface_set_target(surf);
	//------------------------------


		var w = display_get_gui_width();
		var h = display_get_gui_height();

		//Clear Surface (We Are In One When This Function is Called)
		draw_clear_alpha(0, 0);
	
		//Font
		draw_set_font(font);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		//String
		var orgStr = stringToDraw;
		var stringY = h/2 + 20;
		var warpString = string_wrap(orgStr, w/2);
	
		//Center String
		var xposToDraw = (w - string_width(warpString)) div 2;
	
		//Draw String
		draw_text_with_keybinds(xposToDraw, stringY, stringToDraw, keybind_info_list, c_white, 1);
	
		//	
		//Wipe
		gpu_set_colorwriteenable(0, 0, 0, 1);
			gpu_set_blendmode(bm_subtract);
				shader_set(shd_ShowUnderValue);
						shader_set_uniform_f(u_threshold, obstructionAlpha);
	
						//Draw Sprite Tiled over Text, and wipe it away
						for (var i = 0; i < display_get_width(); i+=tileWidth) {
							var ysc = string_height(orgStr) / tileWidth + 0.6;
							draw_sprite_ext(wipeSprite, 0, i, stringY-12, 1, ysc, 0, c_white, 1);
						}
					
				shader_reset();
			gpu_set_blendmode(bm_normal);
		gpu_set_colorwriteenable(1, 1, 1, 1);
	
	surface_reset_target();
	//------------------------------

	draw_surface(surf, 0, 0);
}
