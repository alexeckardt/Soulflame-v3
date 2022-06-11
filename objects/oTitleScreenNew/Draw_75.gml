
//Preform Script
for (var i = 0; i < array_length(pageScripts); i++) {
	
	//Fade Each Page In and Out
	pageDrawingAlphas[i] = lerp(pageDrawingAlphas[i], (i == pageOn), 0.5);
	
	if (pageScripts[i] != -1) {
		if (pageDrawingAlphas[i] > 0.01) {
			script_execute(pageScripts[i], true, pageDrawingAlphas[i]);
		}
	}
}


//Black Out Wipe Reveal
if (transitionAlpha > 0) {
	
	var r = color_get_red(shaderBurnAwayColour) / 255;
	var g = color_get_green(shaderBurnAwayColour) / 255;
	var b = color_get_blue(shaderBurnAwayColour) / 255;
	var a = 1;
	
	if (!transitionPositionChose && transitionTicks > room_speed*5) {
		transitionPositionChose = true;
		transitionScalePositionX = 192 * choose(0.3, 0.5, 0.7);
		transitionScalePositionY = 108 * choose(0.3, 0.5, 0.7);
	}
	
	//Create Surface
	transitionSurface = surface_create_check(transitionSurface, 192, 108);
	surface_set_target(transitionSurface);
	
		//Wipe Reveal
		shader_set(shader);
		shader_set_uniform_f(_u_fullAlphaBelowValue, clamp(1-transitionAlpha, -1, 1));
		shader_set_uniform_f(_u_leadingBlur, 0.1);
		shader_set_uniform_f(_u_glowColour,  r, g, b, a);
			draw_clear_alpha(0, 0);				//cent
		
			if (transitionAlpha > 0.85) {
				var breakpoint = "lol";	
			}
		
			//Base Glow
			draw_sprite_ext(sTitleTransition, 0, transitionScalePositionX, transitionScalePositionY, 1, 1, transitionRotation, c_white, 1);
		
		shader_reset();
	
		//The Variation in Lightness
		gpu_set_blendmode_ext(bm_dest_color, bm_zero); //Multiply
			draw_sprite_tiled(sFireLeopard, 0, 0, 0);
			draw_sprite_tiled(sFireLeopard, 0, -current_time/100, -current_time/300);
		gpu_set_blendmode(bm_normal);
	
	
		//Make Edge Of Burn Brighter 
		gpu_set_blendmode(bm_add);
		shader_set(shader);
	
			shader_set_uniform_f(_u_fullAlphaBelowValue, clamp(1-transitionAlpha, -1, 1));
			shader_set_uniform_f(_u_glowColour,  r, g, b, a);
			shader_set_uniform_f(_u_leadingBlur, 0.005);
			draw_sprite_ext(sTitleTransition, 0, transitionScalePositionX, transitionScalePositionY, 1, 1, transitionRotation, c_white, 1);
		
		shader_reset();
		gpu_set_blendmode(bm_normal);

	surface_reset_target();
	
	//Draw Surface
	draw_surface_ext(transitionSurface, 0, 0, transitionScale, transitionScale, 0, c_white, 1);
	
	//Glow Colour
	gpu_set_blendmode(bm_add);
	draw_surface_ext(transitionSurface, 0, 0, transitionScale, transitionScale, 0, glowColour, 1);
	draw_surface_ext(transitionSurface, 0, 0, transitionScale, transitionScale, 0, glowColour, 1);
	gpu_set_blendmode(bm_normal);
	
}