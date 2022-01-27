//
//DESC:
//
//Generic Function For Enemies Taking Damage.
//
function enemy_take_damage() {

	//Reset
	justDamaged = false;
	justDied = false;
	timeSinceDamaged += Game.delta;
	
	//Check If a Hitbox has been hit
	if (hitboxTakingDamage != noone) {
	
		//LOL!
		var damageingObject = hitboxTakingDamage.damagingObjectId;
		var damageCreator = damageingObject.creator;
	
		var damageFromPlayer = damageCreator == instance_nearest(x, y, oKeira);
	
		//Send Info Back To Damage Object
		if (damageingObject.life > 1) {
			
			//Not If Destroyed 
			if (damageingObject.destroyed == false) {
				damageingObject.enemyHitCount++;
		
				ds_list_add(damageingObject.enemiesHit, id);
				damageingObject.hasHitEnemy = true;
				damageingObject.hasHitEnemyAllowUpdate = true;
			}
		}
	
		//Grab Info
		var baseDamage = damageingObject.damage;
	
		//Take Damage
			var damageDealt = baseDamage;
			hp -= damageDealt;
		
		
		//Release Essence
		if (damageingObject.collectEssence) {
			var manaLost = essenceDropPerDamage * baseDamage;
			var chooseAlignment = sign(alignment + choose(0, 0, -1, 1));	
			
			//Release Visual Particles
						
			//Essence Addition
			if (damageFromPlayer) {
				
				//Add Tokens To Players
				essence_token_add_percent(chooseAlignment, manaLost);
				
			} else {
				
				//Update Enemy Killed Amount (Used for switching corruption for certian enemies)
				//Unimplemented
			}	
				
		}
			
		//Add Corruption To Player
		if (damageFromPlayer) {
			if (damageingObject.increasePlayerCorruption) {
				corruption_add(alignment, Game.corruption_CollectEssenceIncrease);
			}
		}
		
		//Knockback
			var knockbackStrength = damageingObject.knockbackAmount;
		
			//Vector
			var dd = point_direction(damageingObject.knockbackFromX, damageingObject.knockbackFromY, x, y);
			var str = (knockbackStrength) / weight;

			//Add
			knockbackHSpeed += lengthdir_x(str, dd) + damageingObject.addToHSpeed;
			knockbackVSpeed += lengthdir_y(str, dd) + damageingObject.addToVSpeed;
			
			
		//Hit Effects
			var ssMulti = (hp <= 0) ? 3 : 1.5
			//screen_shake_with_direction(damageDealt*ssMulti, dd, damageDealt*8)
			
		//Hit Effect Object
		var hitEffectDirection = dd + random_range(-30, 30);
		var hitEffectScale = clamp(max(sprite_width, sprite_height ) / 32, 0.5, 1.5);
		hit_effect_create(x, y, hitEffectScale, c_white, hitEffectDirection)

		//Reset
		hitboxTakingDamage = noone;
		invulnerableTicks = 5;
		justDamaged = true;
		timeSinceDamaged = 0;
		
		//Dead Detect
		if (!dead) {
			if (hp <= 0) {
				dead = true;
				justDied = true;
				deathHeadingDirection = dd;
				
				//Auto Switch (Stagger)
				if (autoSwitchToDeadState) {
					STATE = state.dead;	
				}
			}
		}	
	}

}