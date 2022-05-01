/// @description 

var t = Game.delta;
//Time
life -= t;



//Mutate
spd += random_range(-spdWiggle, spdWiggle) + spdIncrease;
dir += random_range(-dirWiggle, dirWiggle);

//
//Gravity (Compounds and is unaffected by dir wiggle)
var spdUsing = spd;
var dirUsing = dir;

if (spdAbsolute && spd < 0) {
	spdUsing = 0;}


if (doGravity) {
	
	//Increase Grav Strength
	gravPull += gravStr;
	
	//Combine Vectors
	var hcomponent = lengthdir_x(spdUsing, dirUsing) + lengthdir_x(gravPull, gravDir);
	var vcomponent = lengthdir_y(spdUsing, dirUsing) + lengthdir_y(gravPull, gravDir);
	
	//Solve Vector
	spdUsing = point_distance(0, 0, hcomponent, vcomponent);
	dirUsing = point_direction(0, 0, hcomponent, vcomponent);
	
}

//Move
x += lengthdir_x(spdUsing, dirUsing) * t;
y += lengthdir_y(spdUsing, dirUsing) * t;

//
//
//

//Change Colour
if (fadeThroughLife) {
	
	//Life Percent (1 = full life left >>> 0 = dead)
	var lifep = 1 - life/startingLife;
	colour = merge_colour(startCol, endCol, lifep);
	
}

//End
if (life <= 0) {
	instance_destroy();
	exit;
}

//
//
//

image_index += index_speed;