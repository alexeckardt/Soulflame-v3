//
//DESC:
//
//
//
function inventory_page_flower_draw_stats(i, topLeftX, topLeftY, drawLeftSide = true){

	var list = Player.flowersHave;
	var flowerId = list[| i];
	
	if (drawLeftSide) {
		topLeftX += flowerInfoSideSep div 2;}
	
	//Draw Text
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fontKeira);
	
	var lineHeight =string_height("|") + 1;
	var c = darkColour;	
	var augmentedCol = c_lime;
		
	//Draw Headers
	draw_text_colour(topLeftX, topLeftY+lineHeight*0, flowerStringFlowerInfoEffect, c, c, c, c, 1);
	draw_text_colour(topLeftX, topLeftY+lineHeight*1, flowerStringFlowerInfoLocation, c, c, c, c, 1);
	draw_text_colour(topLeftX, topLeftY+lineHeight*2, flowerStringFlowerInfoPersistence, c, c, c, c, 1);
	

	//
	//Draw the info
	//

	//
	//Effect
	var effectW = string_width(flowerStringFlowerInfoEffect + " ");
	var effectString = flowerEffectEffect;
	var effectCol = unhighlightedColour;
		if(mutatorSelected == 1) {
			effectString = string_replace_all(effectString, "!", "!!");
			effectCol = augmentedCol;
		}
	effectString = string_replace_all(effectString, "!", "I");
	draw_text_colour(topLeftX + effectW, topLeftY+lineHeight*0, effectString,
							effectCol, effectCol, effectCol, effectCol, 1);
	
	//
	//Location
	var locationW = string_width(flowerStringFlowerInfoLocation + " ");
	effectCol = unhighlightedColour;
	draw_text_colour(topLeftX + locationW, topLeftY+lineHeight*1, flowerEffectLocation,
							effectCol, effectCol, effectCol, effectCol, 1);
	
	//
	//Persistence
	var persistenceW = string_width(flowerStringFlowerInfoPersistence + " ");
	var persistString = string(flowerEffectPersistence);
	var effectCol = unhighlightedColour;
		if(mutatorSelected == 2) {
			effectCol = augmentedCol;
		}
	draw_text_colour(topLeftX + persistenceW, topLeftY+lineHeight*2, persistString,
							effectCol, effectCol, effectCol, effectCol, 1);
	
	//
	//
	if (drawLeftSide) {
		
		//Move Left
		topLeftX -= (flowerInfoSideSep div 2) * 2;
		
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
		draw_set_font(fontKeira);	

		//Draw Icon
		var iconX = topLeftX - flowerEffectIconSpriteWidth;
		draw_sprite(flowerEffectIconSprite, flowerId, iconX, topLeftY);
		
		//Draw Flower Name
		var nameCol = flower_get_colour(flowerId);
		draw_text_colour(iconX - flowerNameIconXoffset, topLeftY, flowerStringFlowerName,
							nameCol, nameCol, nameCol, nameCol, 1);
		
		//Draw Flower Description
		var descCol = unhighlightedColour;
		draw_text_colour(topLeftX, topLeftY + lineHeight, flowerStringFlowerDesc,
							descCol, descCol, descCol, descCol, 1);
		
		//
		//Draw Sprite Again
		var off = sprite_get_width(sinventoryFlowerIcon) div 2;
		draw_sprite(sinventoryFlowerIcon, flowerId, topLeftX - flowerDescWrapLength -off, topLeftY+lineHeight*1);
				
	}
}