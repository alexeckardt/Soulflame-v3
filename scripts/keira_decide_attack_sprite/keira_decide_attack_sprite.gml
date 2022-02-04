//
//DESC:
//
//
//
function keira_decide_attack_sprite(_nextState) {

	//info based on sprite
	allowControlOverIndex = -1;
	
	
	switch (Player.weaponUsing) {
	
		case weapon.none:
		default:
			keira_decide_attack_vars_no_weapon(_nextState);break;
			
		case weapon.sword:
			keira_decide_attack_vars_sword(_nextState);break;

	}
	
	
	//Pre Fill Based On Sprite
		//Control Sprite; Default to After Sprite is finished
		allowControlOverIndex = (allowControlOverIndex == -1)
									? sprite_get_number(attackSprite)
									: allowControlOverIndex;
}

