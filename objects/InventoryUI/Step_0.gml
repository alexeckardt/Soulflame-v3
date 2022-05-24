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
//Increment Pages
if (Controller.inventoryPageLeft)	page--;
if (Controller.inventoryPageRight)	page++;

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
	subpage = 0;
}

headerHighlightedSpriteXoffset = lerp(headerHighlightedSpriteXoffset, 0, 0.3*time);

//
//
//

//See if At Campfire (For Flower and Artifacts)
nearLitCampfire = false;
if (instance_exists(oCampfire)) {
	var camp = instance_nearest(oKeira.x, oKeira.y, oCampfire);
	if (point_distance(oKeira.x, oKeira.y, camp.x, camp.y) < campfireRange) {
		if (camp.lit) {
			nearLitCampfire = true;
		}
	}
}

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
	
	//
	var redetermineEffectInfo = false;
	var mx = Controller.right - Controller.left;
	var switchedLists = false;
	
	//Switch List
	if (subpage == 0) {

		//Switch to see my effects
		if (Controller.uiUp) {
			switchedLists = !flowerHoveringOverEffects;
			flowerHoveringOverEffects = true;	
			
		} else
		if (Controller.uiDown) {
			switchedLists = flowerHoveringOverEffects;
			flowerHoveringOverEffects = false;	
		}
	
	}
	

	//Move Holding Not Instant
	ticksBeforeNextMoveLeft--;
	if (flowerScrollMovingDir != mx) {
		//Bring Time Back to the original hold value
		ticksBeforeNextMove = ticksBeforeNextMoveResetVal; //reset
		flowerScrollMovingDir = mx;
	}	
	
	//Actually Scroll
	if (flowerScrollMovingDir != 0 || switchedLists) {
		
		//Check if good time
		if (ticksBeforeNextMoveLeft < 0 || switchedLists) {

			//Lower the Time for the next move; reset timer
			ticksBeforeNextMove -= 1;
			ticksBeforeNextMoveLeft = ticksBeforeNextMove;

			//PAGE DIFF
			if (subpage == 0) {
	
				var newFlowerId;
	
				//Scroll through the different
	
				//Check Inventory
				if (!flowerHoveringOverEffects) {
		
					var list = Player.flowersHave;
		
					//Move in Direction & Clamp
					flowerCollectedHighlighting += flowerScrollMovingDir;
					var c = ds_list_size(list);
					flowerCollectedHighlighting = clamp(flowerCollectedHighlighting, -1, c-1);
					
					//Get
					if (flowerCollectedHighlighting != -1) 
							flowerHoveringId = list[| flowerCollectedHighlighting];
					else	flowerHoveringId = -1;
					
					//Store
					newFlowerId = flowerHoveringId;
					
				//Check Effects
				} else {
					
					var list = Player.effectList;
					
					//Move and Clamp
					flowerHoveringOverEffectNum += flowerScrollMovingDir;
					var c = ds_list_size(list);
					flowerHoveringOverEffectNum = clamp(flowerHoveringOverEffectNum, 0, c-1);
					
					//Store
					var flowerStruct = list[| flowerHoveringOverEffectNum];
					flowerHoveringId = flowerStruct.effect;
					mutatorSelected = flowerStruct.mutatorAdded;
					
					newFlowerId = flowerHoveringId;
				}
				
				
				//
				//Get Other Info
				flowerStringFlowerName = lang_get_text("flower." + string(newFlowerId) + ".name");
				flowerStringFlowerDesc = lang_get_text("flower." + string(newFlowerId) + ".desc");
				
				redetermineEffectInfo = true;
				
				//
				//Wrap Font
				draw_set_font(fontKeira);
				flowerDescWrapLength = string_width(flowerStringFlowerName) + flowerEffectIconSpriteWidth + flowerNameIconXoffset*2;
				flowerStringFlowerDesc = string_wrap(flowerStringFlowerDesc, flowerDescWrapLength);
				
				
			} else 
			if (subpage == 1) {
				
				//Mutator Incement
				mutatorSelected += flowerScrollMovingDir;
				mutatorSelected = clamp(mutatorSelected, 0, mutatorCount-1);	
				
				redetermineEffectInfo = true;
				
			}
			
		}
	}
	
	//
	//Reco
	if (redetermineEffectInfo) {
			
		//Temp
		var tempStruct = flower_create_effect_struct(flowerHoveringId, mutatorSelected);
		
		flowerEffectEffect = lang_get_text("flower." + string(flowerHoveringId) + ".effect");
		flowerEffectLocation = lang_get_text("flower." + string(flowerHoveringId) + ".location");
		flowerEffectPersistence = tempStruct.campfiresLeft;
		flowerStringMutatorAdding = lang_get_text("flower.mutator_name." + string(mutatorSelected));
		
		//Remove Created
		delete tempStruct;	
	}
	//
	
	//Verify Stuff
	alreadyHasEffectHovering = effect_has(flowerHoveringId);
	
	//
	//Per Subpage
	if (subpage == 0) {
		
		//Lerp Smootly (Animate selection)
		flowerCollectedHighlightingSmooth = 
			lerp(flowerCollectedHighlightingSmooth, flowerCollectedHighlighting, 0.3*time);
		
		//Switch Subpage
		if (!flowerHoveringOverEffects) {
			if (Controller.uiSelectPressed) {
				if (nearLitCampfire) {
					if (flowerCollectedHighlighting != -1) {
						if (!alreadyHasEffectHovering) {
							
								//Continue
								subpage = 1;
								selectedFlowerYoffset = -12; //poof little thingy
								mutatorSelected = 0;
								
						}
					}
				}
			}
		}

	} else 
	if (subpage == 1) {
		
		//Animate Smoothly
		mutatorSelectedSmooth = lerp(mutatorSelectedSmooth, mutatorSelected, 0.3*time);
		
		//
		//Back
		if (Controller.uiBackPressed || Controller.combatAttackPressed) {
			subpage = 0;
			mutatorSelected = 0;
		}
		
		//
		//SAVE EFFECT + ADD IT!!!!
		//Make sure all are required again
		if (Controller.uiSelectPressed) {
			if (nearLitCampfire) {
				if (flowerCollectedHighlighting != -1) {
					
					//Consume
					flower_consume(flowerCollectedHighlighting, mutatorSelected);
					
					//Re-Clamp Positon
					var c = ds_list_size(Player.flowersHave);
					flowerCollectedHighlighting = clamp(flowerCollectedHighlighting, -1, c-1);
					mutatorSelected = 0;
					
					//Return
					subpage = 0;
					flowerHoveringOverEffects = false;
					
				}
			}
		}
	}
	
	//Selection Effect
	selectedFlowerYoffset = lerp(selectedFlowerYoffset, 0, 0.1*time);
	
} else
if (page == 3) {
	
	
}else
if (page == 4) {
	
	
}
