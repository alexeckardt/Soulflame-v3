//
//DESC:
//
//
//
function ramp_behaviour(){

	var time = Game.delta;

	//Ramps
	var range = 5;
	var moveY = (controlVSpeed)*time;
	var moveX = (controlHSpeed)*time;

	//Going Down a Ramp
	if (place_meeting(x, y+1, Solid) && !place_meeting(x+moveX, y+1, Solid)) {
		for (var i = 1; i < range; i++) {
			if (place_meeting(x+moveX, y+i+1, Solid)) {
				y += i;
				break;
			}
		}
	}
	

	//Going Up a Ramp
	if (onGround && place_meeting(x+moveX, y, Solid)) {
	
		for (var i = 0.1; i < abs(moveX); i += 0.1) {
			if (place_meeting(x+sign(moveX)*i, y, Solid) && !place_meeting(x+sign(moveX)*i, y-1, Solid)) {
				y--;
			}
		}
	
	}


}