/// @desc

var keira = instance_nearest(x, y, oKeira);

var guiW = Camera.view_width;
var guiH = Camera.view_height;
display_set_gui_size(guiW, guiH)


//Feather
var featherDrawAtY = featherSurfYFromBase;
var bottomOfFeather = featherDrawAtY + featherSurfDim;

if (!surface_exists(featherSurf)) {
	
	//Surface
	featherSurf = surface_create(featherSurfDim, featherSurfDim);
	
} else {
		
	//Draw On Surf
	surface_set_target(featherSurf);
		
		//Clear
		draw_clear_alpha(0, 0);
		draw_clear(0); //temp
		
		//Draw Base Feather
		draw_sprite(featherSpr, 0, 0, featherYoffset);
	
		//Draw Text Above
		//TEMP
		
		draw_text(10, 10, corruptionPercent);
	
	
	surface_reset_target();
	
	//Draw On GUI
	//Outline Shader
	var surfX = guiW - featherSurfDim + featherSurfXFromBase;
	draw_surface(featherSurf, surfX, featherDrawAtY);
	
	shader_reset();
	
}


//Draw Essence Tokens

	//Pos per UI scale
	var lColumnX = guiW - tokenEdgeBuffer;
	var rColumnX = lColumnX - tokenColumnSep;

	//Loop and Draw
	var tokenCount = ds_list_size(essenceTokens);
	for (var i = 0; i < essenceTokensCanHold; i++) {
	
		//Decide Positions
		var tokenyy = tokenRowHeight * i + tokenListBufferY + bottomOfFeather;
		var tokenxx = (i mod 2 == 1) ? lColumnX : rColumnX;
	
		//Check If Empty
		if (i < tokenCount) {
		
			//Draw Token
			var tokenInfo = essenceTokens[| i];
			var alignment = tokenInfo[0];
			var perent = tokenInfo[1];
	
			var spr = essence_token_get_sprite(alignment);
			var ind = (perent / 100) * (sprite_get_number(spr)-1);
	
			var c = c_white;
			draw_sprite_ext(spr, ind, tokenxx, tokenyy, 1, 1, 0, c, 1);
			
			
		} else {

			//Draw Empty Slot
			var c = c_white;
			draw_sprite_ext(sEssenceTokenSlot, 0, tokenxx, tokenyy, 1, 1, 0, c, 1);		
	
		}

	}


//Draw Health
	var hpY = healthDisplayY;
	var healthBoxWidth = (baseMaxHealth + 1) * (heartWidthOffset);

	//Background
	draw_sprite_ext(sHeartBackground, 0,	-1,					hpY, healthBoxWidth,	1, 0, heartBoxCol, heartBoxAlpha);
	draw_sprite_ext(sHeartBackgroundEdge, 0,-1+healthBoxWidth,	hpY, 1,					1, 0, heartBoxCol, heartBoxAlpha);
	
	//Draw Hearts
	for (var i = 0; i < baseMaxHealth; i++) {
		
		//Position
		var heartSprite = sHeartFull
		var heartxx = (i + 0.5)*heartWidthOffset;
		
		//Decide Sprite
		//Regular Health Display
		if (i < currentMaxHealth) {
			
			//Broken Hearts, This heart is over the amount of hp I have
			if (i >= hp) {
				heartSprite = sHeartBroken;
			}
				
		//Hearts Over the current max health	
		} else {
			
			//Corrupted Hearts
			switch (sign(corruptionPercent)) {
				case -1: heartSprite = sHeartCorruptedChaos;break;	
				case +1: heartSprite = sHeartCorruptedOrder;break;	
			}
		
		}
		
		//Draw
		draw_sprite(heartSprite, 0, heartxx, hpY);
		
	}
	
//Weapon Wheel
if (weaponWheelScale > weaponWheelScaleDispalyThreshold) {
		//Create Surface for Use
		if (!surface_exists(weaponWheelSurf)) {
			var w = weaponWheelSurfaceWidth;
			weaponWheelSurf = surface_create(w, w);	
		}
		
		//Draw Surface
		surface_set_target(weaponWheelSurf);
			var center = weaponWheelSurfaceWidth div 2;
	
			//Clear
			draw_clear_alpha(0, 0);
			
			//Draw "Ring"
			var wheelBuffer = weaponSelectionBubbleSize;
			var wheelRadius = weaponWheelSize div 2;
			
			var originAngle = weaponWheelArcStartAngleOffset;
			
			draw_pie(center-1, center-1, weaponWheelArcLength, 360, c_black, wheelRadius, 1, originAngle);
			
			//Draw
			var sSize = weaponWheelArcLength div weaponWheelSlots;
			
			//Draw Selection Arc
			if (weaponSlotHighlighted != -1) {
				var startAng = originAngle + ((weaponSlotHighlighted) * sSize);
				startAng %= 359;
				draw_pie(center-1, center-1, sSize + wheelSelectionArcIncrease, 360, c_gray, wheelRadius + 5, 1, startAng);
			}
	
	
			//Remove the Middle
			gpu_set_blendmode(bm_subtract);
			draw_sprite(weaponWheelSpr, 1, wheelBuffer, wheelBuffer)
			gpu_set_blendmode(bm_normal);
	
	
			//Draw The Icons
			for (var i = 0; i < weaponWheelSlots; i++) {
				
					//Bkg
					var startAng = originAngle + (i * sSize) + (sSize div 2);
					startAng %= 359;
					
					//Pos
					var iconLen = wheelRadius - 16 + 4*abs(dsin(startAng))*(weaponSlotHighlighted == i);
					var wIconX = center + lengthdir_x(iconLen, startAng);
					var wIconY = center + lengthdir_y(iconLen, startAng);
					
					switch (weaponUipage) {

						//Draw Equipted Weapons + Imbument Colours
						default:
						case 0:
						case 1:
						
							var essenceModifier = weapon_slot_get_alignment(i);
							var c = essence_get_colour(essenceModifier);
							var weaponId = weapon_slot_get_id(i);
							
							shader_set(shdEssenceMagic);
							weapon_draw(weaponId, wIconX, wIconY, 1, 0, c, 1);	
							shader_reset();
						
						break;
						
						//Draw Wepaons
						case 2:
						
							var weaponId = weapon_get_unlocked_slot_id(i);
							var c = essence_get_colour(0);
							
							shader_set(shdEssenceMagic);
							weapon_draw(weaponId, wIconX, wIconY, 1, 0, c, 1);	
							shader_reset();
						
						break;
					
						//Draw the Icons
						case 3:
						
							var spr = essence_token_get_sprite(i-1);
							var ind = sprite_get_number(spr)-1;
							
							//Draw The Icon
							draw_sprite_ext(spr, ind, wIconX-1, wIconY-1, 1, 1, 0, c_white, 1);
							
						break;
						
					}				
			}

			//Draw Weapon Under Arc Page 3
			if (weaponUipage == 3) {
				
				//Draw The Forge In The Middle if the right colour
				var c = c_gray;
				if (weaponSlotHighlighted > -1) {
					c = essence_get_colour(weaponSlotHighlighted-1);
				}
							
				shader_set(shdEssenceMagic);
				weapon_draw(forgingWeaponId, center, center, 1, 0, c, 1);	
				shader_reset();
							
			}

	
			//Draw Controller Stick Position
			var zoneRad = weaponWheelSize;
			var rad = min(0.5, weaponWheelLerpDisplayingLen);

			var stickX = zoneRad * lengthdir_x(rad, weaponWheelLerpDisplayingDir);
			var stickY = zoneRad * lengthdir_y(rad, weaponWheelLerpDisplayingDir);
			
			//draw_circle(center+stickX, center+stickY, 10, false);
			//draw_text_colour(center, center, weaponSlotHighlighted, 0,0,0,0, 1);
							
			surface_reset_target();
		
		
		//Draw Surface
		var wheelPosX = (guiW - weaponWheelSurfaceWidth*weaponWheelScale) div 2; //Match Player X in future
		var wheelPosY = (guiH - weaponWheelSurfaceWidth*weaponWheelScale) div 2; //
		
		//Surf
		draw_surface_ext(weaponWheelSurf, wheelPosX, wheelPosY, weaponWheelScale, weaponWheelScale, 0, c_white, 1)
	
	}

draw_text(10, 10, Controller.rightStickDirection);


//Interaction Over Player

	//Update Vars
	showInteractString = keira.showInteractString;
	interactString = keira.interactString;

	//Check
	var sameString	= interactString == drawingInteractString;

	//Alpha (Fade out if Not same or not touching)
	interactAlpha	= lerp(interactAlpha, showInteractString*sameString, (0.18 + (0.2*(!sameString)))*Game.delta);
	if (interactAlpha < 0.01) {
		drawingInteractString = interactString
	} else {
		
		//Positions & Setup
		draw_set_halign(fa_left);
		draw_set_valign(fa_bottom);
		draw_set_font(fontKeira);
		
		var pSurfX = (keira.x - Camera.x);
		var pSurfY = (keira.y - Camera.y);
		
		var textW			= string_width(drawingInteractString) + 5;
		var edgeOffset		= sprite_get_xoffset(sInteractSprite);
		var minWidth		= 16; //Constant, Look at sprite
	
		var sectionWidth	= max(minWidth, textW)
		var textEdges = 3;
	
		var w				= ceil(sectionWidth + textEdges*2);
		var h				= sprite_get_height(sInteractSprite);

		var anchX		= floor(edgeOffset+2);
		var anchY		= h
	
		var surfX = pSurfX - w div 2;
	
		//Create Surface
			if (!surface_exists(interactSurface)) {
				interactSurface = surface_create(1, 1)
			}
			if (surface_get_width(interactSurface) != w+1)
			|| (surface_get_height(interactSurface) != h) {
				surface_resize(interactSurface, w+1, h)
			}
	
		//Surface Enter
		surface_set_target(interactSurface);
	
			draw_clear_alpha(0, 0);

			var c = c_white;
			var ww = w div 2 - edgeOffset;

			//Draw Sprite Edges
			draw_sprite_ext(sInteractSprite, 0, ww + edgeOffset + 1,	anchY, 1, 1, 0, c, 1); //The Emblem; in middle
		
			draw_sprite_ext(sInteractSprite, 2, edgeOffset,			anchY, 1, 1, 0, c, 1); //Left Edge
			draw_sprite_ext(sInteractSprite, 3, w - edgeOffset,		anchY, 1, 1, 0, c, 1); //Right Edge

			//Draw Text
			var tX = textEdges*2+1
			draw_text_colour(tX, anchY - 6, drawingInteractString, c, c, c, c, 1);

			//Reset Alkignment
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
		surface_reset_target();

		//Draw Surface
		draw_surface_ext(interactSurface, surfX, pSurfY - h - 20, 1, 1, 0, c_white, interactAlpha);

	}