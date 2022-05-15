/// @description Verlet

function VerletPoint(_xx, _yy, _id = 0, _mass = 1) constructor {
	
	xx = _xx;
	yy = _yy;
	
	prevX = _xx;
	prevY = _yy;
	
	locked = false;
	
	pointId = _id; //Save For ID + Linking
	mass = _mass;
	
	restingX = _xx;
	restingY = _yy;
	
	doCollision = false;
	
	c = 0;
	upsetP = 0;
	
	static drawPrimative = function() {
		var c = (locked) ? c_lime : c_white;
		draw_circle_color(xx, yy, 2, c, c, false);	
	}

};


function VerletLink(pointa, pointb, resDist) constructor {

	 restingDistance	= resDist;
      
     p1 = pointa;
     p2 = pointb;
	 
	 distancebeforeforce = 0;
	 
	 static drawPrimative = function() {
		draw_line_width(p1.xx, p1.yy, p2.xx, p2.yy, 1);	
	}
	 
	//
	static draw = function(xanch, yanch) {
		
		//
		//Draw
		var d1x = p1.xx - xanch;
		var d1y = p1.yy - yanch;
		
		var d2x = p2.xx - xanch;
		var d2y = p2.yy - yanch;
	
		var rippedPercent = max(0, 1 - distancebeforeforce/restingDistance);
		var w = lerp(2,8,rippedPercent)
	
		//Draw Circle Under
		draw_line_width_colour(d1x, d1y, d2x, d2y, w, p1.c, p2.c);	
	
	}
	 
}

//Add Link	
function add_link(p1, p2, dis = restingDistances) {

	var newLink = new VerletLink(p1, p2, dis);
	ds_list_add(links, newLink);
	linkCount++;
	
	show_debug_message("P" + string(p1.pointId) + " linked to P" + string(p2.pointId));
	
}
