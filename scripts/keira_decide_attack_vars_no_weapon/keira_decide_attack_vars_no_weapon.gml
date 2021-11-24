//
//
//Decices the Spirtes and the Damage Properties of the next Attack, then calls
//the setup function
//
function keira_decide_attack_vars_no_weapon(_nextState) {
	
	//Multipliers
	var hTiltMulti = 1.1;
	var bD = Player.basePunchDamage;
	
	//Send To Script
	var spr = readySprite;
	var weaponOverlaySprite = -1;
	var spd = 0;
	var damageObjConsistants = [];

	var damage = bD;
	var damageType = damage_type.impact;
	
	//Switch Based Off Attack
	switch (_nextState) {
		
		default:
		case state.combat_neutral:
			
			damage = bD;
			
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.75;
			damageObjConsistants = keira_damage_info_array_create(0, -16, 35, 15, 4, 0, -0.5, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			break;
		
		case state.combat_htilt:
		
			damage = bD*hTiltMulti;
			
			spr = sKeiraPunchHeavyFront;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-5, -40, 74, 30, 6, 0, -3, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			break;
		
		case state.combat_running:
		
			damage = bD*hTiltMulti;
			
			spr = sKeiraAttackNoWeaponRunning;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-5, -40, 74, 30, 6, 0, -3, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			controlVSpeed = -2
			
			break;
		
		case state.combat_up:
		
			damage = bD*hTiltMulti;
		
			spr = sKeiraUppercut;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-10, -80, 50, 64, 1.5, 0, -9, true);
			
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = 4;
			
			break;
		
		case state.combat_slide:
		
			damage = bD*1.25;
		
			spr = sKeiraSlideActivate;
			spd = 0.5;
			damageObjConsistants = keira_damage_info_array_create(-25, -20, 48, 30, 6, slidingInDirection*3, -3, true);

			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
			slidingInDirection = directionFacing;
			slideSpeed = slideMaxSpeed;
			slideExitSpeed = slideExitSpeedBase;
				
			break;
		
		
		//
		//AIR
		//
		
		case state.combat_air_neutral:
			
			damage = bD*1.2;
			
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.25;
			damageObjConsistants = keira_damage_info_array_create(0, -32, 45, 15, 4, 0, -0.5, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 2;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
		
		case state.combat_air_up:
			
			damage = bD*1.2;
			spr = sKeiraUppercut;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-18, -80, 65, 64, 2, 0, -7, true);
			
			adjustDirectionFacingPreDamage = false;
			forceHalfGravity = true;
			allowControlOverIndex = 1;
			
			//Stay In Air Longer
			vSpeed = min(0, vSpeed) + jumpSpeed * combatInAirJumpCoefficient;
			if (vSpeed > 0) {
				vSpeed /= 2;}
			
			break;
			
		case state.combat_air_down:
			
			damage = bD*1.2;
			spr = (useFrontAttackSprite) ? sKeiraPunch0Front : sKeiraPunch0Back;
			spd = 0.65;
			
			var w = 30;
			damageObjConsistants = keira_damage_info_array_create(-w/2, -16, w, 32, 4, 0, 1, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 1;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
			
		case state.combat_air_horizontal:
			
			damage = bD*hTiltMulti;
			spr = (useFrontAttackSprite) ? sKeiraPunch0Front : sKeiraPunch0Back;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-5, -40, 74,30, 8, 0, 0, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			vSpeed += 1.5;
			
			break;
	}
	
	//Do The Setup
	keira_attacking_sprite_setup(spr, weaponOverlaySprite, spd, damage, damageType, damageObjConsistants);
	
}