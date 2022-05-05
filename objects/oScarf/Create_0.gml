/// @description 

event_inherited();

creator = noone;

scarfLength = 6;

restingDistances = 1.8;
mass = 1.15;

gravStr = 0.3;
gravDir = 270;

netForce = new Vector2();
netForce.set(lengthdir_x(gravStr, gravDir), lengthdir_y(gravStr, gravDir));

//
//

for (var j = 0; j < scarfLength; j++) {
		
	ds_list_add(points, new VerletPoint(x, y + j * restingDistances, j, mass));
	pointCount++;

	// Pin Top, Connect All Others to Prev
	if (j == 0) {
		points[| j].locked = true;
	} else {
		add_link(points[| j], points[| j-1]);}

}