/// @desc Godray

godrays = ds_list_create();

godrayDropAngle = 240;
godrayXstep = lengthdir_x(1, godrayDropAngle);

//
//
//

function Godray(_x, _width, _height, c, _swayAmp, _swayPeriod, _startAlpha) constructor {

	orgX = _x;
	drawX = _x;
	width = _width;
	height = _height;
	
	col = c
	startAlpha = _startAlpha;
	
	swayAmp = _swayAmp;
	swayPeriod = _swayPeriod;
	swayPeriodOffset = irandom(_swayPeriod);	
	
	static update = function() {
	
		var t = Game.timeInGame + swayPeriodOffset;
		drawX = orgX + sin(t / swayPeriod)*swayAmp;

	}
	
	static draw = function(buff, xincr) {
	
		for (var i = 0; i < height; i++) {
			
			//because we start drawing from top of surface, the alpha will be low by the time
			//we reach where we can see
			
			var a = startAlpha - max(0, (i-buff)/(height-buff));
			
			//Position
			var xx = buff + drawX + floor(xincr * i);
			var yy = i;
			
			//Draw
			draw_sprite_ext(sPixel, 0, xx, yy, width, 1, 0, col, a);
		}
	
	}

}

function water_generate_godray() {
	 
	//Position
	var xx = irandom(sprite_width)+ waterSurfaceEdgeBuffer div 2;
	var yy = 0;
	
	//Size
	var w = irandom_range(4, 10);
	var mh = min(64, sprite_height div 2 + waterSurfaceEdgeBuffer);
	var Mh = floor((sprite_height + waterSurfaceEdgeBuffer) * 0.9);
	var h = irandom_range(mh, Mh);
	
	var swayAmp = irandom_range(1, 5);
	var swapPeriod = irandom_range(80, 200);
	
	var startAlpha = choose(0.5, 0.5, 0.6, 0.7, 0.7, 0.8, 0.9, 1);
	
	return new Godray(xx, w, h, topRestCol, swayAmp, swapPeriod, startAlpha);
}	

density = 0.05;
repeat(ceil(sprite_width * density)) {
	ds_list_add(godrays, water_generate_godray());
}


godrayCount = ds_list_size(godrays);
