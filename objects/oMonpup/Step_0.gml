
//Take Damage 
enemy_take_damage();

ramp_behaviour()

//Spikes
enemy_hit_spikes();

//Collision + Movement
vSpeed += myGrav*time;
generic_collide_solid();

//Death
enemy_generic_death_timer();

//
//
//

//Locate The Player's Position
inferPlayerPosTimeLeft--;
seesTarget = enemy_check_target_visible()

//Have a little time after target leaves sight
//in which I can still detect / "infer" where they are
if (seesTarget) inferPlayerPosTimeLeft = inferPlayerPosTime;
if ( inferPlayerPosTimeLeft > 0 ) {
	//Update Vars
	lastSawTargetX = target.x;
	lastSawTargetY = target.y;
		
	sinceSeenTarget = 0;
}

	
//Some Movement Flags
var allowJumpWalls = false;


//
//Base State -- Idle and move around occasionally
if (STATE == state.base) {

	//Hunt Bunfets
	

	//Check For Detection
	if (seesTarget) {
		STATE = state.ready_attack;
	}
	
}

//
// ready state -- move towards goal and once close enough, go to pounce prep.
if (STATE == state.ready_attack) {

	//Generate Path To Player
	pathfinder_generate_path(pathFinder, [lastSawTargetX, lastSawTargetY]);
	
	//Get Where I want to Go
	var p = pathfinder_get_positon(pathFinder, pathfinderRegenerateRange);
	var pathPointX = p[0];
	var pathPointY = p[1];
	
	//Move to Goal!
	hSpeedGoal = point_to_position(pathPointX) * runSpeed;
	allowJumpWalls = true
	
	//If I'm Close Enough
	if (point_distance(x, y, target.x+target.hSpeed, target.y+target.vSpeed) < pounceRad && seesTarget) {
		
		hSpeedGoal = 0;
		allowJumpWalls = 0
		
	}
	
}

if (STATE == state.jumping) {

	timeUntilJump--;
	controlHSpeed = 0;
	hSpeedGoal = 0;
	
	if (timeUntilJump < 0) {
		
		vSpeed = toJumpVspeed;
		hSpeedGoal = toJumpHspeed;
		controlHSpeed = toJumpHspeed;
		
		STATE = lastSTATE;
		
	}
	

}

//
// Movement
//

controlHSpeed = lerp(controlHSpeed, hSpeedGoal, 0.3*time);
directionFacing = (controlHSpeed != 0) ? sign(controlHSpeed) : directionFacing;
hSpeed = controlHSpeed;

//Jump Over Simple Walls as I approach Them
if (onGround && allowJumpWalls) {
	
	var jumped = false;
	var wantsToJump = false;
	
	//About To Collide Into Wall; Jump
	var checkX = x + directionFacing*runSpeed*4; 
	
	if (place_meeting(checkX, y-2, Solid)) {
		wantsToJump = true;
			
		//Deterime Jump Height
		for (var i = 1; i <= maxJumpTiles; i++) {
			if (!place_meeting(checkX, y - 16*i, Solid)) {
				
				//Decide The Distance I need to jump for
				var xDist = abs(x - checkX) + (bbox_right - bbox_left)*1.5; //put me in the middle of my bounding box
				var yHeight = -16*i - 10; //how high i have to jump
				
				var hspdd = max(1, abs(hSpeed));
				toJumpHspeed = hspdd;
				
				//Jump & Clamp (formula for how much jump force i need)
				toJumpVspeed = (yHeight*hspdd)/(xDist) - (myGrav*xDist)/(2*hspdd);
				toJumpVspeed = clamp(toJumpVspeed, -6.8, -0.5);
					
				jumped = true;
				lastSTATE = STATE;
				STATE = state.jumping;
				
				//Decide Time Jumping Takes
				timeUntilJump = abs(toJumpVspeed) * 2;
				
				break;	
			}
		}
		
		//Cannot Reach
		if (!jumped) {
			controlHSpeed = 0;
		}
	}	
}

//
//
//

//Visuals Call
event_user(0);
