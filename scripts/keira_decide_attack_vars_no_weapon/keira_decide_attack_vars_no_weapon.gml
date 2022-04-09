//
//
//Decices the Spirtes and the Damage Properties of the next Attack, then calls
//the setup function
//
function keira_decide_attack_vars_no_weapon(_nextState, damageStruct) {
	

	//Send To Script
	var spr = readySprite;
	var weaponOverlaySprite = -1;
	var spd = 0;
	//Visual
	var readyShow = showReadyAfterAttackForBase;
		
		
	//Multipliers (Re-use)
	var hTiltMulti = 1.1;
	var bD = Player.basePunchDamage;	
	
		
	//
	//Create Damage
	damageStruct.damage = bD;
	damageStruct.damageType = damage_type.impact;
	//All no weapon attacks should follow these properties
	damageStruct.collectEssence = true;
	damageStruct.increaseCorruption = true;

	
	//
	//
	//Switch Based Off Attack
	switch (_nextState) {
		
		default:
		case state.combat_neutral:
		case state.combat_down:
			
			
			//Update Sprite + Control
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.6;
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
			
			//Update Damage
			damageStruct.damage = bD/2;
			keira_damage_update_struct(damageStruct, 0, -16, 35, 15, 1, 0, -0.5, true);
			
			break;
		
		case state.combat_htilt:

			//Update Sprite + Control
			spr = sKeiraAttackNoWeaponHTilt;
			spd = 0.4;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			//Update Damage
			damageStruct.damage = bD*hTiltMulti;
			keira_damage_update_struct(damageStruct, -5, -24, 54, 30, 2.5, 0, -3, true);

			break;
		
		case state.combat_running:
		
			//Sprite + Control
			spr = sKeiraAttackNoWeaponRunning;
			spd = 0.4;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			//Damage Update
			damageStruct.damage = bD*hTiltMulti;
			keira_damage_update_struct(damageStruct,-5, -10, 74, 30, 3, 0, -3, true);
			
			//Push Off Ground + Mutaors
			vSpeed = -4;
			controlVSpeed = 0;
			onGround = false;
			noControlMx = directionFacing;
			inControl = false;
			controlHSpeed = directionFacing * runSpeed * 1.6;
			
			break;
		
		case state.combat_up:
		case state.combat_up_tilt:
		
			//Spr
			spr = sKeiraAttackNoWeaponUppercut;
			spd = 0.4;
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = 4;
			
			//Damage
			damageStruct.damage = bD*hTiltMulti;
			keira_damage_update_struct(damageStruct,-12, -50, 38, 44, .5, 0.2, -6, true);
			
			//controlVSpeed += jumpSpeed/8
			
			break;
		
		case state.combat_slide:
		
			//Sprite + Control
			spr = sKeiraAttackSlide;
			spd = 0.5;
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
			slidingInDirection = directionFacing;
			slideSpeed = slideMaxSpeed;
			slideExitSpeed = slideExitSpeedBase;
					
			damageStruct.damage = bD*1.25;
			keira_damage_update_struct(damageStruct,-15, -10, 38, 25, 0.5, slidingInDirection*3, -1.5, false);
				
			break;
			
		case state.combat_down_tilt:
		
			//Sprite + Control
			spr = sKeiraAttackNoWeaponGroundSweep;
			spd = 0.5;
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
			
			damageStruct.damage = bD;
			keira_damage_update_struct(damageStruct,-32, -10, 68, 25, 1, 0, -2, true);

			break;
		
		//
		//AIR
		//
		
		case state.combat_air_neutral:
		
			//Sprite + Control
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 2;
			
			damageStruct.damage = bD*1.2;
			keira_damage_update_struct(damageStruct,0, -16, 35, 15, 1, 0, -0.5, true);
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
		
		case state.combat_air_up:
		case state.combat_air_up_tilt:
			
			//Sprite + Control
			spr = sKeiraAttackNoWeaponUppercut;
			spd = 0.4;
			adjustDirectionFacingPreDamage = false;
			forceHalfGravity = true;
			allowControlOverIndex = 1;
			
			damageStruct.damage = bD*1.2;
			var vAdd = -4 + min(controlVSpeed, 0)
			keira_damage_update_struct(damageStruct,-12, -50, 38, 44, 1.5, 0, vAdd, true);
			
			
			//Stay In Air Longer
			if (controlVSpeed < 0) {
				controlVSpeed += jumpSpeed * combatInAirJumpCoefficient;
			} else {
				controlVSpeed /= 2;}
			
			controlVSpeed -= 1;
			
			break;
			
		case state.combat_air_down:
		case state.combat_air_down_tilt:
			
			//Sprite + Control
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 1;
		
			var w = 30;
			damageStruct.damage = bD*1.2;
			keira_damage_update_struct(damageStruct,-w/2, 8, w, 35, 4, 0, 1, true);
			
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
			
		case state.combat_air_horizontal:
		case state.combat_air_htilt:
			
			//Sprite + Control
			spr = sKeiraAttackNoWeaponRunning;
			spd = 0.4;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
		
			damageStruct.damage = bD*hTiltMulti;
			keira_damage_update_struct(damageStruct,-5, -16, 74,30, 4, 0, -1, true);
		
		
			//Stay In Air Longer
			forceHalfGravity = true;
			vSpeed += 1.5;
			controlHSpeed = directionFacing * runSpeed * 1.2;
			
			break;
	}


	//Do The Setup
	keira_attacking_sprite_setup(spr, weaponOverlaySprite, spd, readyShow);
	
	//Save the Damage Struct
	damageToCreateStruct = damageStruct;
	
	
}