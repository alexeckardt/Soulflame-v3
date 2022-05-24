/// @desc Flower Page

//Constants
var w = Camera.view_width;
var h = Camera.view_height;

var topDrawing = headerHeight + drawEdgeVBuffer;
var leftDrawing = drawEdgeHBuffer;
var rightDrawing = w - drawEdgeHBuffer;
var bottomDrawing = h - drawEdgeVBuffer;

var pageDrawW = rightDrawing - leftDrawing;
var pageDrawH = bottomDrawing - topDrawing;

var centreX = floor(leftDrawing + pageDrawW div 2)
var centreY = floor(topDrawing + pageDrawH div 2);
var lineH = string_height("|") + 1;

//
//
//

switch (subpage) {
	
	default:
	case 0:
	//
	// Select and See Flowers
	//
	
	var drawCollectedY = bottomDrawing - flowerCollectedListSpriteSep;
	inventory_page_flower_draw_collect_list(centreX, drawCollectedY);
	
	//Draw Selected Info
	var sel = flowerHoveringId;
	var addToFlameY = drawCollectedY - floor(flowerCollectedListSpriteSep*1.5);
	if (sel == -1) {
	
		//No Info
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		var c = darkErrorColour;
		
		if (!flowerHoveringOverEffects){
			var str = flowerStringNoFlower;
			draw_text_colour(centreX, floor(addToFlameY), str, c, c, c, c, 1);}
		
	} else {
		
		//Press Select
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_set_font(fontKeira);
		
		//
		//Draw Press Button to Add to flame
		if (!flowerHoveringOverEffects){
			var str = flowerStringAddtoFlame;
			var c = highlightedColour;
		
			if (alreadyHasEffectHovering) {
				str = flowerStringAlreadyHaveEffect;
				c = darkErrorColour;}
			if (!nearLitCampfire){
				str = flowerStringNotAtCampfire;
				c = darkErrorColour;}
			
			draw_text_with_keybinds_alt(centreX, floor(addToFlameY), str, c, 1);}
		
		//
		//Draw the Selected Info
		inventory_page_flower_draw_stats(sel, centreX, centreY - floor(lineH*3));
		//
		
	}
		
	//Draw Top
	inventory_page_flower_draw_effect_list(centreX, topDrawing + flowerCollectedListSpriteSep);	
	
	
	
	//
	break;
	//
	//
	//
	
	case 1:
	//
	// Adding Mutator
	//
	
	var drawCollectedY = bottomDrawing - flowerCollectedListSpriteSep;
	inventory_page_flower_draw_collect_list(centreX, drawCollectedY);
	
	//
	//Draw Press Button to Add to flame
	var c = highlightedColour;
	var sel = flowerCollectedHighlighting;
	var addToFlameY = drawCollectedY - flowerCollectedListSpriteSep*2;
	
	draw_text_colour(centreX, addToFlameY,		 flowerStringAddtoFlame, c, c, c, c, 1);
	draw_text_colour(centreX, addToFlameY+lineH, flowerStringCancelSelection, c, c, c, c, 1);
	
	//
	//Decide where to put the mutators
	var spaceAllocate = lineH*10;
	var mutatingBoxCentreY = centreY - spaceAllocate div 4;
	var mutatingCenterX = centreX - flowerCollectedListSpriteSep*4;
	
	//
	//Draw Header
	var str = flowerStringAddMutator;
	var c = highlightedColour;
	draw_set_valign(fa_bottom);
	draw_set_halign(fa_center);
	draw_text_color(centreX, mutatingBoxCentreY - spaceAllocate div 4, str, c, c, c, c, 1);
	
	//
	//Draw the Selected's Info on the Right
	inventory_page_flower_draw_stats(sel, centreX + 10, mutatingBoxCentreY - lineH*1.5, false);
	//
	
	//
	//Draw the Flower I am mutating on lefti
	var flowerId = Player.flowersHave[| sel];
	draw_sprite(flowerCollectedListSprite, flowerId, mutatingCenterX, mutatingBoxCentreY - lineH*1.5);
	//Draw Plus Undernear
	draw_sprite(sInventoryFlowerMutatorPlus, 0, mutatingCenterX, mutatingBoxCentreY);
	
	//Draw the mutators
	var selectX = mutatingCenterX;
	var selectY = mutatingBoxCentreY + lineH
	inventory_page_flower_draw_mutator_selection(selectX, selectY);
}


