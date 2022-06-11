/// @description 


//Teleport Player
if (!firstRoom) {
	
	var k = oKeira;
	
	//Don't Do Keira Stuff
	if (room != roomTitle) {
	
		//Positions
		k.x = roomStartPlayerX;
		k.y = roomStartPlayerY;
		k.orgX = roomStartPlayerX;
		k.orgY = roomStartPlayerY;
		k.directionFacing = roomStartPlayerD;
	
		//Make Player Start On Ground
		if (k.y > 0 && k.y < room_height) {
		
			var spr = oKeira.sprite_index;
			var sprOffset = (sprite_get_bbox_bottom(spr) - sprite_get_yoffset(spr)) + 4;
			for (var j = oKeira.y; j < room_height; j += 4) {
				if (position_meeting(oKeira.x, j+sprOffset, Solid)) {
					oKeira.y = j;
					break;	
				}
			}
		
		}
		
		//Spike Position Default
		k.spikeResetPositionX = k.x;
		k.spikeResetPositionY = k.y;
		k.spikeResetPositionD = k.directionFacing;
	
	}
	
	//Create Transition From Fade in
	var ar = fadeInTransitionInfo;
	var transition = transition_create(ar[0], undefined, 0, 0, 0, -1, ar[1], ar[2], ar[3]);
	transition.independentDelta = roomStartindependentDelta;
	Game.paused = false;
	
	//Dead Respawn
	if (loadRoomAsRespawn) {
		
		loadRoomAsRespawn = false;
		hp = baseMaxHealth;
		
		//Check If Campfire Near; Sit Down Near It.
		
		//Reset
		ds_list_clear(essenceTokens);
		essenceTokensHolding = 0;
		
	}
	
}
firstRoom = false;

//Other
Game.inventoryOpen = false;
