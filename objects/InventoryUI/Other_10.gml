/// @desc Items Page

//Constants
var w = Camera.view_width;
var h = Camera.view_height;

var topDrawing = headerHeight + drawEdgeBuffer;
var leftDrawing = drawEdgeBuffer;
var rightDrawing = w - drawEdgeBuffer;
var bottomDrawing = h - drawEdgeBuffer;

var pageDrawW = rightDrawing - leftDrawing;
var pageDrawH = bottomDrawing - topDrawing;

var sectionW = pageDrawW div 3;
var sectionH = pageDrawH - sectionDividerLineEdgeBuffer*2;

//
//

//Draw Section Lines

draw_sprite_ext(sPixel, 0, leftDrawing + sectionW*1, topDrawing+sectionDividerLineEdgeBuffer, 1, sectionH, 0, unhighlightedColour, 1);
draw_sprite_ext(sPixel, 0, leftDrawing + sectionW*2, topDrawing+sectionDividerLineEdgeBuffer, 1, sectionH, 0, unhighlightedColour, 1);

//
//
//

//Left Section -- Player Equipment


//
//
//

//Middle Section -- Found Items



//
//
//

//Left Section -- 
