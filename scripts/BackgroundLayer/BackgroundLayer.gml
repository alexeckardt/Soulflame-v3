// @desc
//
//
//
function BackgroundLayer() constructor {

	//Visual Sprite
	sprite = sPixel;
	index = 0;
	index_speed = 0;
	blendMode = bm_normal;
	
	//Movement + Positioning
	xoffset = 0;
	yoffset = 0;
	
	hparalaxAmount = 0;
	vParalaxAmount = 0;
	scrollXAmount = 0;
	scrollYAmount = 0;
	
	loopX = true;
	loopY = false;
	
	//
	drawX = 0;
	drawY = 0;
	
	spriteWidth = 1;
	spriteHeight = 1;
	
	drawObstruction = false;

	static update = function() {
	
		var t = Game.delta;
	
		//move
		drawX += scrollXAmount*t;
		drawY += scrollYAmount*t;
	
		//constrain
		drawX %= spriteWidth;
		drawY %= spriteHeight;
		
		//Animate
		index += indexSpeed*t;
		
	}
	
	static draw = function(zoom) {
	
		//Cam
		var camW = Camera.view_width;
		var camH = Camera.view_height;
		var camX = Camera.viewX;
		var camY = Camera.viewY;
	
		var sprYoffset = sprite_get_yoffset(sprite);
		var yy = drawY + yoffset + camY*(vParalaxAmount - 1);

		if (drawObstruction) {
		
			//Stretch
			draw_sprite_part_ext(sprite, index, 0, 0, 1, 1, 0, 0,
					camW*zoom,	max(0, yy),	c_white, 1);
					
			draw_sprite_part_ext(sprite, index, 0, 0, 1, 1, 0, yy+spriteHeight*zoom, 
					camW*zoom,	max(0, (camH*zoom - spriteHeight*zoom - yy)),	c_white, 1);
			
		}


		//Setup
		gpu_set_blendmode(blendMode);

			//Loop X
			for (var i = -spriteWidth*zoom; i < (camW + spriteWidth)*zoom; i += spriteWidth*zoom) {

				var xx = drawX + xoffset + i + camX*(hParalaxAmount - 1);
				draw_sprite_ext(sprite, index, xx, yy, zoom, zoom, 0, c_white, 1);

			}	
		
		//Fix
		gpu_set_blendmode(bm_normal);
	
	}

}