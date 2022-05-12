/// @description 

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
	
	static drawPrimative = function() {
		var c = (locked) ? c_lime : c_white;
		draw_circle_color(xx, yy, 2, c, c, false);	
	}
	
};


function VerletLink(pointa, pointb, resDist) constructor {

	 restingDistance	= resDist;
      
     p1 = pointa;
     p2 = pointb;
	 
	 static drawPrimative = function() {
		draw_line_width(p1.xx, p1.yy, p2.xx, p2.yy, 1);	
	}
	 
}

//Add Link	
function add_link(p1, p2, dis = restingDistances) {

	var newLink = new VerletLink(p1, p2, dis);
	ds_list_add(links, newLink);
	linkCount++;
	
	show_debug_message("P" + string(p1.pointId) + " linked to P" + string(p2.pointId));
	
}
