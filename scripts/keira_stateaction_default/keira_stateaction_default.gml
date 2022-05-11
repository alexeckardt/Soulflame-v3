//
//DESC:
//
//Sorry for the ugly if statement code
//I don't like it but it's just a longer state machine
//
function keira_stateaction_default() {
	
	var mmx = (inControl) ? mx : lastNoControlMX;
	
	if (!inControl) {
		var hi = false;	
	}
	
	var time = Game.delta;
	var running = onGround && mmx != 0;		
		
	var currentIdleSprite = keira_get_movement_sprite("Idle");
	var currentReadySprite = keira_get_movement_sprite("IdleReady");
	var currentRunSprite = keira_get_movement_sprite("Run");
	var currentLandStandSprite = keira_get_movement_sprite("Land");
	var currentLandRunningSprite = keira_get_movement_sprite("LandRunning");
	var currentClimbAttachSprite = keira_get_movement_sprite("ClimbAttach");
	var currentClimbIdleSprite = keira_get_movement_sprite("ClimbIdle");
	var currentClimbEdgeHold = keira_get_movement_sprite("ClimbEdgeHold");
	var currentLookUpSprite = keira_get_movement_sprite("LookUp");
	var spriteKeyIs = "Idle";
		
	var sprGoal = sprite_index;

	//
	//
	//Jumping Animation
	if (!onGround) {
		
		//
		//
		if (STATE == state.climb) {
			

			//Attach
			if (directionFacing == wallInDirection) {
				
				if (!climbAttachAnimationPlayed) {
			
					//Exit
					sprGoal = currentClimbAttachSprite;
					index_speed = 0.25;
				
					//Reset; Don't play anmation again
					if (image_index + index_speed >= image_number - index_speed) {
						climbAttachAnimationPlayed = true;	
					}
				} else {
			
					//Idle Sprite
					sprGoal = currentClimbIdleSprite
					index_speed = 0.1;
		
				}
				
			}
			
			
		} else 
		if (STATE == state.wall_cling) {
			
			//Hold First Frame
			sprGoal = currentClimbEdgeHold;
			index_speed = 0;
			image_index = 0;
			
		} else
		if (STATE == state.look_up) {
		
			sprGoal = currentLookUpSprite;
			index_speed = 0;
			
		}
		else {
			
			//
			var dTo0 = point_distance(vSpeed, 0, 0, 0); 		
			index_speed = 0.4;
		
			if (vSpeed <= 0) {

				//
				//UP
				if (dTo0 > 2) {
				
					//Up Fast
					sprGoal = (sKeiraJumpUpFast);
				
				
				//SLOW
				} else {
				
					//Up Slow
					sprGoal = (sKeiraJumpUpSlow);
				}
		
			//
			//FALL
			} else {
		
				//Make Sure Not To Transition
				if (!place_meeting(x, y+3, Solid)) {
				
					//FAST
					if (dTo0 > 2) {
				
						//Fast Slow
						sprGoal = (sKeiraJumpDownFast);
				
				
					//SLOW
					} else {
				
						//Down Slow
						sprGoal = (sKeiraJumpDownSlow);
				
						//Dont Loop Switch Part
						if (image_index + index_speed > image_number - index_speed) {
							image_index = 2;	
						}
					}
				
				}
			
			} 
		
		//End Climb
		}
	
	//On Ground
	} else {
		
		
		//Running Animation		
		if (running) {
			
			displayReadyPosForTime = 0;
			index_speed = 0.4;
		
			sprGoal = (currentRunSprite);
			spriteKeyIs = "Run";
		
			randomize();
			if (irandom(100) < 10) {
				particle_create_dust(x-3+hSpeed, y+6, x+3+hSpeed, y+7, choose(1, 2, 3));
			}
		
		
		//Standing
		} else {
			
			displayReadyPosForTime -= time;
			var idleSpr		= (displayReadyPosForTime > 0) ? currentReadySprite : currentIdleSprite;
				spriteKeyIs = (displayReadyPosForTime > 0) ? "IdleReady" : "Idle";
			
			sprGoal = (idleSpr);
			index_speed = 0.2;
			
		}

		//
		//Land Animation
		if (showLandAnimation) {
			
			//Set Next Goal
			index_speed = 0.3;
			sprGoal = (runningLandAnimation) ? currentLandRunningSprite : currentLandStandSprite;
			
			
			//Stop Land Animation on Animation Finish
			if (sprGoal == sprite_index) {
				if (image_index + index_speed > image_number - index_speed) {
					showLandAnimation = false;
				}
			}
			
		}
		 



	//End on Ground
	}
	
	//
	//
	sprite_switch_to(sprGoal);

	//Control
	var giveControl = (true);
	var cutsceneObj = instance_nearest(x, y, Cutscene);
	if (cutsceneObj != noone) {
		giveControl = cutsceneObj.playerHasControlDuringCutscene;
	}
	
	inControl = giveControl;
	
	//Update Weapon Sprite
	weaponSprite = keira_get_movement_sprite_weapon(spriteKeyIs)
	
}