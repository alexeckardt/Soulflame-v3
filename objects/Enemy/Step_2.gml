/// @desc

//Time set in Settings

//Lower Invulnerablity Ticks
invulnerableTicks -= time;
image_index += index_speed*time;
if (image_index + index_speed > image_number - index_speed) {
	image_index = 0;
}	

//Call Death
if (dead) {
	deadTicks += time;
	
	//Run Dead Events
	if (STATE == state.deadexplode) {
		event_user(2);}
	}
	
//Lerp Camera Weight
lerpCameraWeight = lerp(lerpCameraWeight, inCombatCamera, 0.1*time);