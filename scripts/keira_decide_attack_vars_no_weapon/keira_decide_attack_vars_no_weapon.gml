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
	
	//Visual
	var readyShow = showReadyAfterAttackForBase;
		
	//All no weapon attacks should follow these properties
	damageToCollectEssence = true;
	damageToIncreaseCorruption = true;
	
	//Switch Based Off Attack
	switch (_nextState) {
		
		default:
		case state.combat_neutral:
			
			damage = bD/2;
			
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.6;
			damageObjConsistants = keira_damage_info_array_create(0, -16, 35, 15, 1, 0, -0.5, true);
			
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
			
			break;
		
		case state.combat_htilt:
		
			damage = bD*hTiltMulti;
			
			spr = sKeiraAttackNoWeaponHTilt;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-5, -24, 74, 30, 2.5, 0, -3, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			break;
		
		case state.combat_running:
		
			damage = bD*hTiltMulti;
			
			spr = sKeiraAttackNoWeaponRunning;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-5, -10, 74, 30, 3, 0, -3, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			//Push Off
			controlVSpeed = -4;
			onGround = false;
			noControlMx = directionFacing;
			inControl = false;
			
			controlHSpeed = directionFacing * runSpeed * 1.6;
			
			break;
		
		case state.combat_up:
		
			damage = bD*hTiltMulti;
		
			spr = sKeiraAttackNoWeaponUppercut;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-12, -50, 38, 44, .5, 0.2, -6, true);
			
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = 4;
			
			//controlVSpeed += jumpSpeed/8
			
			break;
		
		case state.combat_slide:
		
			damage = bD*1.25;
		
			spr = sKeiraAttackSlide;
			spd = 0.5;
			
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
			slidingInDirection = directionFacing;
			slideSpeed = slideMaxSpeed;
			slideExitSpeed = slideExitSpeedBase;
				
			damageObjConsistants = keira_damage_info_array_create(-15, -10, 38, 25, 0.5, slidingInDirection*3, -1.5, false);
				
			break;
			
		case state.combat_down:
		
			damage = bD;
		
			spr = sKeiraAttackNoWeaponGroundSweep;
			spd = 0.5;
			
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
				
			damageObjConsistants = keira_damage_info_array_create(-32, -10, 68, 25, 1, 0, -2, true);

			break;
		
		//
		//AIR
		//
		
		case state.combat_air_neutral:
			
			damage = bD*1.2;
			
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			damageObjConsistants = keira_damage_info_array_create(0, -16, 35, 15, 1, 0, -0.5, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 2;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
		
		case state.combat_air_up:
			
			damage = bD*1.2;
			spr = sKeiraAttackNoWeaponUppercut;
			spd = 0.4;
			var vAdd = -4 + min(controlVSpeed, 0)
			damageObjConsistants = keira_damage_info_array_create(-12, -50, 38, 44, 1.5, 0, vAdd, true);
			
			adjustDirectionFacingPreDamage = false;
			forceHalfGravity = true;
			allowControlOverIndex = 1;
			
			//Stay In Air Longer
			if (controlVSpeed < 0) {
				controlVSpeed += jumpSpeed * combatInAirJumpCoefficient;
			} else {
				controlVSpeed /= 2;}
			
			break;
			
		case state.combat_air_down:
			
			damage = bD*1.2;
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			
			var w = 30;
			damageObjConsistants = keira_damage_info_array_create(-w/2, 8, w, 25, 4, 0, 1, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 1;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
			
		case state.combat_air_horizontal:
			
			damage = bD*hTiltMulti;
			spr = sKeiraAttackNoWeaponRunning;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-5, -16, 74,30, 4, 0, -1, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			vSpeed += 1.5;
			controlHSpeed = directionFacing * runSpeed * 1.2;
			
			break;
	}


	//Do The Setup
	keira_attacking_sprite_setup(spr, weaponOverlaySprite, spd, damage, damageType, damageObjConsistants, readyShow);
	
	
	
}