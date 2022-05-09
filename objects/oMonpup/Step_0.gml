
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
	if (targetingTarget) {
		pathfinder_generate_path(pathFinder, [lastSawTargetX, lastSawTargetY]);
	}
	
	//Get Where I want to Go
	var p = pathfinder_get_positon(pathFinder, pathfinderRegenerateRange);
	var pathPointX = p[0];
	var pathPointY = p[1];
	
		//Move to Goal!
		var walkDir = sign(point_to_position(pathPointX)*2 + directionFacing);
		hSpeedGoal = walkDir * runSpeed * (point_distance(lastSawTargetY, lastSawTargetX, x, y) > closeEnoughPathXRange) * (vSpeed > -3);
		allowJumpWalls = true
	
		//If Path Point is DIRECTLY above me
		if (abs(pathPointX - x) < closeEnoughPathXRange && pathPointY < y - pathfinderRegenerateRange + 3) {
			
			//See if there is a nearby future path in which I can land on
			var toLandOnPath = pathfinder_check_landable_position(32, (maxJumpTiles+1) * 16);
			if (is_array(toLandOnPath)) {
			
				//x, y of where I want to land
				var ppX = toLandOnPath[0];
				var ppY = toLandOnPath[1];
				
				//Make this my path I want
				targetingTarget = false;
				pathfinder_generate_path(pathFinder, [ppX, ppY]);
				
				var yHeight = ppY - y;
				var xDist = abs(ppX - x);
				var fromPlatformDir = sign(ppX - x);
			
				//Calc how fast I need to go
				if (!place_meeting(x + fromPlatformDir * 3, y + yHeight + 16, Solid)) { //yhiehg
					
					if (onGround) {
						toJumpVspeed = (yHeight - 8)/(xDist) - (myGrav*xDist)/(2);
						toJumpVspeed = clamp(toJumpVspeed, -6.8, -0.5);
						toJumpHspeed = sign(ppX - x) * 0.5
						jumpingToX = true;
						
						//goal jump x
						toJumpToX = ppX;
						
						lastSTATE = STATE;
						STATE = state.jumping;
						allowJumpWalls = 0;
					
						hSpeedGoal = 0;
						controlHSpeed = 0;
					
						timeUntilJump = abs(toJumpVspeed) * 2;
						inAirFromJump = false;
					}
					
				} else {
				
					//Move out from under
					hSpeedGoal = sign(-fromPlatformDir + directionFacing);
				
				}
				
			}
			
		}
	
	
	
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
		
		if (!inAirFromJump) {
			vSpeed = toJumpVspeed;
			hSpeedGoal = toJumpHspeed;
			controlHSpeed = toJumpHspeed;
		}
		
		//Stop The Jump
		if (jumpingToX) {
			
			//Move in Air
			if (vSpeed > -3) {
				hSpeedGoal = point_to_position(toJumpToX);
				controlHSpeed = point_to_position(toJumpToX);
			}
			
			//Slow Dwo
			if (sign(toJumpToX - x+controlHSpeed*2) != sign(toJumpHspeed)) {
				//Slow Down
				hSpeedGoal = 0;
			}
			
			//Make Sure to land
			if (onGround && !inAirFromJump) {
				jumpingToX = false;
				STATE = lastSTATE;
				inAirFromJump = false;
			}
			
		} else {
			STATE = lastSTATE;	
			inAirFromJump = false;
		}
		
		//STATE = lastSTATE;
		inAirFromJump = true;
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
				jumpingToX = false;
				
				//Decide Time Jumping Takes
				timeUntilJump = abs(toJumpVspeed) * 2;
				inAirFromJump = false;
				
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
