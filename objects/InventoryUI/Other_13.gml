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

var centreX = leftDrawing + pageDrawW div 2
var centreY = topDrawing + pageDrawH div 2;

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
	var sel = flowerCollectedHighlighting;
	var addToFlameY = drawCollectedY - flowerCollectedListSpriteSep*1.5;
	if (sel == -1) {
	
		//No Info
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		var c = darkColour;
		draw_text_colour(centreX, addToFlameY, flowerStringNoFlower, c, c, c, c, 1);
		
	} else {
		
		//Press Select
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_set_font(fontKeira);
		var lineH = string_height("|") + 1;
		
		//
		//Draw Press Selectcic
		var c = highlightedColour;
		draw_text_colour(centreX, addToFlameY, flowerStringAddtoFlame, c, c, c, c, 1);
		
		//
		//Draw the Selected Info	
		inventory_page_flower_draw_stats(sel, centreX, addToFlameY - lineH*5.5);
		//
		
	}
	
	
	
	
	
	//
	break;
	//
	//
	//
	
	case 1:
	//
	//
	//
	
	
}


