//
//DESC:
//
//
//
function keira_update_movement_sprites() {

	//Setup The Sprite per Weapon
	function keira_assign_sprite(slot, keiraSpr = sKeiraIdle, weaponSpr = -1) {
		SpriteMap[? slot] = [keiraSpr, weaponSpr]
		return -1;	
	}

	switch (Player.weaponUsing) {
		
		default:
			
			keira_assign_sprite("Idle",			sKeiraIdle);
			keira_assign_sprite("IdleReady",	sKeiraIdleReadyNoWeapon);
			keira_assign_sprite("Run",			sKeiraRunNoWeaponTest);
			
			//Not Animated Yet
			keira_assign_sprite("ClimbAttach",	sKeiraClimbAttatch);
			keira_assign_sprite("ClimbIdle",	sKeiraClimbIdle);
			keira_assign_sprite("ClimbEdgeHold", sKeiraClimbEdgeHold);;
			
			keira_assign_sprite("Land", sKeiraLandStanding);
			keira_assign_sprite("LandRunning", sKeiraLandRunning);
			
			keira_assign_sprite("Hurt", sKeiraHurt);
			
		
		break;
		case weapon.sword:
		
			keira_assign_sprite("Idle",			sKeiraIdleSword,		sWeaponSwordIdle);
			keira_assign_sprite("IdleReady",	sKeiraIdleReadySword,	sWeaponSwordIdleReady);
			keira_assign_sprite("Run",			sKeiraRunSword,			sWeaponSwordRun);
			
			keira_assign_sprite("Climb")
			keira_assign_sprite("WallHold")
			
			keira_assign_sprite("Land", sKeiraLandStanding)
			keira_assign_sprite("LandRunning", sKeiraLandRunning)
			
	}


}

