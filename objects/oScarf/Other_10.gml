/// @desc Create Verlet Object

clothHeight = 15;
clothWidth = 2;

scarfSegments = 8;
restingDistances = 0.01;
stiffness = 0.7;

for (var j = 0; j < clothHeight; j++) { // due to the way PointMasss are attached, we need the y loop on the outside
	for (var i = 0; i < clothWidth; i++) { 
		
	    var pointmass = new VerletPoint(x + i * restingDistances, y + j * restingDistances);
		var currentId = j*clothWidth + i;
		pointmass.pointId = currentId;
	  
	    // attach to 
	    // x - 1  and
	    // y - 1  
	    //  *<---*<---*<-..
	    //  ^    ^    ^
	    //  |    |    |
	    //  *<---*<---*<-..
	    //
	    // PointMass attachTo parameters: PointMass PointMass, float restingDistance, float stiffness
	    // try disabling the next 2 lines (the if statement and attachTo part) to create a hairy effect
	    if (i != 0) {
			add_link(pointmass, points[| currentId-1]);}
			
	    // the index for the PointMasss are one dimensions, 
	    // so we convert x,y coordinates to 1 dimension using the formula y*width+x  
	    if (j != 0){
			var aboveId = currentId - clothWidth;
			add_link(pointmass, points[| aboveId]);}
			
      
	    // we pin the very top PointMasss to where they are
	    if (j == 0) {
	    pointmass.pinned = true;}
        
	    // add to PointMass array  
	    ds_list_add(points, pointmass);
		pointCount++;
	}
}