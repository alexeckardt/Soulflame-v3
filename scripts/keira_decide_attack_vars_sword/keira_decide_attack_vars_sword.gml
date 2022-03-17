//
//
//Decices the Spirtes and the Damage Properties of the next Attack, then calls
//the setup function
//
function keira_decide_attack_vars_sword(_nextState) {
	
	
	//
	//Sword is much easier to use than basic combat.
	//No Tilts for streamline.
	//
	
	//Damage Properties
	var hTiltMulti = 1.1;
	var bD = Player.basePunchDamage * 2; //update this per type of attack
	var damage = bD;
	var damageType = damage_type.slash;
	
	//Visuals
	var readyShow = 0;//showReadyAfterAttackForBase * 5
	
	//Send To Script
	var spr = readySprite;
	var weaponOverlaySprite = -1;
	var spd = 0;
	var damageObjConsistants = [];
	
	//Default 'Non-Physical' Damage Behaviour
	damageToCollectEssence = false;
	damageToIncreaseCorruption = false;
	
	var baseSoeed = 0.4
	var kbM = 1.4;
	
	//Switch Based Off Attack
	switch (_nextState) {
		
		default:
		case state.combat_neutral:
		case state.combat_running:
		case state.combat_htilt:

			damage = bD;

			//Should Attack Upwards?

			spr = (useFrontAttackSprite) ? sKeiraAttackSwordHorizontal0 : sKeiraAttackSwordHorizontal1;
			weaponOverlaySprite = (useFrontAttackSprite) ? sWeaponSwordAttackHorizontal0 : sWeaponSwordAttackHorizontal1
			
			//DOn't go to ready spr
			readyShow = 0;
			
			spd = baseSoeed;
			damageObjConsistants = keira_damage_info_array_create(-20, -16, 75, 25, kbM, 0, -0.5, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 2;
			allowNextAttackAfterIndex = 4; //allow instant switch, low recovery time

			break;
		
		case state.combat_up:
		case state.combat_up_tilt:
		case state.combat_air_up_tilt:
		case state.combat_air_up:
		
			damage = bD*hTiltMulti;
		
			spr = sKeiraAttackSwordUp;
			weaponOverlaySprite = sWeaponSwordAttackUp;
			
			spd = baseSoeed;
			damageObjConsistants = keira_damage_info_array_create(-12, -50, 38, 44, kbM*.5, 0.2, -6, true);
			
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
				
			damageObjConsistants = keira_damage_info_array_create(-15, -10, 38, 25, kbM*0.5, slidingInDirection*3, -1.5, false);
				
			break;
			
		case state.combat_down:
		
			damage = bD;
		
			spr = sKeiraAttackNoWeaponGroundSweep;
			spd = 0.5;
			
			adjustDirectionFacingPreDamage = false;
			allowControlOverIndex = -1;
				
			damageObjConsistants = keira_damage_info_array_create(-32, -10, 68, 25, kbM, 0, -2, true);

				
			break;
		
		//
		//AIR
		//
		
		case state.combat_air_neutral:
			
			damage = bD*1.2;
			
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			damageObjConsistants = keira_damage_info_array_create(0, -16, 35, 15, kbM, 0, -0.5, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 2;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
	
			
		case state.combat_air_down:
			
			damage = bD*1.2;
			spr = (useFrontAttackSprite) ? sKeiraAttackNoWeaponPunch0 : sKeiraAttackNoWeaponPunch1;
			spd = 0.65;
			
			var w = 30;
			damageObjConsistants = keira_damage_info_array_create(-w/2, 13, w, 35, 4, 0, 1, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = 1;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			
			break;
			
		case state.combat_air_horizontal:
			
			damage = bD*hTiltMulti;
			spr = sKeiraAttackNoWeaponRunning;
			spd = 0.4;
			damageObjConsistants = keira_damage_info_array_create(-5, -16, 74,30, kbM*4, 0, -1, true);
			
			adjustDirectionFacingPreDamage = true;
			allowControlOverIndex = -1;
		
			//Stay In Air Longer
			forceHalfGravity = true;
			vSpeed += 1.5;
			
			break;
	}
	
	//Do The Setup
	keira_attacking_sprite_setup(spr, weaponOverlaySprite, spd, damage, damageType, damageObjConsistants, readyShow);
	
}