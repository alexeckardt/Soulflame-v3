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
	
	//Reset State
	hurtTicks -= Game.delta;
	if (hurtTicks< 0) {
		STATE = state.base;	
	}

}