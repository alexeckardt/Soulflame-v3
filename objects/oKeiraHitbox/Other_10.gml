/// @desc PLayer Taking Damage


var otherDamage = damagingObjectId;
var enemyWhoHitMe = otherDamage.creator;
var Keira = oKeira.id;

//Send Info Back To Damage Object
if (otherDamage.life > 0) {
			
	//Not If Destroyed 
	otherDamage.enemyHitCount++;
	ds_list_add(otherDamage.enemiesHit, id);
	otherDamage.hasHitEnemy = true;
	otherDamage.hasHitEnemyAllowUpdate = true;
	
}
			
//Take Damage
Player.hp--;

//Hit Effect
var d = point_direction(otherDamage.x, otherDamage.y, x, y);
//screen_shake_with_direction(5, d, 10);


//Player State
Keira.STATE = state.hurt;
Keira.hurtTicks = Keira.hurtFlinchTime;
Keira.invulnerableTicks = Keira.invulnerableTime;


//Destroy Keira's Damages
damage_via_owner_destroy(Keira);

//Knockback Keira
var knockbackStrength = otherDamage.knockbackAmount;
		
	//Vector
	var kbFromX = otherDamage.knockbackFromX - enemyWhoHitMe.hSpeed;
	var kbFromY = otherDamage.knockbackFromY - enemyWhoHitMe.vSpeed;
	var dd = point_direction(kbFromX, kbFromY, x, y);
	
	var enemyVelocity = point_distance(0, 0, enemyWhoHitMe.hSpeed, enemyWhoHitMe.vSpeed);
	var str = (knockbackStrength + enemyVelocity/2) / Keira.weight;

	//Add
	Keira.knockbackHSpeed += lengthdir_x(str, dd) + otherDamage.addToHSpeed;
	Keira.knockbackVSpeed += lengthdir_y(str, dd) + otherDamage.addToVSpeed;
	
	