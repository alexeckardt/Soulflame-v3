/// @desc

var time = Game.delta;

//Lower Invulnerablity Ticks
invulnerableTicks -= time;
deadTicks += time*(dead);

image_index += index_speed*time;