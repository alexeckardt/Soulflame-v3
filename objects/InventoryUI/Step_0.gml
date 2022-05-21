/// @desc

//No Pause Game
var time = Game.delta;
openAlpha = lerp(openAlpha, !close, 0.3*time);

if (pageLast != page) {
	var scrollInDir = page - pageLast;	
	headerHighlightedSpriteXoffset = headerSpriteSeperation*scrollInDir;
	
	//Store
	pageLast = page;	
}

headerHighlightedSpriteXoffset = lerp(headerHighlightedSpriteXoffset, 0, 0.3*time);
