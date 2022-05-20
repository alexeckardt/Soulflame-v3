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
headerSpriteSeperation = 128;

//
highlightedColour = c_white;
unhighlightedColour = c_gray;
