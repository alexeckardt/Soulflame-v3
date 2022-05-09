
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

	//Define
	allowJumpWalls = true;

	//Generate Path To Player
	pathfinder_generate_path(pathFinder, [lastSawTargetX, lastSawTargetY]);

	//Follow the Path of where I want to Go
	var p = pathfinder_get_positon(pathFinder, pathfinderRegenerateRange);
	var pathPointX = p[0];
	var pathPointY = p[1];
	
	//Decide Walk Position
	//If same x, follow x direction
	var distToGoalPos = point_distance(lastSawTargetX, lastSawTargetY, x, y);
	var tooClose = (distToGoalPos < closeEnoughPathXRange);
	var atCliff = (!place_meeting(pathPointX, y+16, Solid) && pathPointY < y);
	var dirToPathPoint = sign(point_to_position(pathPointX)*2 + directionFacing);
	var walkDir = dirToPathPoint * (!tooClose) * (!atCliff);

	//
	//Decide I need to jump
	var pathGoesStraightUp = abs(pathPointX - x) < closeEnoughPathXRange && pathPointY < y - pathfinderRegenerateRange + 3;
	var atEdgeButPathGoesUp = (pathPointY < y - pathfinderRegenerateRange + 5) && atCliff;
	if (pathGoesStraightUp || atEdgeButPathGoesUp) {
	
		//Get If Landable
		var toLandOnPath = pathfinder_check_landable_position(48, (maxJumpTiles+1) * 16);
		if (is_array(toLandOnPath)) {
			
			//Get Landable Position
			var ppX = toLandOnPath[0];
			var ppY = toLandOnPath[1];

			if (abs(ppX - x) > 3) {

				var d = point_to_position(ppX);

				//Make Sure nothing above me
				if (!place_meeting(x - d*3, ppY + 5, Solid)) {
		
					if (onGround) {
					
						//Jump
						jump_to_position(ppX, ppY);
					
					}
			
				//Move so there is nothing above me
				} else {
				
					hSpeedGoal = dirToPathPoint*!atCliff;
				
				}
				
			} else {
				
				//Was Underneath jump goal exactly
				hSpeedGoal = dirToPathPoint;
			
			}
			
		}
		
	} else {
		
		//Otherwise, Walk
		hSpeedGoal = walkDir * runSpeed;
		
	}
	
}

//
//jumping state -- move to a predefined x position at some velocity
if (STATE == state.jumping) {

	//Pause, Prep Jump
	//controlHSpeed = 0;
	hSpeedGoal = 0;
	
	//Timer
	timeUntilJump--;
	
	//Jump After Time
	if (timeUntilJump < 0) {
		
		//
		//Jump V Speed
		if (!inAirFromJump) {
			vSpeed = toJumpVspeed;
			hSpeedGoal = abs(toJumpHspeed)*jumpingDirection;
			controlHSpeed = hSpeedGoal;
			
			//Don't Fly
			inAirFromJump = true;
			onGround = false;
		}
		
		//Move towards goal after some time (avoid vertical collision)
		if (vSpeed > -4) {
			if (point_to_position(toJumpToX) == jumpingDirection) {
				hSpeedGoal = abs(toJumpHspeed)*jumpingDirection;
				controlHSpeed = hSpeedGoal;
			}
		}
		
		//
		//Reset
		if (onGround) {
			STATE = state.land;
			landingTicksLeft = landingTicks;
		}
		
	}

}

//
//Land
if (STATE == state.land) {

	hSpeedGoal = 0;
	landingTicksLeft--;
	
	//Reset
	if (landingTicksLeft < 0) {
		STATE = state.ready_attack;
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
	
	//About To Collide Into Wall; Jump
	var checkX = x + directionFacing*runSpeed*12; //box width half
	
	if (place_meeting(checkX, y-2, Solid)) {
			
		//Deterime Jump Height
		for (var i = 1; i <= maxJumpTiles; i++) {
			
			var checkY = y - 16*i;
			if (!place_meeting(checkX, checkY, Solid)) {
				
				//Jump
				jump_to_position(checkX, checkY);
				jumped = true;
				
				break;	
			}
		}
		
		//Cannot Reach
		if (!jumped) {
			hSpeedGoal = 0;
		}
	}	
}

//
//
//

//Visuals Call
event_user(0);
