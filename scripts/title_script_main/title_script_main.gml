
//Select Whether Or Not To Use The Drawing or Not Script
function title_script_main(_drawing, _globAlpha){
	
	if (!_drawing) {
		title_script_main_step();
	} else {
		title_script_main_draw(_globAlpha);
	}	
	
}

function title_script_main_step() {

	//Select Page
	pageHoveringOver += Controller.uiVerticalMove;
	pageHoveringOver = clamp(pageHoveringOver, 0, ds_list_size(visiblePages)-1);
	
	//Select If Pressed (via Controller)
	if (pageHoveringOver != -1) {
		if (Controller.uiSelectPressed) {
			var goingToPage = visiblePages[| pageHoveringOver];
			pageOn = goingToPage;
			
			//Quick Botch
			Controller.uiSelectPressed = false;
		}
	}
	
	createdMenu = false;
}

function title_script_main_draw(_globAlpha) {
	
	gpu_set_blendmode(bm_add);
	
	var xx = centerX;
	var yy = titleBaseY + (1 - titleAlpha) * 8 * titleRevealDir;
	var titleC = c_ltgray;
	draw_sprite_ext(sTitle, 0, xx, yy, 1, 1, 0, titleC, titleAlpha);
	draw_sprite_ext(sTitle, 1, xx, yy, 1, 1, 0, titleC, titleAlpha);
	draw_sprite_ext(sTitle, 2, xx, yy, 1, 1, 0, titleC, titleAlpha);
	
	//Draw Names
	draw_set_font(fontExcelsior);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	//Loop And Draw
	var len = ds_list_size(visiblePages);
	for (var i = 0; i < len; i++) {
	
		var pageID = visiblePages[| i];
		var pageName = pageNames[pageID];
		var width = string_width(pageName);
	
		var pageY = centerY + i*pageSeperation;
		var c = merge_colour(c_dkgray, titleC, (pageHoveringOver == i));
				
		draw_text_colour(centerX, pageY, pageName, c, c, c, c, _globAlpha);
		//Draw Hovering Icoss
	}
	
	draw_set_font(fontAseprite);
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_text_colour(room_width-2, room_height-2, versionNumber, c_dkgray, c_dkgray, c_dkgray, c_dkgray, _globAlpha);
	
	
	gpu_set_blendmode(bm_normal);
	
}

