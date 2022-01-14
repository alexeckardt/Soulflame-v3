/// @description 
var cX = floor(Camera.x);
var cY = floor(Camera.y);
var cW = Camera.view_width div 2;
var cH = Camera.view_height div 2;

//Move All Instances on a layer by their paralax Multiplier
for (var i = 0; i < paralaxSpriteCount; i++) {
	
	var sprInfo = paralaxObjList[| i];
	
	//Unpack
	var objId = sprInfo[0];
	var doX = sprInfo[1];
	var doY = sprInfo[2];
	var sprOrgX = objId.orgX;
	var sprOrgY = objId.orgY;
	
	//Calculate
	var xdiff = (cX - sprOrgX + cW)*doX*paralaxAmount*Game.paralaxScale;
	var ydiff = (cY - sprOrgY + cH)*doY*paralaxAmount*Game.paralaxScale;
	
	//Readd
	var newX = sprOrgX - xdiff;
	var newY = sprOrgY - ydiff;

	//update
	objId.x = newX;
	objId.y = newY;
}