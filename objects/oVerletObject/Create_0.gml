/// @desc

//
//	Verlet Integration; Followed by
//	https://gamedevelopment.tutsplus.com/tutorials/simulate-tearable-cloth-and-ragdolls-with-simple-verlet-integration--gamedev-519
//



function VerletPoint(xx, yy) constructor {
	
	x = xx;
	y = yy;
	lastX = xx;
	lastY = yy;
	mass = 1;
	myGrav = 0.3;
	
	accX = 0;
	accY = 0;
	
	links = ds_list_create();
	linkCount = 0;
	
	pinned = false;
	pinX = x;
	pinY = y;
	
	pointId = 0;
	
	static applyForce = function(fx, fy) {
		
		accX += fx/mass;
		accY += fy/mass;
		
	}
	
	
	static updatePhysics = function() {
		
		applyForce(0, mass*myGrav);
		
		var velX = x - lastX;
	    var velY = y - lastY;
    
	    // dampen velocity
	    velX *= 0.99;
	    velY *= 0.99;

	    // calculate the next position using Verlet Integration
	    var nextX = x + velX + 0.5 * accX;
	    var nextY = y + velY + 0.5 * accY;
    
	    //Save Position
	    lastX = x;
	    lastY = y;
    
		//Set Position
	    x = nextX;
	    y = nextY;
    
		//Reset Acc
	    accX = 0;
	    accY = 0;	
	};
	
	static solveConstraints = function () {
	
		for (var i = 0; i < linkCount; i++) {
	      var currentLink = links[| i];
	      currentLink.solve();
		}
		
		if (pinned) {
	      x = pinX;
	      y = pinY; 
	    }
		
	};
	
	static drawPrimative = function () {
	
		for (var i = 0; i < linkCount; i++) {
			
			var link = links[| i];
			var otherPoint = link.p2; //pointa is this point
			
			draw_line(x, y, otherPoint.x, otherPoint.y);
		
		}
	
	};
};


function VerletLink(pointa, pointb, resDist, stiff) constructor {

	 restingDistance	= resDist;
	 stiffness			= stiff;
      
     p1 = pointa;
     p2 = pointb;
	 
     static solve = function() {
		 
		//Get the distances
		var diffX = p1.x - p2.x;
		var diffY = p1.y - p2.y;
		var d = sqrt(diffX * diffX + diffY * diffY);
    
		// find the difference, or the ratio of how far along the restingDistance the actual distance is.
		var difference = (restingDistance - d) / d;
    
		// Inverse the mass quantities
		var im1 = 1 / p1.mass;
		var im2 = 1 / p2.mass;
		var scalarP1 = (im1 / (im1 + im2)) * stiffness;
		var scalarP2 = stiffness - scalarP1;
    
		// Push/pull based on mass
		// heavier objects will be pushed/pulled less than attached light objects
		p1.x += diffX * scalarP1 * difference;
		p1.y += diffY * scalarP1 * difference;
    
		p2.x -= diffX * scalarP2 * difference;
		p2.y -= diffY * scalarP2 * difference;
		
     }

}

//Add Link	
function add_link(p1, p2) {

	var newLink = new VerletLink(p1, p2, restingDistances, stiffness);

	ds_list_add(p1.links, newLink);
	p1.linkCount++;
	
	show_debug_message("P" + string(p1.pointId) + " connected to P" + string(p2.pointId));
	
}

//
points = ds_list_create();
pointCount = 0;
draw = true;

restingDistances = 10;
stiffness = 1;

//Create the object
event_user(0);