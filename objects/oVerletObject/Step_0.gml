/// @desc

var time = Game.delta;

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

