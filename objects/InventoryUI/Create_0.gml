/// @desc

//Draw Ontop of Player's UI
depth = Player.depth - 10;

close = false;
openAlpha = 0;

page = 0;
pageNames = ["Items", "Map", "Flowers", "Artifacts", "Weapons"];
pageNumber = array_length(pageNames);
pageLast = page;

inventoryBkgCol = $555555;
inventoryBkgAlpha = 0.8;

//


//Surf
invenSurf = -1;

//
headerSprites = sInventoryPageIcons;
headerBuffer = 4;
headerHeight = sprite_get_height(headerSprites) + 2*headerBuffer;

headerHighlightedSpriteXoffset = 0;
headerSpriteSeperation = 90;

headerKeybindYPos = headerHeight div 2;

//
highlightedColour = c_white;
unhighlightedColour = c_dkgray;
darkColour = $222222;
darkErrorColour = bgr($4c0000);

//Edges
drawEdgeHBuffer = 12;
drawEdgeVBuffer = 4;

//Lines
sectionDividerLineEdgeBuffer = 25;

//
//Campfire
nearLitCampfire = false;
campfireRange = 128;

//
//
//ITEMS

itemList = ds_list_create();
inventory_create_item_list();

cursorX = Camera.view_width div 2;
cursorY = Camera.view_height div 2;
cursorSpeed = 2;
hoveringItemId = -1;

sectionPositions = [0, 0, 0];
selectBuffer = 2;

//dis
textDrawingMaxWidth = 100; //for wrapping strings ; set in draw (incase it is updated)
textItemName = "";
textItemDesc = "";
textVerticalBuffer = 10;

//
//
//MAP



//
//
//ARTIFACTS




//
//
//FLOWERS

subpage = 0;
flowerCollectedHighlighting = -1;
flowerCollectedHighlightingSmooth = -1; //animated
flowerCollectedListSprite = sinventoryFlowerIcon;
flowerEffectIconSprite = sUIFlowerEffectIcon;
flowerCollectedListSpriteSep = sprite_get_width(flowerCollectedListSprite) + 1;
flowerEffectIconSpriteWidth = sprite_get_width(flowerEffectIconSprite);

flowerNameIconXoffset = 3;
selectedFlowerYoffset = 0;

ticksBeforeNextMoveResetVal = 10;
ticksBeforeNextMove = ticksBeforeNextMoveResetVal;
ticksBeforeNextMoveLeft = -1;
flowerScrollMovingDir = 0;

flowerStringNoFlower = lang_get_text("inventory.flower.none_selected");
flowerStringNotAtCampfire = lang_get_text("inventory.flower.no_campfire");
flowerStringFlowerInfoEffect = lang_get_text("inventory.flower.effect");
flowerStringFlowerInfoLocation = lang_get_text("inventory.flower.location");
flowerStringFlowerInfoPersistence = lang_get_text("inventory.flower.persistence");
flowerStringAddtoFlame = lang_get_text("inventory.flower.add_to_flame");
flowerStringCancelSelection = lang_get_text("inventory.flower.cancel_selection");
flowerStringAddMutator = lang_get_text("inventory.flower.add_mutator");
flowerStringNoEffects = lang_get_text("inventory.flower.no_active_effects");
flowerStringAlreadyHaveEffect = lang_get_text("inventory.flower.effect_already_have");
flowerStringAddMutator = lang_get_text("inventory.flower.add_mutators");

alreadyHasEffectHovering = false;

//Gotten On Switch
flowerStringFlowerName = "";
flowerStringFlowerDesc = "";
flowerStringFlowerEffect = "";
flowerStringFlowerLocation = "";
flowerStringFlowerPersistence = "";
flowerStringMutatorAdding = "";

flowerInfoSideSep = 5;
flowerDescWrapLength = 0;

mutatorSprite = sInventoryFlowerMutators;
mutatorSelected = 0;
mutatorSelectedSmooth = 0;
mutatorCount = sprite_get_number(mutatorSprite);

