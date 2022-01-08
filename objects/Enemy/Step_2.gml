/// @desc

var time = Game.delta;

//Lower Invulnerablity Ticks
invulnerableTicks -= time;
image_index += index_speed*time;

//Call Death
if (dead) {
	deadTicks += time;
	
	//Run Dead Events
	if (STATE == state.deadexplode) {
		event_user(2);}
	}