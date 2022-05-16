/// @description 

image_index += index_speed*Game.delta;
lifeTick += Game.delta;

var k = oKeira.id;

//Collect
if (autoPickup) {
	collected = true;
} else {
	if (hasHitGroundOnce && distance_to_point(k.x, k.y) < 14) {
		if (!collected && lifeTick > collectionAfterTime) {	
			collected = true;
		}
	}
}
	
{
	//Normal Movement
	vSpeed += grav;
	hSpeed = lerp(hSpeed, 0, 1/weight/10*Game.delta);
	
	//Bounce
	if (place_meeting(x, y+vSpeed, Solid) && vSpeed > 0) {
		vSpeed = (round(vSpeed * (1/sqrt(weight))) div bounceEnergyLossMultiplier) * -bounceEnergyLossMultiplier;	
		hSpeed = lerp(hSpeed, 0, .2);
		hasHitGroundOnce = true;
		shouldDealDamage = false;
	}
	
	//Collide + Move	
	generic_collide_solid();
}

//Collect Money
if (collected) {
	
	Player.platinum += value;
	
	particle_create_platinum_sparkle_around_player(ceil(sqrt(value*3)));
	
	//var snds = [sndPlatinumPickup0, sndPlatinumPickup1];
	//sound_effect_create(snds, 2, choose(0.8, 0.9, 1, 1.1, 1.2), 0.6);
	instance_destroy();
}

//Emit
randomize();
var emitOne = (random(100) < 1);
if (emitOne) {
	
	//Lag Prevent
	if (instance_number(Light) < 80) {
		emitOne = random(instance_count) < 10;
	}
		
	if (emitOne) {
		create_platinum_light_particles( emitOne, x - 2, x + 2, y - 2, y + 2, 0.25);
	}
}

//Damage
if (shouldDealDamage) {

	//Create Damage
	if (!instance_exists(myDamage) || myDamage == noone) {
		myDamage = damage_create_ext(damage_type.untyped, 1, x, y, 2, 2);
		myDamage.canDamageEnemies = false;
	}
	
} else {
	
	//Destroy Damage
	if (instance_exists(myDamage)) {
		instance_destroy(myDamage);	
	}
	
}
