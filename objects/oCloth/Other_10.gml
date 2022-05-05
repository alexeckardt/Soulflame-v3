/// @desc Create Verlet Object


clothWidth = 15;
clothHeight = 15;

chanceToRemoveConnection = 2; //percent

allowMouseToCutEdges = true;

// midWidth: amount to translate the curtain along x-axis for it to be centered
// (curtainWidth * restingDistances) = curtain's pixel width

// Since this our fabric is basically a grid of points, we have two loops
for (var j = 0; j < clothHeight; j++) { // due to the way PointMasss are attached, we need the y loop on the outside
	for (var i = 0; i < clothWidth; i++) { 
		
	    var pointmass = new VerletPoint(x + i * restingDistances, y + j * restingDistances);
		pointmass.pointId = j*clothHeight + i;
	 
		ds_list_add(points, pointmass);
		pointCount++;
	  
	  
	    // attach to 
	    // x - 1  and
	    // y - 1  
	    //  *<---*<---*<-..
	    //  ^    ^    ^
	    //  |    |    |
	    //  *<---*<---*<-..
	    //
	    // attach to left
		randomize();
	    if (i != 0) {
			if (irandom(100) > chanceToRemoveConnection) {
				add_link(pointmass, points[| pointmass.pointId-1]);}}
			
	    // pin all to row above
		randomize();
	    if (j != 0){
			if (irandom(100) > chanceToRemoveConnection) {
				var aboveId = pointmass.pointId - clothWidth;
				add_link(pointmass, points[| aboveId]);}}
			
	    // we pin the very top PointMasss to where they are
	    if (j == 0) {
	    pointmass.locked = true;}

	}
}