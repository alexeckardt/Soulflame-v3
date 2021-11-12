/// @desc

var time = Game.delta



//Gravity
if (timeOffGround > -1) {

	//Choose Values
	var grav = myGrav * ((STATE == state.climb && controlVSpeed > 0) ? climbingGravMulti : 1);
	var term = (STATE != state.climb) ? terminalVelocity : climbingTermVel;

	//Gives Hang Time If Jump is Still Held
	var mult = (abs(controlVSpeed) < halfGravityThreshold && (Controller.jumpHeld || forceHalfGravity) && allowHalfGravity) ? 0.5 : 1;
	
	//Add Gravity
	controlVSpeed = min(controlVSpeed + grav*mult*time, term);
	
	//Short Jump if Let Go of Jump
	if (!Controller.jumpHeld && controlVSpeed < -halfGravityThreshold && !cutVspd) {
		controlVSpeed /= 1.6;	
		cutVspd = true;
	}
}

//
//Horizontal Movement


	//Controller Input
	var mx = Controller.right - Controller.left;

	//Run Speed
	var runSpeedMulti = 1;

	//Find Goal
	var hspdGoalsMultipliers = time * power(0.99, time) * runSpeedMulti;
	var hSpeedGoal = mx * runSpeed * hspdGoalsMultipliers * inControl;

	
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
		lastOnFloorAtX = x
	
	}
	
	//Round Out
	controlHSpeed = sign(controlHSpeed) * floor(abs(controlHSpeed) * 100) / 100;
	hSpeed = controlHSpeed

//Dir Facing
directionFacing = (controlHSpeed != 0 && inControl) ? sign(controlHSpeed) : directionFacing;


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
var wasOnGround = onGround
groundBelow = instance_place(x, y+1, Solid);
onGround = (groundBelow != noone)


//Land Detection
if (onGround && !wasOnGround) {
	squishX = squishOffset;
	squishY = -squishOffset;
	
	//Reset State
	if (STATE == state.climb) {
		STATE = state.base;	}
	
	//Double Jump
	
	//Attacks
	allowCombatAirUp = true;
}

//Climbing
timeNotClimbing += time;
if (wallInDirection != 0) {

	//Remeber Wall
	lastWallInDirection = wallInDirection;
	lastWallMeeting = instance_place(x + wallInDirection, y, Solid)

	var climbing = (STATE == state.climb);

	//Switch To Climb State
	if (!climbing) {
		if (lastOnFloorAtY - y > 20 || abs(lastOnFloorAtX-x) > 32) { //Must be at least 2.5 tiles off the ground if ne
			STATE = state.climb;	
			climbing = true;
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
}


//Jump
//
if (Controller.jump || forceJump) {
	jumpTicks = preLandJumpsTime;	
}

//Check Jump
jumpCooldownTicks -= time;
if (jumpTicks > 0) {
	jumpTicks -= time;
	
	var climbing = (STATE == state.climb);
	
	//Coyottee Time AND Wait for until on ground.
	var onGroundJump = timeOffGround < coyoteeMaxTime && jumpCooldownTicks < 0;
	var wallJump = climbing && (timeNotClimbing < wallClimbCoyoteeTime && (directionFacing == -lastWallInDirection || !canVerticalClimb));
	var verticalClimb = climbing && (canVerticalClimb && directionFacing == lastWallInDirection);
	var doubleJump = false;
	var bounceOffEnemy = bouncingOffEnemy && forceJump;
	
	if (inControl || forceJump) {
		if (onGroundJump || wallJump || bounceOffEnemy) {
		
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
				controlVSpeed += jumpSpeed; 
				squishX = -squishOffset;
				squishY = squishOffset;
				
				wallJump = false;
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
			
				//Cannot Turn Around For A Short Amount of Time if I can't climb stragit
				airFrictionMultiplierLerp *= canVerticalClimb;
			}
		
			if (verticalClimb) {
			
				controlVSpeed = wallJumpSpeed + vMomentum; 
				squishX = -squishOffset;
				squishY = squishOffset;
		
			}
		}
	}
}