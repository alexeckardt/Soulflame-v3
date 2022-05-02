/// @description 

event_inherited();

scarfLength = 7;

restingDistances = 2.5;
mass = 1.15;

scarfRestingXoffset = -1; //switches with directionFacing
scarfRestingYoffset = -8;

gravStr = 0.3;
gravDir = 270;



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