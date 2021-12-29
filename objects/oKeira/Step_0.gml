/// @desc

var time = Game.delta

//Gravity
if (timeOffGround > -1) {

	//Choose Values
	var grav = myGrav * ((STATE == state.climb && controlVSpeed > 0) ? climbingGravMulti : 1);
	var term = (STATE != state.climb) ? terminalVelocity : climbingTermVel;

	//Stop Vspeed If Clinging To A wall
	if (STATE == state.wall_cling) {
		grav = 0;
		term = 0;
		controlVSpeed = 0;
	}

	//Gives Hang Time If Jump is Still Held
	var mult = (abs(controlVSpeed) < halfGravityThreshold && (Controller.jumpHeld || forceHalfGravity) && allowHalfGravity) ? 0.5 : 1;
	
	//Add Gravity
	controlVSpeed = min(controlVSpeed + grav*mult*time, term);
	
	//Short Jump if Let Go of Jump
	if (!Controller.jumpHeld && !cutVspd) { //&& controlVSpeed < -halfGravityThreshold
		controlVSpeed /= 1.6;	
		cutVspd = true;
	}
}

//
//Horizontal Movement


	//Controller Input
	controllerHorizontalMovementInput = Controller.right - Controller.left;
	var mx = controllerHorizontalMovementInput;
	
	//Run Speed
	var runSpeedMulti = 1;

	//Find Goal
	var hspdGoalsMultipliers = time * power(0.99, time) * runSpeedMulti;
	var hSpeedGoal = mx * runSpeed * hspdGoalsMultipliers;
	var slidingHspdGoal = slidingInDirection * slideSpeed * hspdGoalsMultipliers;

	//Change Goal Based on State
	if (!inControl) {
		hSpeedGoal = noControlMx * runSpeed * hspdGoalsMultipliers;
		lastNoControlMX = noControlMx;
		noControlMx = 0;
	}

		//Auto Changes in Hespeed
		if (STATE = state.combat_slide) { 
			hSpeedGoal = slidingHspdGoal; 
		}



	
	//Get Friction Values
	var slideValBase = airFrictionValue;
	var inAir = !onGround;
	if (onGround) {
		slideValBase = (groundBelow != noone) ? groundBelow.traction : 0.3;
	}

	//Do Friction
	//var originalHSpeedGoal = hSpeedGoal;
	if (inAir) {

		//Track Of Time
		timeOffGround += time;

		//In Air Speed Changes
		var holdingOppositeInAir = (sign(mx) == -sign(hSpeedGoal) && mx != 0 && timeOffGround > room_speed/2) * airFrictionValue*5;
		if (mx == 0) {
			holdingOppositeInAir = airFrictionValue
		}
	
	
		//Smooth Friction Amount
		airFrictionMultiplierLerp = lerp(airFrictionMultiplierLerp, doAirFriction, airFrictionValue/2);
	
		//Don't Allow Changes, Basically
		if (!doAirFriction) {
			//Zero Air Friction
			airFrictionMultiplierLerp = 0;
		} else {
		
			//Smoothly Change Horizontal Speed
			controlHSpeed = lerp(controlHSpeed, hSpeedGoal, (airFrictionValue + holdingOppositeInAir)*airFrictionMultiplierLerp);
			//knockbackHSpeed = lerp(knockbackHSpeed, 0, airFrictionValue);
		}

	//On Ground Frinction
	} else {
	
		//Normal Air Friction on next jump
		airFrictionMultiplierLerp = 1;
	
		//Use Ground Friction
		controlHSpeed = lerp(hSpeed, hSpeedGoal, slideValBase);
		//knockbackHSpeed = lerp(knockbackHSpeed, 0, slideValBase);
	
		//On Ground Stuff
		allowHalfGravity = true;
		cutVspd = false;
	
		//Keep Track
		timeOffGround = -1;	
		lastOnFloorAtY = y;
		lastOnFloorAtX = x;
		hasJumpedOffWallSinceOnGround = false;
	
	}
	
	//Round Out
	controlHSpeed = sign(controlHSpeed) * floor(abs(controlHSpeed) * 100) / 100;
	hSpeed = controlHSpeed

//Dir Facing
if (STATE == state.base && abs(controlHSpeed) >= 0.01) {
	directionFacing = (hSpeedGoal != 0 && inControl) ? sign(hSpeedGoal) : sign(controlHSpeed);
}

//Collision
	//Update Mask
	mask_index = mask;

//Horizontal Collision
var moveX = (controlHSpeed)*time
if (place_meeting(x + moveX, y, Solid)) {
	
	//Approach Wall until meeting
	var sigMoveX = sign(moveX)
	while(!place_meeting(x+sigMoveX, y, Solid)) {
		x += sigMoveX;
	}
	
	//Impact Splat
	squishX = -clamp((abs(moveX)-2)/4, 0, 0.5);
	
	//Set Wall Direction
	lastWallInDirection = wallInDirection;
	wallInDirection = sigMoveX;
	
	//Reset Movement Vals
	moveX = 0;
	hSpeed = 0;
	controlHSpeed = 0;
}
x += moveX;



//Vertical Collision
var moveY = (controlVSpeed)*time;
if (place_meeting(x, y+moveY, Solid)) {

	//Back Onto Wall
	while(!place_meeting(x, y+sign(moveY), Solid)) {
		y += sign(moveY);
	}
	
	//Slide Around Corner
	var stopVspeed = true;
	if (controlVSpeed < -1) {
		if (!place_meeting(x+slideCornerRange+controlHSpeed, y-2+controlVSpeed, Solid)) {
			controlHSpeed = max(controlHSpeed, 1.5);
			stopVspeed = false;
		}
		
		if (!place_meeting(x-slideCornerRange+controlHSpeed, y-2+controlVSpeed, Solid)) {
			controlHSpeed = min(controlHSpeed, -1.5);
			stopVspeed = false;
		}
		
		//Squish on Head Hurt
		if (stopVspeed) {
			squishX = squishOffset * 1.5;
			squishY = -squishOffset * 0.3;
		}
	}
	

	//Reset Speed
	moveY = 0;
	
	if (stopVspeed) {
		moveY = 0;
		vSpeed = 0;
		controlVSpeed = 0;
		allowHalfGravity = false;
	}
}
y+=moveY;


//Collision Detection
var wasOnGround = onGround;
groundBelow = instance_place(x, y+1, Solid);
onGround = (groundBelow != noone)

//Land Detection
if (onGround && !wasOnGround) {
	squishX = squishOffset;
	squishY = -squishOffset/2;
	
	//Reset State
	if (STATE == state.climb) {
		STATE = state.base;	}
	
	//Double Jump
	allowCoyoteeJump = true;
	
	//Attacks
	allowCombatAirUp = true;
}

//
//Run Detection
var countAsRunThreshhold = 1.5;
var running = abs(hSpeed) > runSpeed - countAsRunThreshhold;
runningForTime = (running) ? runningForTime + Game.delta : -1;



//Climbing
timeNotClimbing += time;
if (wallInDirection != 0) {

	//Remeber Wall
	lastWallInDirection = wallInDirection;
	lastWallMeeting = instance_place(x + wallInDirection, y, Solid)

	//Check if techinically climbing
	var climbing = (STATE == state.climb || STATE == state.wall_cling);

	//Switch To Climb State
	if (!onGround && !climbing) {
		
		//Only switch to climbing if not being "used" by player
		if (STATE == state.base) {
			
			//Get ydifference
			var ydiff = lastOnFloorAtY - y;
			
			//Make sure It makes sense to connect to wall
			if (ydiff > 20 || ydiff < 0 || abs(lastOnFloorAtX-x) > 32) || hasJumpedOffWallSinceOnGround { //Must be at least 2.5 tiles off the ground if ne
			 
				//Must be climbable alittle above
				//Prvent climbable when only feet touching
				if (place_meeting(x + wallInDirection, y - 20, Solid)) {
					STATE = state.climb;	
					climbing = true;
				}
			}
		
		
			//Just switched to climbing from not climbing; see if I'm on the edge of a tile
			//Wall Edge Hold
			if (climbing) {
				if (!place_meeting(x + wallInDirection, y-24, Solid)) {
					STATE = state.wall_cling;
					climbing = true;
				}
			}
		}
		//
		//
		if (!climbing) {
			STATE = state.base;	
		} else {
		
		//Enter A Climbing State; Remove Sliding Damage
			//Set State To Recovery State
			if (haveSlideDamage) {
				damageObj.allowLifeDecay = true;
				damageObj.life = -1;
				haveSlideDamage = false;
			}
		}
		
	//Climbing
	} else {
		
		if (STATE == state.climb) {
		
			//Wall Edge Hold
			if (climbing) {
				if (!place_meeting(x + wallInDirection, y-24, Solid)) {
					STATE = state.wall_cling;
					climbing = true;
				}
			}
			
		}
	}

	
	//Reset Tracking Of Time
	if (climbing) {
		timeNotClimbing = -1;
	}
	
	
	//Reset STATE
	if (lastWallMeeting == noone) {
		wallInDirection = 0;
		
		//Exit Climb
		if (climbing) {
			STATE = state.base;
		}
	}
} else {

	//Allow For Wall Jump, even if Iturned away before I connected
	if (!onGround) {
		
		var v = instance_place(x - directionFacing*3, y + controlVSpeed, Solid)
		
		if (v != noone) {
			wallJumpNotConnectedTimeLeft = wallJumpNotConnectedForgivenessTime;		
			lastWallMeeting = v;
			wallInDirection = -directionFacing;
		}
	}
	
}
wallJumpNotConnectedTimeLeft -= time;




//Jump
//
if (Controller.jump || forceJump) {
	jumpTicks = preLandJumpsTime;	
}

//Check Jump
jumpCooldownTicks -= time;

if (jumpTicks > 0) {
	jumpTicks -= time;
	
	var wallClinging = (STATE == state.wall_cling);
	var climbing = (STATE == state.climb || wallClinging);

	//Coyottee Time AND Wait for until on ground.
	var walkedOffPlatform = (y - lastOnFloorAtY > 0)
	var onGroundJump = (onGround || timeOffGround < coyoteeMaxTime*walkedOffPlatform) //&& jumpCooldownTicks < 0;
	
	var wallJump = climbing && (timeNotClimbing < wallClimbCoyoteeTime && mx != lastWallInDirection);
	var verticalClimb = climbing && ((canVerticalClimb || wallClinging) && (mx == lastWallInDirection));
	var doubleJump = false;
	var bounceOffEnemy = bouncingOffEnemy && forceJump;
	
	var successfulJumpCheck = onGroundJump || wallJump || verticalClimb|| bounceOffEnemy;
	
	//Fail Check
	if (!successfulJumpCheck) {successfulJumpCheck = wallJumpNotConnectedTimeLeft > 0;}	
	
	
	
	if (inControl || forceJump) {
		if (successfulJumpCheck) {
		
			//Jump Universal
			jumpTicks = 0;
			jumpCooldownTicks = coyoteeMaxTime + 2;
			forceJump = false;
			bouncingOffEnemy = false;
		
			//Bounce Off Enemy
			if (bounceOffEnemy) {
				onGroundJump = false;
				wallJump = false;
				verticalClimb = false;
				doubleJump = false;
				
				controlVSpeed += jumpSpeed * bounceJumpCoefficient; 
				squishX = -squishOffset;
				squishY = squishOffset;
			}
		
			//Set Speeds
			if (onGroundJump) {
				
				var mom = 0; //u
				controlVSpeed = jumpSpeed + mom; 
				squishX = -squishOffset;
				squishY = squishOffset;
				
				wallJump = false;
			}

		
			//Jump Straight Up
			if (verticalClimb || wallClinging) {
			
				//Push Away from the wall
				controlHSpeed = -wallInDirection * wallClingVerticalJumpWallPushOffForce * wallClinging
				controlVSpeed = wallJumpSpeed; 
				squishX = -squishOffset;
				squishY = squishOffset;
		
				//Stop
				wallJump = false;
				STATE = state.base;
				wallInDirection = 0; //Resrt wall checks
		
			}
		
		
			//Jump Off Wall 
			if (wallJump) {
			
				//Decide Vector
				var spd = wallJumpSpeed;
				var jumpingAngle = 90 + wallInDirection*wallJumpAngle;
			
				controlHSpeed = -lengthdir_x(spd, jumpingAngle);	
				controlVSpeed = -lengthdir_y(spd, jumpingAngle); 
			
				squishX = -squishOffset*1.3;
				squishY = squishOffset*1.25;
				
				directionFacing = sign(controlHSpeed);
			
				//Cannot Turn Around For A Short Amount of Time
				airFrictionMultiplierLerp = 0.3;
				
				hasJumpedOffWallSinceOnGround = true;
			}
		}
	}
}



//Attack Input
if (Controller.combatAttackPressed) {
	//Decide Attack
	keira_decide_attack_state();
}

//Switch To Attack
if (nextAttack != state.height) {
	
	//Allow for input of attacks before "begun" current attack
	wantToChangeAttackTicks -= time;
	if (wantToChangeAttackTicks > 0) { //This might be backwards
		
		//Make Sure Attack is finished
		if (STATE == state.base) {
			
			//Set New Attack
			STATE = nextAttack;
			
			//Reset Animation (Otherwise will end if Playing same one)
			image_index = 0;
			useFrontAttackSprite = !useFrontAttackSprite;
			
			//Decide Attack Sprites
			keira_decide_attack_sprite(nextAttack);
			
			//Reset Vars
			nextAttack = state.height;
			createdDamage = false;
		}
	}
}

//
//Hurt State
if (STATE == state.hurt) {
	
	//No Control
	inControl = false;
	
	//Reset State
	hurtTime -= time;
	if (hurtTime< 0) {
		STATE = state.base;	
	}
	
} else {
	//Invulnerability Time Post Damage
	invulnerableTicks -= time;	
}


//Other

event_user(0);