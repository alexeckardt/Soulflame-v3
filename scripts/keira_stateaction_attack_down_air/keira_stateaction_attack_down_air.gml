//
//DESC:
//
//
//
function keira_stateaction_attack_down_air(){

	//Set Sprite
	sprite_switch_to(attackSprite);
	index_speed = attackSpeed;
	displayReadyPosForTime = room_speed;
		
	//Update Direction Facing
	if (image_index < 1.5) {
			
		if (adjustDirectionFacingPreDamage) {
			var h = Controller.horizontalStick;
			directionFacing = (h != 0) ? sign(h) : directionFacing;	
		}
			
	} else {
		
		//Create Damage
		if (!createdDamage) {
			createdDamage = true;
				
			keira_geneirc_damage_create();
				
		} else {
				
			//Check If Damage Connected, If So, Jump and Transition to Base State
			//(Use Cool Animation Though)
			if (instance_exists(damageObj)) {
				if (damageObj.hasHitEnemyAllowUpdate) {
					
					//Bounce Complete
					allowControlOverIndex = -1;
					image_index = image_number;
					
					//Roccognize Jumo
					forceJump = true;
					bouncingOffEnemy = true;
					
					//Resend Dmg
					damageObj.hasHitEnemyAllowUpdate = false;
					
				}
			}
			
		}
		
	}
		
	//
	//Set Attributes
	inControl = image_index > allowControlOverIndex;
	resetStateOnAnimationFinish = true;

}