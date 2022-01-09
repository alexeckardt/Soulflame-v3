// @desc
//
//
//
function platinum_create(xx, yy, amount, spread, minSpeed, maxSpeed) {

	//Tell
	randomize();
	show_debug_message("Spawning in " + string(amount) + " platinum");

	//Setup
	var autoPickup = false; //replace with buff

	//Choose Sizes
	var amountOf25s = irandom_range(0, max(0, (amount div 25) - 1));
	amount -= amountOf25s * 25;
	var amountOf5s = irandom_range(0, max(0, (amount div 5)));
	amount-= amountOf5s * 5;
	
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
	var tot = amount + amountOf5s + amountOf25s;
	for (var i = 0; i < tot; i++) {
	
		//Create platinum
		var g = instance_create_depth(xx, yy, depth+5, oPlatinumCoin); 
	
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
	
		//Update Value if I Should
		if (amountOf25s > 0) {
			g.value = 25;
			amountOf25s--;
		} else if (amountOf5s > 0) {
			g.value = 5;
			amountOf5s--;
		} else {
			g.value = 1;	
		}

		//Get Speed
		randomize();
		var speedd = choose(minSpeed, random_range(minSpeed, maxSpeed), maxSpeed);
		var dirFromC = point_direction(newX, newY, spawnX, spawnY);
	
		//Update Speeds
		var hspdd = lengthdir_x(speedd, dirFromC);
		var vspdd = lengthdir_y(speedd, dirFromC);
		g.hSpeed = hspdd;
		g.vSpeed = vspdd;
	
		g.autoPickup = autoPickup;
		
		//If In Ground, Auto Pickup
		if (g.place_meeting(x, y, Solid)) {
			g.autoPickup = true;	
		}
	}
	
	

}