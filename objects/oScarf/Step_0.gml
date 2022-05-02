
var time = Game.delta;

//Move
var k = oKeira.id;
x = k.x + scarfRestingXoffset * k.directionFacing;
y = k.y + scarfRestingYoffset;

//Anchor to Me
points[| 0].xx = x;
points[| 0].yy = y;

//Update Points
for (var i = 0; i < pointCount; i++) {
	
	var p = points[| i];

	if (!p.locked) {
		
		var beforeX = p.xx;
		var beforeY = p.yy;
		
		//Intertia
		var hSpeed = (p.xx - p.prevX) * time;
		var vSpeed = (p.yy - p.prevY) * time;

		//Intertia
		p.xx += (hSpeed + lengthdir_x(gravStr, gravDir) * time * time) / p.mass;
		p.yy += (vSpeed + lengthdir_y(gravStr, gravDir) * time * time) / p.mass;
		
		//Down
		p.prevX = beforeX;
		p.prevY = beforeY;	
	}
}

var iterations = 2;
for (var j = 0; j < iterations; j++) { //stableize
	for (var i = 0; i < linkCount; i++) {
	
		var link = links[| i];
	
		var centreX = (link.p1.xx + link.p2.xx) / 2;
		var centreY = (link.p1.yy + link.p2.yy) / 2;
	
		var linkDir = point_direction(link.p2.xx, link.p2.yy, link.p1.xx, link.p1.yy);
		var linkDirxcomp = lengthdir_x(1, linkDir);
		var linkDirycomp = lengthdir_y(1, linkDir);
	
		if (!link.p1.locked){
			link.p1.xx = centreX + linkDirxcomp * link.restingDistance/2;
			link.p1.yy = centreY + linkDirycomp * link.restingDistance/2;}
	
		if (!link.p2.locked){
			link.p2.xx = centreX - linkDirxcomp * link.restingDistance/2;
			link.p2.yy = centreY - linkDirycomp * link.restingDistance/2;}

		//Delete an Edge (uncomment this if you want)
		/*
		if (allowMouseToCutEdges) {
			if (mouse_check_button(mb_right)) {
				if (point_distance_to_line(mouse_x, mouse_y, link.p1.xx, link.p1.yy, link.p2.xx, link.p2.yy) < 1) {
					ds_list_delete(links, i);
					i--;
					linkCount--;
				}
			}
		}*/
	}
}

//Reset Grav
gravStr = 0.3;
gravDir = 270;