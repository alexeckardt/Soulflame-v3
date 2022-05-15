/// @desc

var time = Game.delta;

//Update Points
for (var i = 0; i < pointCount; i++) {
	
	var p = points[| i];

	if (!p.locked) {
		
		var beforeX = p.xx;
		var beforeY = p.yy;
		
		//Intertia
		var hSpeed = (p.xx - p.prevX) * time;
		var vSpeed = (p.yy - p.prevY) * time;

		//Get Any Forces
			//Collision Force
			var entityTouching = instance_position(p.xx, p.yy, Entity);
			if (entityTouching != noone) {
				
				var dirFromEntity = point_direction(entityTouching.x, entityTouching.y, p.xx, p.yy);
				
				vSpeed += entityTouching.vSpeed * vSpeedCoefficient * time;
				hSpeed += entityTouching.hSpeed * hSpeedCoefficient * time;
				
				hSpeed += lengthdir_x(entityTouching.vSpeed/3, dirFromEntity);
				
				//Upset
				p.upsetP += point_distance(0, 0, vSpeed, hSpeed)/4;
				
			}
			
			
			//Wave Defaulticly
			var t = Game.inGameTicks / 40;
			var pos = p.pointId * wavePeriodMultiplier;
			vSpeed += (sin(pos*1 + t))*time*basicWaveAmplitude;
			vSpeed += (sin(pos*1.5 - t*1.2))*time*basicWaveAmplitude;
			
			//Resistance Force, Move back to my spot
			var dir = point_direction(p.xx, p.yy, p.restingX, p.restingY);
			var tension = point_distance(p.xx, p.yy, p.restingX, p.restingY);
			hSpeed = lerp(hSpeed, lengthdir_x(tension, dir), surfaceTension);
			vSpeed = lerp(vSpeed - abs(hSpeed/4), lengthdir_y(tension, dir), surfaceTension);
			
		
		//Intertia; Move + Collide
			if (position_meeting(p.xx, p.yy+vSpeed*time, Solid) && p.doCollision) {
				var steps = 0
				while (!position_meeting(p.xx, p.yy+sign(vSpeed)*time, Solid) && steps < 10) {
					steps++;
					p.yy+=sign(vSpeed);
				}
				vSpeed = 0;
			}
			p.yy+=vSpeed*time;
		
			if (position_meeting(p.xx+hSpeed*time, p.yy, Solid) && p.doCollision) {
				var steps = 0
				while (!position_meeting(p.xx+sign(hSpeed)*time, p.yy, Solid) && steps < 10) {
					p.xx+=sign(hSpeed);
					steps++;
				}
				hSpeed = 0;
			}
			p.xx += hSpeed*time;
		
		//Down
		p.prevX = beforeX;
		p.prevY = beforeY;	
		
		//Change Col
		p.upsetP = lerp(p.upsetP, 0, 0.3*Game.delta);
		p.c = merge_colour(topRestCol, topTurbulantCol, clamp(p.upsetP, 0, 1));
	}
}

var iterations = 2;
for (var j = 0; j < iterations; j++) { //stableize
	for (var i = 0; i < linkCount; i++) {
	
		var link = links[| i];
	
		var centreX = (link.p1.xx + link.p2.xx) / 2;
		var centreY = (link.p1.yy + link.p2.yy) / 2;
	
		var linkDir = point_direction(link.p2.xx, link.p2.yy, link.p1.xx, link.p1.yy);
		link.distancebeforeforce = point_distance(link.p2.xx, link.p2.yy, link.p1.xx, link.p1.yy);
		var linkDirxcomp = lengthdir_x(1, linkDir);
		var linkDirycomp = lengthdir_y(1, linkDir);
	
		if (!link.p1.locked){
			link.p1.xx = centreX + linkDirxcomp * link.restingDistance/2;
			link.p1.yy = centreY + linkDirycomp * link.restingDistance/2;}
	
		if (!link.p2.locked){
			link.p2.xx = centreX - linkDirxcomp * link.restingDistance/2;
			link.p2.yy = centreY - linkDirycomp * link.restingDistance/2;}
			
	}
}

//
//Add to Vertex Buffer

//Get positions
var ybottom = y + sprite_height;

//Add Positions
vertex_begin(vb, vf);

	//
	vertex_position(vb, x, y);
	vertex_position(vb, x, ybottom);
	
	for (var i = 0; i < pointCount; i++) {
		var p = points[| i];

		var xx = clamp(p.xx, x, x+sprite_width);

		vertex_position(vb, xx, p.yy);
		vertex_position(vb, xx, ybottom);
	
	}
	
	//
	vertex_position(vb, x+sprite_width, y);
	vertex_position(vb, x+sprite_width, ybottom);
			
vertex_end(vb);
wroteToBuffer = true;

//
//Upate Godrays
for (var i = 0; i < godrayCount; i++) {
	godrays[| i].update();
}

