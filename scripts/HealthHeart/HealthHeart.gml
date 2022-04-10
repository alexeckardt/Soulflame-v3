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
	
	brightnessTo = 0;
	fireExtinguishing = false;
	
	shakeAmount = 0;
	broken = false;
	
	fireAlignment = 0;
	
	
	static update = function( ) {
		
		shakeAmount = lerp(shakeAmount, 0, 0.1);
		xoffset = random_range(-shakeAmount, shakeAmount);
		yoffset = random_range(-shakeAmount, shakeAmount);
		
		//Lerp To Correct Brightness
		index = lerp(index, brightnessTo*(sprite_get_number(sprite)-1), 0.3);
		
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
		sprite = fullSprite;
		index = (sprite_get_number(sprite)-1);
		
	}
	
	static break_heart = function() {
		
		shakeAmount = 1;
		broken = true;
		brightnessTo = 0.5;
		
		sprite = brokenSprite;
		
	};

	//Start drawing Fire
	static light_fire = function() {
		
		drawFireBehind = true;
		fireExtinguishing = false;
		index = sprite_get_number(sprite)-1; //Max Brightness
		
		brightnessTo = 0.5; //Go Down
		
	};
	
	//Extinguish the Fire
	static extinguish_fire = function() {
		
		mend_heart();
		
		drawFireBehind = true;
		fireExtinguishing = true;
		fireIndex = 0;
		brightnessTo = 0;
		
	};

}