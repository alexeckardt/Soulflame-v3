/// @desc Reccognize Thake Damage

//Skip
if (!instance_exists(creator)) {exit;}

//Update Bbox
image_xscale = hitboxWidth / sprW; 
image_yscale = hitboxHeight / sprW; 

//Move With Creator

//Damage Collision
var canTakeDamage = creator.invulnerableTicks < 0 && !hitboxLocked;

if (canTakeDamage) {
	if (instance_exists(oDamage)) {
	
		//Get List Of All Damages Meeting With Me (Don't want to damage self)
		var damageCollisionsFound = instance_place_list(x, y, oDamage, damagesMeeting, false);
		if (damageCollisionsFound > 0) {

			//Loop, See if one is NOT through my own creator
			for (var i = 0; i < damageCollisionsFound; i++) {
		
				//Check Creator is not mine (ie don't damage self)
				var dmgObj = damagesMeeting[| i];
				if (dmgObj.creator != creator.id) {
					
					//Check If Allowed
					if (dmgObj.canDamageEnemies || isPlayerHitbox) {
				
						//Get Damage
						damagingObjectId = dmgObj;
						dmgObj.creator.justDamagedTarget = true;
						
						//Take Damage
						event_user(0);
						
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