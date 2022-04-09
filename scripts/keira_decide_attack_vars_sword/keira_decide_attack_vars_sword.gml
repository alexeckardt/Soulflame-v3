//
//
//Decices the Spirtes and the Damage Properties of the next Attack, then calls
//the setup function
//
function keira_decide_attack_vars_sword(_nextState, damageStruct) {
	
	
	//
	//Sword is much easier to use than basic combat.
	//No Tilts for streamline.
	//
	
	//Multipliers (Reuse)
	var baseSoeed = 0.4
	var kbM = 1.4;
	var hTiltMulti = 1.1;
	var bD = Player.basePunchDamage * 2; //update this per type of attack
	
	//Send To Script
	var spr = readySprite;
	var weaponOverlaySprite = -1;
	var spd = 0;
	var readyShow = 0;//showReadyAfterAttackForBase * 5 //Don't go to ready sprite
	
	//Damage Properties
	damageStruct.damage = bD;
	damageStruct.damageType = damage_type.slash;
	//Default 'Non-Physical' Damage Behaviour
	damageStruct.collectEssence = false;
	damageStruct.increaseCorruption = false;
	
	
	
	//Switch Based Off Attack
	switch (_nextState) {
		
		default:
		case state.combat_neutral:
		case state.combat_running:
		case state.combat_htilt:

			//Should Attack Upwards?

			spr = (useFrontAttackSprite) ? sKeiraAttackSwordHorizontal0 : sKeiraAttackSwordHorizontal1;
			weaponOverlaySprite = (useFrontAttackSprite) ? sWeaponSwordAttackHorizontal0 : sWeaponSwordAttackHorizontal1
			spd = baseSoeed;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 2;
			allowNextAttackAfterIndex = 4; //allow instant switch, low recovery time
			
			
			keira_damage_update_struct(damageStruct, -20, -16, 75, 25, kbM, 0, -0.5, true);
			

			break;
		
		case state.combat_up:
		case state.combat_up_tilt:
		case state.combat_air_up_tilt:
		case state.combat_air_up:
		
			//Visual and Control
			spr = sKeiraAttackSwordUp;
			weaponOverlaySprite = sWeaponSwordAttackUp;
			spd = baseSoeed;
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = 4;
			
			//Damage
			damageStruct.damage = bD*hTiltMulti;
			keira_damage_update_struct(damageStruct, -12, -58, 32, 68, kbM*.5, 0.2, -6, true);
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
			
			//Damage
			damageStruct.damage = bD*1.25;
			keira_damage_update_struct(damageStruct, -15, -10, 38, 25, kbM*0.5, slidingInDirection*3, -1.5, false);
				
			break;
			
		case state.combat_down:
		
			spr = sKeiraAttackNoWeaponGroundSweep;
			spd = 0.5;
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
				
				
			keira_damage_update_struct(damageStruct, -32, -10, 68, 25, kbM, 0, -2, true);

			break;
		
		//
		//AIR
		//
		
		case state.combat_air_neutral:
			
			//Control
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 2;
			
			//Damage
			damageStruct.damage = bD*1.2;
			keira_damage_update_struct(damageStruct, 0, -16, 35, 15, kbM, 0, -0.5, true);
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
	
			
		case state.combat_air_down:
			
			//Spr
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 1;
			
			//Damage
			damageStruct.damage = bD*1.2;
			var w = 30;
			keira_damage_update_struct(damageStruct, -w/2, 13, w, 35, 4, 0, 1, true);

			//Stay In Air Longer
			forceHalfGravity = true;
			break;
			
		case state.combat_air_horizontal:
			
			//Sprite and Control
			spr = sKeiraAttackNoWeaponRunning;
			spd = 0.4;
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
			
			
			damageStruct.damage = bD*hTiltMulti;
			keira_damage_update_struct(damageStruct, -5, -16, 74,30, kbM*4, 0, -1, true);
			
			//Stay In Air Longer
			forceHalfGravity = true;
			vSpeed += 1.5;
			
			break;
	}

	//Do The Setup
	keira_attacking_sprite_setup(spr, weaponOverlaySprite, spd, readyShow);
	
	//Save the Damage Struct
	damageToCreateStruct = damageStruct;
	
}