//
//DESC:
//
//
//
function keira_stateaction_default() {
	
	var mmx = (inControl) ? mx : lastNoControlMX;
	
	if (!inControl) {
		var hi = false;	
	}
	
	var time = Game.delta;
	var running = onGround && mmx != 0;		
		
	var currentIdleSprite = keira_get_movement_sprite("Idle");
	var currentReadySprite = keira_get_movement_sprite("IdleReady");
	var currentRunSprite = keira_get_movement_sprite("Run");
	var spriteKeyIs = "Idle";
			
	if (running) {
			
		displayReadyPosForTime = 0;
		index_speed = 0.4;
		
		sprite_switch_to(currentRunSprite);
		spriteKeyIs = "Run";
		
		randomize();
		if (irandom(100) < 10) {
			particle_create_dust(x-3+hSpeed, y+6, x+3+hSpeed, y+7, choose(1, 2, 3));
		}
		
			
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