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



//
//
//

//Draw Cursor

draw_sprite(sInventoryItemSelectionCursor, 0, cursorX, cursorY);
