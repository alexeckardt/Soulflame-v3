/// @desc

//
//	Verlet Integration; Followed by
//	https://gamedevelopment.tutsplus.com/tutorials/simulate-tearable-cloth-and-ragdolls-with-simple-verlet-integration--gamedev-519
//

//Setup
event_user(0);

//
points = ds_list_create();
links = ds_list_create();
pointCount = 0;
linkCount = 0;

draw = true;

allowMouseToCutEdges = false;

restingDistances = 4;
surfaceTension = 1/10;

hSpeedCoefficient = 0.8;
vSpeedCoefficient = 0.7;

basicWaveAmplitude = 0.15; //remeber that the drag forces it back
wavePeriodMultiplier = 0.25;

visualWaveSpeed = 1/50;
visualWaveFreq = 20 * (sprite_height / 64); //consistant through testing
visualWaveAmp = 1/132;

blendcol = bgr($47c6de);

topRestCol = bgr($2a5e56);
topTurbulantCol = bgr($bdefe7);

var waterSurfaceSegments = sprite_width div  restingDistances;

// Since this our fabric is basically a grid of points, we have two loops
for (var i = 0; i < waterSurfaceSegments; i++) { 
		
	var pointmass = new VerletPoint(x + i * restingDistances, y);
	pointmass.pointId = i;
	pointmass.doCollision = true;
	 
	ds_list_add(points, pointmass);
	pointCount++;

	//Attatch Left
	if (i != 0) {
		add_link(pointmass, points[| pointmass.pointId-1]);}

}

//
//
//New Points, No Physics because they're not on the list
pointmassLeft = new VerletPoint(x - 1, y);
pointmassRight = new VerletPoint(x + sprite_width + 1, y);

//Lock Endpoints
pointmassLeft.locked = true;
pointmassLeft.pointId = -1;
pointmassRight.locked = true;
pointmassRight.pointId = -1;

//Fix Issue
points[| 0].doCollision = false;

//Connect Points
add_link( points[| 0], pointmassLeft, 1);
add_link( pointmassRight,points[| pointCount-1], 1);

//
//
//Vertexes
vertex_format_begin();
vertex_format_add_position();
vf = vertex_format_end();
vb = vertex_create_buffer();
wroteToBuffer = false;

//Water Surf
waterSurf = -1;
waterSurfaceEdgeBuffer = 32;
