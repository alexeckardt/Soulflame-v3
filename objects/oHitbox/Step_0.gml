/// @desc Reccognize Thake Damage

//Update Bbox
image_xscale = hitboxWidth / sprW; 
image_yscale = hitboxHeight / sprW; 

//Damage Collision
var canTakeDamage = creator.invulnerableTicks < 0 && !hitboxLocked;

if (canTakeDamage) {
	if (instance_exists(oDamage)) {
	
		//Get List Of All Damages Meeting With Me (Don't want to damage self)
		var damageCollisionsFound = instance_place_list(x, y, oDamage, damagesMeeting, false);
		if (damageCollisionsFound > 0) {

			//Loop, See if one is NOT through my own creator
			for (var i = 0; i < damageCollisionsFound; i++) {
		
				//Check Creator
				var dmgObj = damagesMeeting[| i];
				if (dmgObj.creator != creator.id) {
					
					//Check If Allowed
					if (dmgObj.canDamageEnemies || isPlayerHitbox) {
				
						//Check Creator Not Already Taking Damage
						if (creator.hitboxTakingDamage == noone) {
								
							//Check If Creator has already been hit by this damage
							var hasBeenHitAlready = damage_check_if_enemy_hit(dmgObj, creator);
							if (!hasBeenHitAlready) {
								
								//Take Damage
								creator.hitboxTakingDamage = id;
								damagingObjectId = dmgObj;
								
							}
								
						}
					
						//Should No Longer Check
						break;
					}
				
				}
			}

			//
			//Reset List
			ds_list_clear(damagesMeeting)

		}
	}
}