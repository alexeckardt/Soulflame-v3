/// @desc Items Page

//Constants
var w = Camera.view_width;
var h = Camera.view_height;

var topDrawing = headerHeight + drawEdgeVBuffer;
var leftDrawing = drawEdgeHBuffer;
var rightDrawing = w - drawEdgeHBuffer;
var bottomDrawing = h - drawEdgeVBuffer;

var pageDrawW = rightDrawing - leftDrawing;
var pageDrawH = bottomDrawing - topDrawing;

var sectionW = pageDrawW div 3;
var sectionH = pageDrawH - sectionDividerLineEdgeBuffer*2;

textDrawingMaxWidth = ceil(sectionW * 0.75);

//
//

//Draw Section Lines

var section0x = leftDrawing + sectionW*0;
var section1x = leftDrawing + sectionW*1;
var section2x = leftDrawing + sectionW*2;

sectionPositions = [section0x, section1x, section2x];

draw_sprite_ext(sPixel, 0, section1x, topDrawing+sectionDividerLineEdgeBuffer, 1, sectionH, 0, unhighlightedColour, 1);
draw_sprite_ext(sPixel, 0, section2x, topDrawing+sectionDividerLineEdgeBuffer, 1, sectionH, 0, unhighlightedColour, 1);

//
//
//

//Left Section -- Player Equipment
//Middle Section -- Found Items

inventory_draw_item_list([section0x, section1x], topDrawing);

//
//
//

//Left Section -- Description

if (hoveringItemId != -1) {
	
	var itemDrawing = itemList[| hoveringItemId];
	
	//Draw Sprite
	var xx = section2x + (sectionW - itemDrawing.sprw) div 2;
	var yy = topDrawing + sectionH div 4 - itemDrawing.sprh div 2;
	draw_sprite(itemDrawing.sprite, itemDrawing.index, xx, yy);

	//Name
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_font(fontKeira);
	
	var secCentreX =  section2x + (sectionW + drawEdgeHBuffer) div 2;
	var nameY = yy + itemDrawing.sprh + textVerticalBuffer;
	var c = highlightedColour;
	
	draw_text_color(secCentreX, nameY, textItemName, c, c, c, c, 1);
	
	//Desc
	var descY = nameY + string_height(nameY) + textVerticalBuffer;
	draw_text_color(secCentreX, descY, textItemDesc, c, c, c, c, 1);

}

//
//
//

//Draw Cursor

draw_sprite(sInventoryItemSelectionCursor, 0, cursorX, cursorY);
