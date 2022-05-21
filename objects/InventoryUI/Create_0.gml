/// @desc

//Draw Ontop of Player's UI
depth = Player.depth - 10;

close = false;
openAlpha = 0;

page = 0;
pageNames = ["Items", "Map", "Artifacts", "Flowers"];
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

//Edges
drawEdgeHBuffer = 12;
drawEdgeVBuffer = 4;

//Lines
sectionDividerLineEdgeBuffer = 25;


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
//FLOWERS




//
//
//ARTIFACTS
