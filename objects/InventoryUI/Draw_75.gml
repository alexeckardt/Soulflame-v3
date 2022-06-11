/// @desc

//
if (instance_exists(PauseMenu)) exit;

//Set One to One
var w = Camera.view_width;
var h = Camera.view_height;

var centreX = w div 2;
var centreY = h div 2;

display_set_gui_size(w,h);

//Get
gpu_set_blendmode_proper();

var darkenScreenHeight = ceil(h*openAlpha) + 2;
draw_sprite_ext(sPixel, 0, 0, (h - darkenScreenHeight) div 2, w, darkenScreenHeight, 0, 0, inventoryBkgAlpha);

//
if (!surface_exists(invenSurf))	invenSurf = surface_create(w, h);	

//Set Target
surface_set_target(invenSurf);

	//Clear
	draw_clear_alpha(0, 0); //We use Shader to remove all blaick
	
	//Draw Header Bkg
	var headerCol = 0; //Set to black
	draw_sprite_ext(sPixel, 0, 0, 0, w, headerHeight, 0, headerCol, 1);
	
	//Debug
	
	//Pos
	var iconDrawY = headerHeight div 2;
	
	//Draw Icons (i == 0) is the selected page
	for (var i = -2; i < 3; i++) {
	
		var xx = centreX + i*headerSpriteSeperation + headerHighlightedSpriteXoffset;
		var icon = (page + i + pageNumber) mod pageNumber;
		
		var c = (i == 0) ? highlightedColour : unhighlightedColour;

		draw_sprite_ext(headerSprites, icon, xx, iconDrawY, 1, 1, 0, c, 1);

	}

	//Draw Name
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_set_font(fontKeira);
	
	//Get Name Stuff
	var pageName = pageNames[page];
	var boxH = ceil(string_height(pageName))
	var boxW = sprite_get_width(headerSprites);
	var xx = centreX + headerHighlightedSpriteXoffset;
	
	//Draw Obstruction Box
	draw_sprite_ext(sPixel, 0, xx - boxW div 2, iconDrawY - ceil(boxH / 2), boxW, boxH, 0, 0, 1);

	//Draw Text
	draw_text_colour(xx, iconDrawY+1, pageName, 
			highlightedColour, highlightedColour, highlightedColour, highlightedColour, 1);

	//
	//	Draw Controller to show how to transition left or right through pages
	//

	var buff = 15;
	draw_keybind_from_string_id(buff, headerKeybindYPos, "uiLeftPage", false);
	draw_keybind_from_string_id(w-buff, headerKeybindYPos, "uiRightPage", false);


	//
	//	Preform Events
	//
	
	event_user(page);


surface_reset_target();

//
//Draw Surface
shader_set(shd_removeBlack);
draw_surface_ext(invenSurf, 0, (h - darkenScreenHeight) div 2, 1, openAlpha, 0, c_white, 1);
shader_reset();
