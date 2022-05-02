/// @desc

//
//	Verlet Integration; Followed by
//	https://gamedevelopment.tutsplus.com/tutorials/simulate-tearable-cloth-and-ragdolls-with-simple-verlet-integration--gamedev-519
//



function VerletPoint(_xx, _yy) constructor {
	
	xx = _xx;
	yy = _yy;
	
	prevX = _xx;
	prevY = _yy;
	
	locked = false;
	
	pointId = 0; //Save For ID + Linking
	
	static drawPrimative = function() {
		var c = (locked) ? c_lime : c_white;
		draw_circle_color(xx, yy, 2, c, c, false);	
	}
	
};


function VerletLink(pointa, pointb, resDist, stiff) constructor {

	 restingDistance	= resDist;
	 stiffness			= stiff;
      
     p1 = pointa;
     p2 = pointb;
	 
	 static drawPrimative = function() {
		draw_line_width(p1.xx, p1.yy, p2.xx, p2.yy, 1);	
	}
	 
}

//Add Link	
function add_link(p1, p2) {

	var newLink = new VerletLink(p1, p2, restingDistances, stiffness);
	ds_list_add(links, newLink);
	linkCount++;
	
	show_debug_message("P" + string(p1.pointId) + " linked to P" + string(p2.pointId));
	
}

//
points = ds_list_create();
links = ds_list_create();
pointCount = 0;
linkCount = 0;

draw = true;

restingDistances = 10;
stiffness = 1;

gravDir = -90;
gravStr = 0.3;

allowMouseToCutEdges = false;

//Create the object
event_user(0);