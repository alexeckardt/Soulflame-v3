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
	
	if (place_meeting(x, y+vSpeed, Solid) && vSpeed > 0) {
		vSpeed = (round(vSpeed * 0.6) div 2) * -2;	
		hSpeed = lerp(hSpeed, 0, .2);
		hasHitGroundOnce = true;
	}
	
	//Move
	x += hSpeed;
	y += vSpeed;
	
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