/// @description 
var cX = floor(Camera.x);
var cY = floor(Camera.y);
var cW = Camera.view_width div 2;
var cH = Camera.view_height div 2;

//Move All Instances on a layer by their paralax Multiplier
for (var i = 0; i < paralaxSpriteCount; i++) {
	
	var structId = paralaxObjList[| i];
	
	var det = Game.delta;
	var _paralaxAmount = paralaxAmount*Game.paralaxScale;
	structId.update(det, _paralaxAmount, cX, cY, cW, cH);

}