//
//DESC:
//
//
//
function HealthHeart(posnum, _fullsprite = sHeartFull, _brokenSprite = sHeartBroken) constructor {

	heartPosition = posnum;

	xoffset = 0;
	yoffset = 0;
	
	fullSprite = _fullsprite;
	brokenSprite = _brokenSprite;
	
	sprite = fullSprite;
	index = 0;
	
	drawFireBehind = false;
	fireIndex = 0;
	
	fireExtinguishing = false;
	
	shakeAmount = 0;
	broken = false;
	
	lightFireInTicks = -1;
	
	//Overlay
	overlayBlend = c_white;
	overlayBrightness = 0;
	brightnessTo = 0;
	
	
	static update = function( ) {
		
		shakeAmount = lerp(shakeAmount, 0, 0.1);
		xoffset = random_range(-shakeAmount, shakeAmount);
		yoffset = random_range(-shakeAmount, shakeAmount);
		
		//Lerp To Correct Brightness
		overlayBrightness = lerp(overlayBrightness, brightnessTo, 0.2);
		
		//Light Fire
		if (lightFireInTicks > 0) {
			lightFireInTicks -= Game.delta;
			
			if (floor(lightFireInTicks) == 0) {
				light_fire_events();
			}
		}
		
		
		
		//Update Fire n Such
		if (drawFireBehind) {
		
			//Animate
			fireIndex += Player.healthFireSpeed;
			
			//Exit Extinguish if animation is finished
			if (fireExtinguishing) {
				if (fireIndex > Player.healthFireExtinguishLastFrame) {
					fireExtinguishing = false;
					drawFireBehind = false;
				}
				
			}
		
		}

	}
	
	static mend_heart = function() {
		
		broken = false;
		brightnessTo = 0;
		overlayBrightness = 1;
		sprite = fullSprite;
		
	}
	
	static break_heart = function() {
		
		shakeAmount = 1;
		broken = true;
		overlayBrightness = 0.1;
		brightnessTo = 0;
		
		sprite = brokenSprite;
		
	};

	//Start drawing Fire
	static light_fire = function(delay) {
		
		lightFireInTicks = delay;
		if (delay <= 0) {
			light_fire_events();
		}
		
	};
	static light_fire_events = function() {
	
		drawFireBehind = true;
		fireExtinguishing = false;
		lightFireInTicks = -1;
		
		//Flash
		brightnessTo = 0.5; //Go Down
		overlayBrightness = 1;
	
	};
	
	//Extinguish the Fire
	static extinguish_fire = function() {
		
		mend_heart();
		
		drawFireBehind = true;
		fireExtinguishing = true;
		fireIndex = 0;
		brightnessTo = 0;
		
	};
	
	static set_fire_col = function(_col) {
		overlayBlend = _col;}	
	static set_fire_col_alignment = function(align) {
		set_fire_col(essence_get_colour_bright(align));
	}
	
	//Draw
	static draw = function(basex, basey) {
		
		//Position
		basex += xoffset;
		basey += yoffset;
		if (Player.hp == 1 && heartPosition == 0) {
		basex += choose(-1, 1);
		basey += choose(-1, 1);}	

		//
		//Health Flame
		if (drawFireBehind) {
						
			//
			//Get Fire Spr Info
			var firespr = (!fireExtinguishing) ? sHeartFlameLoop : sHeartFlameFizzle;
				
			//
			//Draw Flame
			draw_sprite_ext(firespr, fireIndex, basex, basey, 1, 1, 0, overlayBlend, 1);
				
		}
		
		///
		//Draw Heart
		draw_sprite(sprite, index, basex, basey);
		
		//Overlay
		if (overlayBrightness > 0.01) {
			gpu_set_blendmode(bm_add);
			gpu_set_fog(1, overlayBlend, 0, 0);
			draw_sprite_ext(sprite, index, basex, basey, 1, 1, 0, 0, overlayBrightness);
			gpu_set_fog(0,0,0,0);
			gpu_set_blendmode(bm_normal);
		}
	
	};

}