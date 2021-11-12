/// @desc

//Follow
if (followCreator) {
	x = creator.x + xoffset;
	y = creator.y + yoffset;
}

var decay = (allowLifeDecay || creator.STATE == state.hurt) //Update this later

//Die After Time
life -= Game.delta*decay;
if (life < 0) {
	instance_destroy();
	destroyed = true
}	