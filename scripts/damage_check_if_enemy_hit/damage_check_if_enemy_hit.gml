//
//DESC:
//
//Checks to see if a damage object has hit a specific enemy, so damage doesn't
//Continue to deal kb and damage if enemy is still touching it
//
function damage_check_if_enemy_hit(damageObj, enemyId) {

	var list = damageObj.enemiesHit;
	var count = ds_list_size(list);
	
	//Nothing In List, Therefor has not been hit before.
	if (count == 0) return false;
	
	//Check If Enemy Is Present In List
	for (var i = 0; i < count; i++) {
		var enemyHitByDamage = list[| i];
		
		//Compare
		if (enemyHitByDamage == enemyId) {
			
			//Has Been Hit
			return true;	
		}
	}	
	
	//Not Found.
	return false;
	
}