/// @desc

//No Pause Game
var time = Game.delta;
openAlpha = lerp(openAlpha, !close, 0.3*time);

//
if (close && openAlpha < 0.01) {
	instance_destroy();
}


//
//Increment
if (Controller.inventoryPageLeft)	page--;
if (Controller.inventoryPageRight)	page++;


//
if (page != pageLast) {
		
	var testDir1 = page - pageLast;
	var testDir2 = page - pageLast;
		
	//Set SIde
	var scrollInDir;
	if (abs(testDir1) < abs(testDir2)) {
		scrollInDir = testDir1;	} else {
		scrollInDir = testDir2;	}
		
	page = (page + pageNumber) mod pageNumber;
	headerHighlightedSpriteXoffset = headerSpriteSeperation*scrollInDir;
	
	
	//Store
	pageLast = page;	
}

headerHighlightedSpriteXoffset = lerp(headerHighlightedSpriteXoffset, 0, 0.3*time);
