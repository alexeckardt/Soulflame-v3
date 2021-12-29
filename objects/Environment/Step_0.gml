/// @description 
var cX = Camera.x;
var cY = Camera.y;

var cW = Camera.view_width div 2;
var cH = Camera.view_height div 2;

//Move All Instances on a layer by their paralax Multiplier
for (var i = 0; i < paralaxSpriteCount; i++) {
	
	var sprInfo = paralaxSprites[| i];
	
	//Unpack
	var elementId = sprInfo[0];
	var sprParalaxMultiX = sprInfo[1];
	var sprParalaxMultiY = sprInfo[2];
	var sprOrgX = sprInfo[3];
	var sprOrgY = sprInfo[4];
	
	//Calculate
	var xdiff = (cX - sprOrgX + cW)*sprParalaxMultiX;
	var ydiff = (cY - sprOrgY + cH)*sprParalaxMultiY;
	
	var newX = sprOrgX - xdiff;
	var newY = sprOrgY - ydiff;
	
	layer_sprite_x(elementId, newX);
	layer_sprite_y(elementId, newY);
}