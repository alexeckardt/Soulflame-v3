//
//DESC:
//
//
//
function keira_stateaction_default() {
	
	
	var time = Game.delta;
	var running = onGround && controllerHorizontalMovementInput != 0 && inControl;		
		
	var currentIdleSprite = keira_get_movement_sprite("Idle");
	var currentReadySprite = keira_get_movement_sprite("IdleReady");
	var currentRunSprite = keira_get_movement_sprite("Run");
	var spriteKeyIs = "Idle";
		
	if (running) {
			
		displayReadyPosForTime = 0;
		index_speed = 0.4;
		
		sprite_switch_to(currentRunSprite);
		spriteKeyIs = "Run"
		
			
	} else {
			
		displayReadyPosForTime -= time;
		var idleSpr		= (displayReadyPosForTime > 0) ? currentReadySprite : currentIdleSprite;
			spriteKeyIs = (displayReadyPosForTime > 0) ? "IdleReady" : "Idle";
			
		sprite_switch_to(idleSpr);
		index_speed = 0.2;
			
	}
	
	//Control
	var giveControl = (true);
	var cutsceneObj = instance_nearest(x, y, Cutscene);
	if (cutsceneObj != noone) {
		giveControl = cutsceneObj.playerHasControlDuringCutscene;
	}
	
	inControl = giveControl;
	
	//Update Weapon Sprite
	weaponSprite = keira_get_movement_sprite_weapon(spriteKeyIs)
	
}