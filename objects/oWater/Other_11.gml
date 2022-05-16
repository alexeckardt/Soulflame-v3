/// @desc Godray

drawGodrays = true;

godrays = ds_list_create();

godrayDropAngle = 240;
godrayXstep = lengthdir_x(1, godrayDropAngle);

//
//
//

function Godray(_width, _height, c, _swayAmp, _swayPeriod, _startAlpha, nodeAttachedTo, _spr = sWaterGodray0) constructor {

	orgX = 0;
	drawX = 0;
	drawStartY = 0;
	width = _width;
	height = _height;
	
	col = c
	startAlpha = _startAlpha;
	usingAlpha = startAlpha;
	usingAlphaTo = startAlpha;
	
	hidden = choose(1, 0);
	
	swayAmp = _swayAmp;
	swayPeriod = _swayPeriod;
	swayPeriodOffset = irandom(_swayPeriod);	
	
	spr = _spr;
	sprHeight = sprite_get_height(_spr);
	sprWidth = sprite_get_width(_spr);
	xincrement = sprite_get_bbox_right(spr);
	
	ticksUntilAlphaFlip = irandom(room_speed*5);
	
	nodeIdAttachedTo = nodeAttachedTo;
	
	static update = function(pointList, surfX, surfY) {
	
		//Update Pos
		var nodeattach = pointList[| nodeIdAttachedTo];
		
		//Position
		var t = Game.timeInGame + swayPeriodOffset;
		drawX = lerp(drawX, nodeattach.xx - surfX + sin(t / swayPeriod)*swayAmp, 0.2*Game.delta);
		drawStartY = lerp(drawStartY, nodeattach.yy - surfY - 5, 0.2*Game.delta);

		//Shimmer Alpha
		ticksUntilAlphaFlip -= Game.delta;
		if (ticksUntilAlphaFlip < 0) {
			
			//Flip Alpha
			hidden = !hidden;
			usingAlphaTo = startAlpha*hidden;
			
			//Reset Counter
			ticksUntilAlphaFlip = irandom(room_speed*4) + room_speed;
			
		}
		usingAlpha = coserp(usingAlpha, usingAlphaTo, 0.3*Game.delta);

	}
	
	static draw = function(buff) {
	
		var segs = height div sprHeight;
		var segTotHeight = segs*sprHeight;
	
		for (var i = 0; i < segs; i++) {
			
			//because we start drawing from top of surface, the alpha will be low by the time
			//we reach where we can see
			
			var topY = i*sprHeight;
			
			var topCp = max(0, (topY)/(segTotHeight));
			var botCp = max(0, (topY+sprHeight)/(segTotHeight));
			
			var topC = merge_colour(0, col, (1-topCp)*usingAlpha);
			var botC = merge_colour(0, col, (1-botCp)*usingAlpha);
			
			//Position
			var xx = drawX + xincrement*i;
			var yy = topY + drawStartY;
			
			//Draw
			//draw_sprite_ext(sPixel, 0, xx, yy, width, 1, 0, col, a);
			draw_sprite_general(spr, 0, 0, 0, sprWidth, sprHeight, xx, yy, 1, 1, 0,
				topC, topC, botC, botC, 1);
		}
	
	}

}

function water_generate_godray() {
	 
	//Position
	var node = irandom(pointCount-1);
	
	//var xx = irandom(sprite_width)+ waterSurfaceEdgeBuffer div 2;
	
	//Size
	var w = irandom_range(4, 10);
	var mh = min(64, sprite_height div 2 + waterSurfaceEdgeBuffer);
	var Mh = floor((sprite_height + waterSurfaceEdgeBuffer) * 0.9);
	var h = irandom_range(mh, Mh);
	
	var swayAmp = irandom_range(1, 5);
	var swapPeriod = irandom_range(80, 200);
	
	var startAlpha = choose(0.5, 0.5, 0.6, 0.7, 0.7, 0.8, 0.9, 1);
	
	var spr = choose(sWaterGodray0, sWaterGodray1, sWaterGodray2);
	
	return new Godray(w, h, topRestCol, swayAmp, swapPeriod, startAlpha, node, spr);
}	

density = 0.05;
repeat(ceil(sprite_width * density)) {
	ds_list_add(godrays, water_generate_godray());
}


godrayCount = ds_list_size(godrays);
