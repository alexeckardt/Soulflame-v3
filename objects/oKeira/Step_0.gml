/// @desc

var time = Game.delta

//Squish and Squash
squishX = lerp(squishX, 0, squishReturnSpeed*time);
squishY = lerp(squishY, 0, squishReturnSpeed*time);

//Prelims
var transitionPlaying = instance_nearest(x, y, oRoomTransition);
if (transitionPlaying != noone) {
	
	if (transitionPlaying.freezePlayer) {
		inControl = false;
	}
	
	//Opening Transition Reccognize If I have to move to a good position
	if (openingTransition) {
		roomTransitionPositioning = true;
		
		if (y > room_height) {
			roomTransitionComingFromBelow = true;}
	}
	
} else {
	openingTransition = false;	
	
	//Make Sure I've been in the room before I go through door
	if (!hasBeenInRoom) {
		var b = 32;
		hasBeenInRoom = y > b && y < room_height-b;
	}
}

//
//
//

//Water
var waterMeeting = instance_position(x, y, oWater);
inWater = (waterMeeting != noone);
if (inWater) {
	waterDepth = abs(y - waterMeeting.y);
	waterDepthPercent = clamp(waterDepth / waterDragRange, 0, 1);
}

//Gravity

	vSpeed += controlVSpeed;
	controlVSpeed = 0;

	//Choose Values
	var grav = myGrav * ((STATE == state.climb && vSpeed > 0) ? climbingGravMulti : 1);
		grav *= (STATE != state.hurt_spikes)
	var term = (STATE != state.climb) ? terminalVelocity : climbingTermVel;

	//Stop Vspeed If Clinging To A wall
	if (STATE == state.wall_cling) {
		grav = 0;
		term = 0;
		vSpeed = 0;
	}

	//Gives Hang Time If Jump is Still Held
	var doHalfGrav = abs(vSpeed) < halfGravityThreshold && (Controller.jumpHeld || forceHalfGravity) && allowHalfGravity;
	var mult = (doHalfGrav) ? 0.5 : 1;
	
	//Water
	if (inWater) {
		grav = waterGrav;
		term = lerp(waterTerm, waterMaxTerm, waterDepthPercent);
		
		if (abs(vSpeed) > term) {
			vSpeed = lerp(vSpeed, vSpeed*sign(vSpeed), 0.05*time); 
		}
	}
	
	
	//Add Gravity
	vSpeed = min(vSpeed + grav*mult, term*time);
	
	//Short Jump if Let Go of Jump
	if (!Controller.jumpHeld && !cutVspd) { //&& controlVSpeed < -halfGravityThreshold
		vSpeed /= 1.6;	
		cutVspd = true;
	}
	
	//Knockback Vspeed
	if (knockbackVSpeed != 0) {
		vSpeed += knockbackVSpeed;
		knockbackVSpeed = 0;
	}


//
//Horizontal Movement


	//Controller Input
	controllerHorizontalMovementInput = Controller.right - Controller.left;
	mx = controllerHorizontalMovementInput*(!Game.someUIopen);
	
	//Find Goal
	var hspdGoalsMultipliers = keira_decide_hspeed_goal_multi();
	var hSpeedGoal = mx * runSpeed * hspdGoalsMultipliers;

	//No Control Movement
	if (!inControl) {
		var spd = (runNoControl) ? runSpeed : walkSpeed;
		hSpeedGoal = noControlMx * spd * hspdGoalsMultipliers;
		lastNoControlMX = noControlMx;
		noControlMx = 0;
	}

	//Change Goal Based on State
		//Auto Changes in Hespeed
		if (STATE = state.combat_slide) { 
			var slidingHspdGoal = slidingInDirection * slideSpeed * hspdGoalsMultipliers;
			hSpeedGoal = slidingHspdGoal; 
		}
		if (onGround && Player.weaponUsing = weapon.sword
			&& (STATE == state.combat_neutral || STATE == state.combat_running) ) {
			hSpeedGoal /= 2;
		}

	
	//Get Friction Values
	var slideValBase = airFrictionValue; 
	var inAir = !onGround;
	if (onGround) {
		slideValBase = (groundBelow != noone) ? groundBelow.traction : 0.3;
		slideValBase /= (!inControl+1)
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
		airFrictionMultiplierLerp = lerp(airFrictionMultiplierLerp, doAirFriction, airFrictionValue/2*time);
	
		//Don't Allow Changes, Basically
		if (!doAirFriction) {
			//Zero Air Friction
			airFrictionMultiplierLerp = 0;
		} else {
		
			//Smoothly Change Horizontal Speed
			var airFrictionVal = (inControl) ? airFrictionValue : airFrictionValue/15; //Hold with no control
			controlHSpeed = lerp(controlHSpeed, hSpeedGoal, (airFrictionVal + holdingOppositeInAir)*airFrictionMultiplierLerp*time);

		}

	//On Ground Frinction
	} else {
	
		//Normal Air Friction on next jump
		airFrictionMultiplierLerp = 1;
	
		//Use Ground Friction
		controlHSpeed = lerp(hSpeed, hSpeedGoal, slideValBase*time);
	
		//On Ground Stuff
		allowHalfGravity = true;
		cutVspd = false;
	
		//Keep Track
		timeOffGround = -1;	
		lastOnFloorAtY = y;
		lastOnFloorAtX = x;
		hasJumpedOffWallSinceOnGround = false;
	
	}

	//Knockback Reduce
	var kbFriction= (groundBelow != noone) ? groundBelow.traction/3		: airFrictionValue;
	knockbackHSpeed = lerp(knockbackHSpeed, 0, kbFriction);
	
	//Round Out
	controlHSpeed = sign(controlHSpeed) * floor(abs(controlHSpeed) * 100) / 100;
	hSpeed = controlHSpeed

//Dir Facing
if (STATE == state.base && abs(controlHSpeed) >= 0.01) {
	
	//Set
	directionFacing = (hSpeedGoal != 0) ? sign(hSpeedGoal) : directionFacing;
}

//
//Room Transition
//
if (roomTransitionPositioning) {

	//Turn Off
	inControl = false;

	//If Above; No Gravity/room
	if (y < 0) {
		
		//Stasis if Transition
		if (transitionPlaying != noone) {
			vSpeed = 0;
			hSpeed = 0;}
		
	} else
	if (roomTransitionComingFromBelow) {
	
		//
		var nearestSolidXoff = 0;
		while (!place_meeting(orgX + directionFacing*nearestSolidXoff, room_height-2, Solid) || nearestSolidXoff > room_width) nearestSolidXoff++;
	
		//Keep Track of (if i reach good height, Ignore that theres a wall so don't move up)
		var wallThere = place_meeting(orgX + directionFacing*nearestSolidXoff, y, Solid);
		var shouldGoUp = (wallThere || y > room_height);
		if (!shouldGoUp) {
			reachedGoodHeightRoomOpening = true;}
		
		//Move Up Until Platform is free
		if (shouldGoUp) && (!reachedGoodHeightRoomOpening) {
			
			//Keep Momentum
			vSpeed = -4;	
			controlHSpeed = 0;
			
		} else {
			
			//Move Towards my goal
			controlHSpeed = directionFacing*(nearestSolidXoff/16);	
			
		}
		
	}
	
	//Exit
	if (onGround) {
		roomTransitionPositioning = false;	
		controlHSpeed = 0;
	}

}

//Collision
	//Update Mask
	mask_index = mask;

//Ramps
var range = 5;
var moveY = (vSpeed*time);
var moveX = (controlHSpeed + knockbackHSpeed)*time;

//Going Down a Ramp
if (place_meeting(x, y+1, Solid) && !place_meeting(x+moveX, y+1, Solid)) {
	for (var i = 1; i < range; i++) {
		if (place_meeting(x+moveX, y+i+1, Solid)) {
			y += i;
			
			slideSpeed += 0.2;
			
			break;
		}
	}
}


//Setup Collision
var collisionPercision = 1/100;

//Deactivate All One ways that are above my feet
var top = 32;
instance_deactivate_object(OneWaySolid);
instance_activate_region(x - 30, bbox_bottom+15, 60, top, true);

//Vertical Collision
var vCollideSolid = instance_place(x, y+moveY, Solid);
if (vCollideSolid) {

	//Not Oneway
	var underOneway = vCollideSolid.oneway && (bbox_bottom >= vCollideSolid.y);
	if (!underOneway) {
		
		//Back Onto Wall
		repeat (ceil(abs(moveY/collisionPercision))) {
			if (!place_meeting(x, y+sign(moveY)*collisionPercision, Solid)) {
				y += sign(moveY)*collisionPercision;
			} else {
				break;	
			}
		}
	
		//Slide Around Corner
		var stopVspeed = true;
		
		if (moveY < -1) {
			if (!place_meeting(x+slideCornerRange+controlHSpeed, y-2+moveY, Solid)) {
				controlHSpeed = max(controlHSpeed, 1.5);
				stopVspeed = false;
			}
		
			if (!place_meeting(x-slideCornerRange+controlHSpeed, y-2+moveY, Solid)) {
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
		
	} else {
		//Reset, Don't count as floor
		vCollideSolid = noone;	
	}
}
y+=moveY;

	//Ground Collision Detection
	var wasOnGround = onGround;
	if (vSpeed >= 0) {
		groundBelow = instance_place(x, y+1+vSpeed, Solid);
		
		//Don't set ground below if inside a one way unless i'm on it
		if (instance_exists(groundBelow)) {
			if (groundBelow.oneway) {
				if (bbox_bottom >= groundBelow.y) {
					groundBelow = noone;
				}
			}
		}

		onGround = (groundBelow != noone);
	} else {
		
		groundBelow = noone;
		onGround = false;
			
	}


//Update moveX
moveX = (controlHSpeed + knockbackHSpeed)*time;

//Going Up a Ramp
if (onGround && place_meeting(x+moveX, y, Solid)) {
	
	for (var i = 0.1; i < abs(moveX); i += 0.1) {
		if (place_meeting(x+sign(moveX)*i, y, Solid) && !place_meeting(x+sign(moveX)*i, y-1, Solid)) {
			y--;
			slideSpeed -= 0.1;
		}
	}
	
}

//Horizontal Collision
var currentHCollide = instance_place(x + moveX, y, Solid)
var actualHCollide = noone;
if (currentHCollide != noone) {

	//Back Onto Wall
	var freeSpot = true;
	repeat (ceil(abs(moveX/collisionPercision))) {
			
		//Back Onto Wall
		repeat (ceil(abs(moveX/collisionPercision))) {
			if (!place_meeting(x+sign(moveX)*collisionPercision, y, Solid)) {
				x += sign(moveX)*collisionPercision;
			} else {
				freeSpot = false;
				actualHCollide = instance_place(x+sign(moveX)*collisionPercision, y, Solid);
				break;	
			}
		}
		
	}
	
	//Collision Happened?
	if (!freeSpot) {
		
		//Impact Splat
		squishX = -clamp((abs(moveX)-2)/4, 0, 0.5);
	
		//Set Wall Direction
		lastWallInDirection = wallInDirection;
		wallInDirection = sign(moveX);
		
		//Reset
		hSpeed = 0;
		controlHSpeed = 0;
	}	
	
	//
	//Don't Duplicate Movement
	moveX = 0;
	
}
x += moveX;
clamp(x, 0, room_width);

//Land Detection
if (onGround && !wasOnGround) {
	squishX = squishOffset;
	squishY = -squishOffset/2;
	
	//Land
	if (!inWater) {
		particle_create_dust(x-4, y+8, x+4, y+6, 5+moveY); }
			
	//Reset State
	if (STATE == state.climb) {
		STATE = state.base;	}
	
	//Double Jump
	allowCoyoteeJump = true;
	
	//Attacks
	allowCombatAirUp = true;
	
	//Land 
	showLandAnimation = (STATE == state.base);
	runningLandAnimation = (mx != 0);
}

//
//Run Detection
var countAsRunThreshhold = 1.5;
var running = abs(hSpeed) > runSpeed - countAsRunThreshhold && STATE == state.base;
runningForTime = (running) ? runningForTime + Game.delta : -1;

//Climbing
timeNotClimbing += time;
if (wallInDirection != 0 && inControl) {

	//Remeber Wall
	lastWallInDirection = wallInDirection;
	lastWallMeetingInstance = (actualHCollide != noone) ? actualHCollide : lastWallMeetingInstance;
	lastWallMeeting = instance_place(x + wallInDirection, y, lastWallMeetingInstance); //save even if no longer doing h collision

	//Check if techinically climbing
	var climbing = (STATE == state.climb || STATE == state.wall_cling);
	var wallPosX = x + wallInDirection*8;
	
	//Switch To Climb State
	if (instance_exists(lastWallMeeting)) {
		
		if (!onGround && !climbing) {
		
			if (!lastWallMeeting.oneway) {
		
				//Only switch to climbing if not being "used" by player
				if (STATE == state.base) {
			
					//Get ydifference
					var ydiff = lastOnFloorAtY - y;
			
					//Make sure It makes sense to connect to wall
					if (ydiff > 20 || ydiff < 0 || abs(lastOnFloorAtX-x) > 32) || hasJumpedOffWallSinceOnGround { //Must be at least 2.5 tiles off the ground if ne
			 
						//Must be climbable alittle above
						//Prvent climbable when only feet touching
						if (position_meeting(wallPosX, y-7, Solid)) {	
							STATE = state.climb;
							climbing = true;
							directionFacing = wallInDirection;
					
							wallJumped = false;
						}
					}
		
		
					//Just switched to climbing from not climbing; see if I'm on the edge of a tile
					//Wall Edge Hold
					if (climbing) {
						if (!position_meeting(wallPosX, y-12, Solid) || !position_meeting(wallPosX, y-14, Solid)) { //no solid at head
							
							STATE = state.wall_cling;
							wallClingingonto = instance_position(wallPosX, y-7, Solid);
							climbing = true;
							directionFacing = wallInDirection;
					
							wallJumped = false;
						}
					}
				}
			
				//
				//
				if (!climbing) {
					STATE = state.base;	
					climbAttachAnimationPlayed = false;
					wallJumped = false;
				} else {
		
				//Enter A Climbing State; Remove Sliding Damage
					//Set State To Recovery State
					if (haveSlideDamage) {
						damageObj.allowLifeDecay = true;
						damageObj.life = -1;
						haveSlideDamage = false;
					}
				}
		
			}	
		
		//Climbing
		} else {
		
			if (STATE == state.climb) {
		
				//Wall Edge Hold
				if (climbing) {
					if (position_meeting(wallPosX, y-7, Solid)) {
						if (!position_meeting(wallPosX, y-12, Solid) || !position_meeting(wallPosX, y-14, Solid)) { //no solid at head
							STATE = state.wall_cling;
							wallClingingonto = instance_position(wallPosX, y-7, Solid);
						}
					}
				}
			
				//Cling
				if (!inWater) {
				particle_create_dust(x + lastWallInDirection*5, y-10, x + lastWallInDirection*5, y+6, -10);}
			
			}
		}

		//Reset Tracking Of Time
		if (climbing) {
			timeNotClimbing = -1;
		}
	
	}
	
	//Reset STATE
	if (lastWallMeeting == noone) {
		wallInDirection = 0;
		
		//Exit Climb
		if (climbing) {
			STATE = state.base;
			climbAttachAnimationPlayed = false;
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
	
	//
	//Stop clinging if I get pushed off corner (error case)
	if (STATE == state.wall_cling) {	
		if (!place_meeting(x + wallInDirection*2, y, wallClingingonto)) {
			STATE = state.base;
			wallClingingonto = noone;
		}
	}
	
}
wallJumpNotConnectedTimeLeft -= time;




//Jump
//
if (!Game.someUIopen) {
	if (Controller.jump || forceJump) {
		jumpTicks = preLandJumpsTime;	
		
		if (!onGround) {
			var i = 0;	
		}
	}
}

//Check Jump
jumpCooldownTicks -= time;

if (jumpTicks > 0) {
	jumpTicks -= time;
	
	var wallClinging = (STATE == state.wall_cling);
	var climbingCheck = !wallJumped && (STATE == state.climb || wallClinging || timeNotClimbing < wallClimbCoyoteeTime);
	
	var pastWall = instance_place(x - mx*4, y, Solid);
	var futureWall = instance_place(x + sign(controlHSpeed)*2, y, Solid);
	
	var wasOnWall = pastWall != noone;
	var willBeOnWall = futureWall != noone && !climbingCheck;

		//Dpn't Jump off one way walls
		if (wasOnWall) {wasOnWall = !pastWall.oneway}
		if (willBeOnWall) {willBeOnWall = !futureWall.oneway}

	//Coyottee Time AND Wait for until on ground.
	var walkedOffPlatform = (y - lastOnFloorAtY > 0)
	var onGroundJump = (onGround || timeOffGround < coyoteeMaxTime*walkedOffPlatform) //&& jumpCooldownTicks < 0;
	
	var wallJump = (climbingCheck || willBeOnWall) && (wasOnWall && mx != lastWallInDirection || (mx == 0 && !canVerticalClimb));
	var verticalClimb = climbingCheck && ((canVerticalClimb || wallClinging) && (mx == lastWallInDirection));
	var doubleJump = false;
	var bounceOffEnemy = bouncingOffEnemy && forceJump;
	
	//Update Wall Jump
	wallJump = wallJump || (wallClinging && mx == -wallInDirection);
	
	//Check
	var successfulJumpCheck = onGroundJump || wallJump || verticalClimb|| bounceOffEnemy;
	
	//Fail Check
	//if (!successfulJumpCheck) {successfulJumpCheck = wallJumpNotConnectedTimeLeft > 0;}	
	
	
	
	if (inControl || forceJump) {
		if (successfulJumpCheck) {
		
			//Jump Universal
			jumpTicks = 0;
			jumpCooldownTicks = coyoteeMaxTime + 2;
			forceJump = false;
			bouncingOffEnemy = false;
		
			//Bounce Off Enemy
			if (bounceOffEnemy) {
				
				//Don't Jump Again
				onGroundJump = false;
				wallJump = false;
				verticalClimb = false;
				doubleJump = false;
				
				//Set Baseline
				controlVSpeed = -2;
				
				//Real Update
				if (vSpeed < 0) {
					var goalVspd = jumpSpeed * bounceJumpCoefficient;
					goalVspd = goalVspd - vSpeed;
					
					if (goalVspd < 0) {
						controlVSpeed = goalVspd; }
				}
				
				squishX = -squishOffset;
				squishY = squishOffset;
			}
		
			//Set Speeds
			if (onGroundJump) {
				
				var mom = 0; //u
				vSpeed = jumpSpeed + mom; 
				squishX = -squishOffset;
				squishY = squishOffset;
				
				wallJump = false;
				
				if (!inWater) {
				particle_create_dust(x-5, y+8, x+5, y+8, 5);}
			}
			
			//Jump Off Wall 
			if (wallJump) {
			
				wallJumped = true;
				
				//Exit Edge Cling
				wallClinging = false;
				STATE = state.base
			
				//Decide Vector				
				var d = (willBeOnWall) ? sign(controlHSpeed) : lastWallInDirection;
				var spd = wallJumpSpeed;
				var jumpingAngle = 90 + d*wallJumpAngle;
			
				controlHSpeed = -lengthdir_x(spd, jumpingAngle);	
				vSpeed = -lengthdir_y(spd, jumpingAngle); 
			
				squishX = -squishOffset*1.3;
				squishY = squishOffset*1.25;
				
				var newd = sign(controlHSpeed);
				directionFacing = newd != 0 ? newd : directionFacing;
			
				//Cannot Turn Around For A Short Amount of Time
				airFrictionMultiplierLerp = 0.3;
				hasJumpedOffWallSinceOnGround = true;
				
				if (!inWater) {
				particle_create_dust(x+d*5, y-4, x+d*5, y+4, 8);}
				
				//Forget Wall
				wallClingingonto = noone;
				
			}
		
			//Jump Straight Up
			if (verticalClimb || wallClinging) {
			
				wallJumped = true;
	
				//Push Away from the wall
				controlHSpeed = -wallInDirection * wallClingVerticalJumpWallPushOffForce * wallClinging
				vSpeed = wallJumpSpeed; 
				squishX = -squishOffset;
				squishY = squishOffset;
		
				//Stop
				wallJump = false;
				STATE = state.base;
				wallInDirection = 0; //Resrt wall checks
				
				if (!inWater) {
				particle_create_dust(x+wallInDirection*5, y-4, x+wallInDirection*5, y+4, 8);}
				
				wallClingingonto = noone;
		
			}
		}
	}
}



//Attack Input
//Allow input before current attack is finished.
if (Controller.combatAttackPressed) && (!Game.someUIopen) {
	wantToChangeAttackTicks = timeForPreAttacks;
	nextAttack = state.combat_empty;
}
		
if (wantToChangeAttackTicks > 0 && !Player.allowForging) {
	//Decide Attack
	keira_decide_attack_state();
} else {

	//Increment the Time since the last attack
	//DO NOT increment when deciding above because
	//some attacks use this as a check;
	//and if the edge is razor thing it could skrew with the state
	timeSinceLastAttack++;

}

//Switch To Attack
if (nextAttack != state.combat_empty) {
	
	//Allow for input of attacks before "begun" current attack
	wantToChangeAttackTicks -= time;
	if (wantToChangeAttackTicks >= 0) { //This might be backwards
		
		//Make Sure Attack is finished
		var quickAnim = (image_index >= allowNextAttackAfterIndex) && allowNextAttackAfterIndex != -1;
		if (STATE == state.base || quickAnim) {
			
			//Set New Attack
			STATE = nextAttack;
			
			//Reset Animation (Otherwise will end if Playing same one)
			image_index = 0;
			useFrontAttackSprite = !useFrontAttackSprite;
			showLandAnimation = false;
			
			//Decide Attack Sprites
			keira_decide_attack_sprite(nextAttack);
			
			//Reset Vars
			nextAttack = state.combat_empty;
			createdDamage = false;
			
			//Botch
			wantToChangeAttackTicks = -1;
			
			//Timing
			timeSinceLastAttack = -1;
			runningForTime = -1;
		} 
		
	//Reset Attack, took too long
	} else {
		nextAttack = state.combat_empty;	
	}
}

//
//Other Input
keira_healing_checks();

//Interact With Interact Trigger
interacting = false;
showInteractString = false;
if (!instance_exists(Cutscene) && inControl) {
	if (onGround) {
	
		//Check For Trigger
		var touchingTrigger = instance_place(x, y, oInteractTrigger);
		if (touchingTrigger != noone) {
	
			if (touchingTrigger.interactable) {
				
				//Display (Done In Player GUI)
				showInteractString = true;
				interactString = touchingTrigger.interactMessage;
		
				//Actual Input; send to Trigger
				if (Controller.interact) {
			
					//Send to Trigger
					touchingTrigger.activate = true;
			
				}
			}
		
		}
	}
}

//Time Direction Facing
timeFacingSameDirection++;
if (lastDirectionFacing != directionFacing) {
	timeFacingSameDirection = -1;
	lastDirectionFacing = directionFacing
}


//Spikes
keira_spikes_action();

//Scarf
keira_scarf_update();

//Other
if (!Game.paused) {
	event_user(0);}