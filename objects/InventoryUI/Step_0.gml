/// @desc

//
if (instance_exists(PauseMenu)) exit;

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
	
	inventory_page_construct(page);
	
	//Store
	pageLast = page;	
}

headerHighlightedSpriteXoffset = lerp(headerHighlightedSpriteXoffset, 0, 0.3*time);


//
//
//
var w = display_get_gui_width();
var h = display_get_gui_height();

var leftSide = drawEdgeHBuffer;
var rightSide = w - drawEdgeHBuffer;
var topSide = headerHeight + drawEdgeVBuffer;
var bottomSide = h - drawEdgeVBuffer;

if (page == 0) {

	var mx = Controller.right - Controller.left;
	var my = Controller.uiDown - Controller.uiUp;

	cursorX = clamp(cursorX + mx*cursorSpeed, leftSide, rightSide);
	cursorY = clamp(cursorY + my*cursorSpeed, topSide, bottomSide);
	
	hoveringItemId = inventory_check_item_hovering();
	
}
