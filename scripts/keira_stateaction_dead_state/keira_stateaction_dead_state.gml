//
//DESC:
//
//
//
function keira_stateaction_dead_state(){

	//
	//Hurt State
	var deadSprite = keira_get_movement_sprite("Dead");
	sprite_switch_to(deadSprite);
	index_speed = 0;

	//No Control
	inControl = false;
	
	//Don't Animate
	showLandAnimation = false;
	
	//Dont Exit State EVER (Only on new object create, ie room switch)

}