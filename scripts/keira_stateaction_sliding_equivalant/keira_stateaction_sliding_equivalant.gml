//
//DESC:
//
//
//
function keira_stateaction_sliding_equivalant() {
	
	sprite_switch_to(attackSprite);
	index_speed = attackSpeed;
	inControl = false;
		
	//Stay In Loop
	if (attackSprite = slideActivateSprite) {
		if (image_index + index_speed >= image_number - index_speed) {
			attackSprite = slideLoopSprite;
		}
	}
		
	//Create Damage
	if (!createdDamage) {
		createdDamage = true;
		
		haveSlideDamage = true;
				
		keira_geneirc_damage_create();
			
		damageObj.allowLifeDecay = false;
		damageObj.followCreator = true;
		
	} else {
		
		//If Hit Enemy, Cut Speed
		if (damageObj.hasHitEnemyAllowUpdate) {
			damageObj.hasHitEnemyAllowUpdate = false;
			slideSpeed = lerp(slideSpeed, 0, 0.5);
				
			slideExitSpeed += 0.2;
	
		}	
		
	}
	
	//Reduce Speed
	slideSpeed = lerp(slideSpeed, 0, slideSpeedReduction);
	//noControlMx = directionFacing;
	
	//Set State To Recovery State
	if (slideSpeed < slideExitSpeed) {
		STATE = state.combat_slide_recover;
		damageObj.allowLifeDecay = true;
		damageObj.life = -1;
		haveSlideDamage = false;
	}

}