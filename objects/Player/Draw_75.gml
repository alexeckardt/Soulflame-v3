/// @desc

var guiW = Camera.view_width;
var guiH = Camera.view_height;
display_set_gui_size(guiW, guiH)

//Draw Essence Tokens

	//Pos per UI scale
	var lColumnX = guiW - tokenEdgeBuffer;
	var rColumnX = lColumnX - tokenColumnSep;

	//Loop and Draw
	var tokenCount = ds_list_size(essenceTokens);
	for (var i = 0; i < essenceTokensCanHold; i++) {
	
		//Decide Positions
		var tokenyy = tokenRowHeight * i + tokenListBufferY;
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