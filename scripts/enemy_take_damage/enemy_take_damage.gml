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
	
	//No Damage Ticks
	noDamageAfterHurtTicksLeft -= Game.delta;
	
	//Check If a Hitbox has been hit
	if (hitboxTakingDamage != noone) {
	
		//LOL!
		var damageingObject = hitboxTakingDamage.damagingObjectId;
		var damageCreator = damageingObject.creator;
	
		var damageFromPlayer = damageCreator == instance_nearest(x, y, oKeira);
	
		//Send Info Back To Damage Object
		if (damageingObject.life > 1 && instance_exists(damageingObject)) {
			
			//Not If Destroyed 
			if (damageingObject.destroyed == false) {
				damageingObject.enemyHitCount++;
		
				if (ds_exists(damageingObject.enemiesHit, ds_type_list)) {
					ds_list_add(damageingObject.enemiesHit, id);
				}
				
				//
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
			var randomoffset = choose(0, 0, -1, 1) * Player.collectBalanceEssence;
			var chooseAlignment = sign(alignment + randomoffset);	
			
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
			var str = (knockbackStrength) / weight * doKnockback;

			//Add
			knockbackHSpeed += (lengthdir_x(str, dd) + damageingObject.addToHSpeed)*knockbackResistanceMulti / weight*doKnockback;
			knockbackVSpeed += (lengthdir_y(str, dd) + damageingObject.addToVSpeed)*knockbackResistanceMulti / weight*doKnockback;
			knockbackResistanceMulti /= 1.5;
			
			
		//Hit Effects
			var ssMulti = (hp <= 0) ? 3 : 1.5
			add_screen_shake_direction(damageDealt*ssMulti, dd, 0.3)
			
		//Hit Effect Object
		var hitEffectDirection = dd + random_range(-30, 30);
		var hitEffectScale = clamp(max(sprite_width, sprite_height ) / 32, 0.5, 1.5);
		hit_effect_create(hitboxTakingDamage.x, hitboxTakingDamage.y, hitEffectScale, c_white, hitEffectDirection)

		//Reset
		hitboxTakingDamage = noone;
			
		//Reccognizing
		invulnerableTicks = 5;
		justDamaged = true;
		timeSinceDamaged = 0;
		
		//Stagger Damage
		if (noDamageAfterHurtTicksLeft < 0) {
			noDamageAfterHurtTicksLeft = noDamageAfterHurtTime;}
		
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