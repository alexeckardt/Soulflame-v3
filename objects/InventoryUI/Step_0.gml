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
	
	//Check who I'm hovering
	var hovering = inventory_check_item_hovering();
	
	//Switch if Not Same
	if (hoveringItemId != hovering) {
		hoveringItemId = hovering;
		
		//Update Display
		if (hoveringItemId != -1) {
	
			if (ds_exists(itemList, ds_type_list)) {
	
				var struct = itemList[| hoveringItemId];
				var key = "inventory.item." + struct.key;
		
				//Get
				textItemName = lang_get_text(key + ".name");
				textItemDesc = lang_get_text(key + ".desc");
		
				//Wrap on Switch
				textItemDesc = string_wrap(textItemDesc, textDrawingMaxWidth);
				
			}
	
		}
	}
	
} else
if (page == 1) {
	
} else
if (page == 2) {
	
} else
if (page == 3) {
	
	//
	var mx = Controller.right - Controller.left;
	
	//Move Holding Not Instant
	ticksBeforeNextMoveLeft--;
	if (flowerScrollMovingDir != mx) {
		//Bring Time Back to the original hold value
		ticksBeforeNextMove = ticksBeforeNextMoveResetVal; //reset
		flowerScrollMovingDir = mx;
	}	
	
	//Actually Scroll
	if (flowerScrollMovingDir != 0) {
		
		//Check if good time
		if (ticksBeforeNextMoveLeft < 0) {

			//Lower the Time for the next move; reset timer
			ticksBeforeNextMove -= 1;
			ticksBeforeNextMoveLeft = ticksBeforeNextMove;
		
			//Move in Direction & Clamp
			flowerCollectedHighlighting += flowerScrollMovingDir;
			var c = ds_list_size(Player.flowersHave);
			flowerCollectedHighlighting = clamp(flowerCollectedHighlighting, -1, c-1);
			
			//
			//Get Other Info
			var newFlowerId = Player.flowersHave[| flowerCollectedHighlighting];
			var tempStruct = flower_create_effect_struct(newFlowerId, 0); //no mutator right now;
			flowerStringFlowerName = lang_get_text("flower." + string(newFlowerId) + ".name");
			flowerStringFlowerDesc = lang_get_text("flower." + string(newFlowerId) + ".desc");
			flowerEffectEffect = "";
			flowerEffectLocation = "";
			flowerEffectPersistence = tempStruct.campfiresLeft;
			
			//
			//Wrap Font
			draw_set_font(fontKeira);
			flowerDescWrapLength = string_width(flowerStringFlowerName) + flowerEffectIconSpriteWidth + flowerNameIconXoffset*2;
			flowerStringFlowerDesc = string_wrap(flowerStringFlowerDesc, flowerDescWrapLength);
			
			//Remove
			delete tempStruct;
			
		}
	}
	
	//Lerp Smootly
	flowerCollectedHighlightingSmooth = 
		lerp(flowerCollectedHighlightingSmooth, flowerCollectedHighlighting, 0.3*time);
	
	
}
