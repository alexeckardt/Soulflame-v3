/// @desc

//Up
for (var i = 0; i < clothWidth; i++) {
	points[| i].pinX = oKeira.x;
	points[| i].pinY = oKeira.y;
}

//Update Points
for (var i = 0; i < pointCount; i++) {
	var point = points[| i];
	point.solveConstraints();
}


//Have Evetything Happen Afterwards
for (var i = 0; i < pointCount; i++) {
	var point = points[| i];
	point.updatePhysics();
}

