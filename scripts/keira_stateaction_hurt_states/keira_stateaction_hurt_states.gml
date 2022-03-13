//
//DESC:
//
//
//
function keira_stateaction_hurt_states(){

	//
	//Hurt State
	var hurtSprite = keira_get_movement_sprite("Hurt");
	sprite_switch_to(hurtSprite);
	index_speed = 0;

	//No Control
	inControl = false;
	
	//Don't Animate
	showLandAnimation = false;
	
	//Reset State
	if (STATE != state.hurt_spikes || dead) {
		hurtTicks -= Game.delta;
		if (hurtTicks < 0) {
			
			if (!dead) {
				STATE = state.base;	
			} else {
				STATE = state.dead;	
			}
			
		}
	}
}