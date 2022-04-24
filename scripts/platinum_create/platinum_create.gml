// @desc
//
//
//
function platinum_create(xx, yy, amount, spread, minSpeed, maxSpeed, goalVector = 0, vectorRange = 180, goalvectorweight = 1) {

	//Tell
	randomize();
	show_debug_message("Spawning in " + string(amount) + " platinum");

	//Setup
	var autoPickup = false; //replace with buff

	//Convert to 25s
	var biasFor25s		= clamp(amount/400, 0, 1);
	var prebiaschance = random(1);
	var percentToTurn25	= 1 - bias(prebiaschance, biasFor25s);
	var amountOf50s = floor((amount / 50) * percentToTurn25);
	amount -= amountOf50s * 50;

	//Convert to 5s
	var biasFor5s		= clamp(amount/40, 0, 1);
		prebiaschance = random(1);
	var percentToTurn5	= 1 - bias(prebiaschance, biasFor5s);
	var amountOf5s = floor((amount / 5) * percentToTurn5);
	amount-= amountOf5s * 5;
	
	//
	//Original Position
	var spawnX = xx;
	var spawnY = yy;
	
	//Move Spawn OUT of Solid, 
	if (position_meeting(xx, yy, Solid)) {
		
		var out = false;
		
		//Sprial Out, Max Dist of 8
		for (var r = 1; r < 8 && !out; r++) {
		
			for (var rad = 0; rad < 2; rad += 1/2) {
			
				xx = spawnX + sin(rad)*r; 
				yy = spawnY + cos(rad)*r; //"Priority" to moving vertically
			
				if (!position_meeting(xx, yy, Solid)) {
					if (!position_meeting(xx, yy+2, Solid)) {
						out = true; //exits the above loop too
						break;
					}
				}
			
			}
		
		}
		
		//Either Found or didn't find
		if (out) {
			autoPickup = true;	
		}
		
	//End Solid Check
	}
	
	//
	//Spawn Each coin
	var tot = amount + amountOf5s + amountOf50s;
	for (var i = 0; i < tot; i++) {
	
	
		//Create Objects
		var d = depth - 20;
		
		var g;
		if (amountOf50s > 0) {
			g = instance_create_depth(xx, yy, d, oPlatinumChunk); 
			g.value = 50;
			g.sprite_index = sPlatinumBar
			amountOf50s--;
			
		} else if (amountOf5s > 0) {
			g = instance_create_depth(xx, yy, d, oPlatinumChunk); 
			g.value = 5;
			amountOf5s--;
			
		} else {
			g = instance_create_depth(xx, yy, d, oPlatinumCoin); 
			g.value = 1;	
			
		}
	
		//Create platinum
	
		//Range Around
		var newX, newY;
		do {
			var spreadX = random_range(-spread, spread);
			var spreadY = random_range(-spread, 0);
			newX = xx + spreadX;
			newY = yy + spreadY;
			
			spread += 0.01;
		} until (!place_meeting(newX, newY, Solid));
	
		//Move
		g.x = newX;
		g.y = newY;

		//Get Speed
		randomize();
		var speedd = choose(minSpeed, random_range(minSpeed, maxSpeed), maxSpeed);
		
		//Set Direction To Move In
		var dirFromC = point_direction(newX, newY, spawnX, spawnY);
		var randomRange = goalVector + irandom_range(-vectorRange, vectorRange)*random(1);
		
		var realMoveDirection = point_direction(-lengthdir_x(1, dirFromC), -lengthdir_y(1, dirFromC), 
												lengthdir_x(goalvectorweight, randomRange), lengthdir_y(goalvectorweight, randomRange))
	
		//Update Speeds
		var hspdd = lengthdir_x(speedd, realMoveDirection);
		var vspdd = lengthdir_y(speedd, realMoveDirection);
		g.hSpeed = hspdd;
		g.vSpeed = vspdd;
	
		g.autoPickup = autoPickup;
		
		//If In Ground, Auto Pickup
		if (g.place_meeting(x, y, Solid)) {
			g.autoPickup = true;	
		}
	}
	
	

}