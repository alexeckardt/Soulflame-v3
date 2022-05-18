var time = Game.delta;
var k = instance_nearest(x, y, oKeira);

//Take Damage 
enemy_take_damage();

if (justDamaged) {
	seesTarget = false;	
	spd = 0;}

//
//
if (!reloadAreaDecided) {
	
	//Deicde
	magpie_decide_reload_target();
	
	//Don't Continue
	reloadAreaDecided = true;

}

//
//
//Begin Chase Target?
if (STATE == state.base) {
	
	var visibleTarget = enemy_check_target_visible();
	if (!seesTarget) {
	
		//Timer
		sinceSeenTarget += time;
	
		//See
		if (visibleTarget) {
			seesTarget = true;
			sinceSeenTarget = 0;
		}
	}

	//Consistant
	goalSpd = 0;
	
	//Decide Where To Go (Home, Player, Lemming)
	if (holdingDroppable || !droppableExists) {

		//Moving
		goingToPickup = false;

		//Check Target Visible
		var playerIsTarget = target == k;

		//End Term Goal Position
		var EndGoalX = lastSawTargetX;
		var EndGoalY = lastSawTargetY;
	
		//Speed; Move by def
		goalSpd = maxSpeed;
	
		//Check
		if (seesTarget) {
	
			//Don't Return Home

			//Infer Time Path
			inferPathTimeLeft -= time;
			if (enemy_check_target_visible(target, sightRange*1.5)) {
				inferPathTimeLeft = inferPathTime;}
	
			//Actually Update Goal Pos
			if (inferPathTimeLeft > 0) {
			
				//Clarify
				visibleTarget = true;
			
				//Update Taarget Position
				lastSawTargetX = target.x + targetFollowOffsetX;
				lastSawTargetY = target.y + targetFollowOffsetY;
			
				//Set
				EndGoalX	= lastSawTargetX;
				EndGoalY	= lastSawTargetY + hoverOverDropPlayerY * holdingDroppable;
				
				//Lemming
			
				//Stop Moveing; I'm There.
				if (pathFinder.atEndOfPath) {
					goalSpd	= 0;
				}
			}
		
		
			//Don't Know Where Player Is.
			if (!visibleTarget) {
				if (pathFinder.atEndOfPath) {
					seesTarget = false;
					goalSpd	= 0;
				}
			}
		
		} else {
		
			//At last saw player pos
			if (point_distance(x, y, lastSawTargetX, lastSawTargetY) < 5) {
				
				//Pause; Lost track of player
				goalSpd	= 0;
		
				//Timer until go Home
				if (sinceSeenTarget > room_speed * 5) {
			
					if (point_distance(x, y, orgX, orgY) > 5) {
						//Go Home
						EndGoalX	= orgX;
						EndGoalY	= orgY;
						goalSpd		= maxSpeed / 2;
				
						lastSawTargetX = orgX;
						lastSawTargetY = orgY;
			
						//Reset My Goal Pos Based on Player
						targetFollowOffsetX = irandom_range(10, 30)*choose(1, -1);
						targetFollowOffsetY = hoverOverDropPlayerY;
					}
			
				}
			
			}

		}

	} else {
		
		//
		if (seesTarget) {
			
			goalSpd = maxSpeed;
		
			//When I haven't Decided what my goal is
			if (!goingToPickup || !instance_exists(reloadInstance) && droppableExists) {
				magpie_decide_reload_target();	
				goingToPickup = true;
			}

			//Go To Spot To Pickup
			if (reloadIsABunfet) {
				if (instance_exists(reloadInstance)) {
					EndGoalX = reloadInstance.x;	
					EndGoalY = reloadInstance.y;	
				} else {
					EndGoalX = orgX;	
					EndGoalY = orgY;	
				}
			} else {
				EndGoalX = reloadAreaX;
				EndGoalY = reloadAreaY;
			}
		} else {
			//Not seeing target; go to where they last were
			EndGoalX = lastSawTargetX;
			EndGoalY = lastSawTargetY;
		}

	}
	
	//Create Path To Position
	pathfinder_generate_path(pathFinder, [EndGoalX, EndGoalY]);

	//Error! Go Directly Above player
	if (pathFinder.pathFailed) {
		targetFollowOffsetX = 0;
		targetFollowOffsetY = -5;
	}

	//
	//
	//Reached
	if (distance_to_point(EndGoalX, EndGoalY) < 5) {
		if (!holdingDroppable && seesTarget) {
			
			var tx, ty;
			if (reloadIsABunfet) {
				if (instance_exists(reloadInstance)) {
					tx = reloadInstance.x;
					ty = reloadInstance.y;
				} else {
					//Bunfet not real; it died
					//Impossible location
					tx = -1000;
					ty = -1000;
				}
			} else {
				tx = reloadAreaX;
				ty = reloadAreaY;
			}
			
			//
			//
			if (distance_to_point(tx, ty) < 5) {
				STATE = state.reloading;
				reloadingTicksTimeLeft = reloadingTicksWait;
			}
		} 
	}

	//Quick Drop
	if (abs(x - target.x) < 3 && holdingDroppable) {
		if (visibleTarget) { 
			if (holdingDroppable) {
				if (!place_meeting(x, y+15, Solid)) {
					STATE = state.attack;	
					reloadingTicksTimeLeft = 10; //fast drop
				}
			}
		}
	}

//End Base State
}

//Reload
if (STATE == state.reloading) {

	//Speed
	goalSpd = 0;

	//Timer	
	var isBunfetMulti = 1 + 3*reloadIsABunfet; //4x speed if bunfet pickup
	reloadingTicksTimeLeft -= Game.delta*isBunfetMulti;

	//Timer Finish
	if (instance_exists(reloadInstance)) {
		if (reloadingTicksTimeLeft < 0) {
		
			//Set to Pickup
			holdingDroppable = true;
		
			//Pickup a coin
			if (!reloadIsABunfet) {
			
				//Decide Value
				var inBag = reloadInstance.value;
				var ind = reloadInstance.image_index + 1;
				coinHoldingValue = choose(ceil(inBag / 10), ceil(inBag / 10), ceil(inBag / 9), ceil(inBag / 5), ceil(inBag / 3)) + 1;
				
				//Mutate
				var n = choose(1,1,1,1,1,2); //rare become super value
				coinHoldingValue = power(coinHoldingValue, n);
				coinHoldingValue = min(coinHoldingValue, inBag + 20); //can occasionally give +20 than intended
				
				//Take From Bag
				reloadInstance.value -= coinHoldingValue;
				
				//Decide Sprite
				coinHoldingSprite = platinum_get_coin_sprite(coinHoldingValue);
				
			//Pickup the Bunfet
			} else {
			
				//Save
				bunfetHp = reloadInstance.hp;
				
				//Kill, illusion that I am picking up
				if (instance_exists(reloadInstance)) {
					instance_destroy(reloadInstance);
				}
			
			}
		
			//
			//Exit State
			STATE = state.base;
		
		}
	} else {
		
		//
		//Exit State If my goal is not reachable
		STATE = state.base;	
		goingToPickup = false;
	}

}

//
//
//
if (STATE == state.attack) {
	
	//Timer
	goalSpd = 0;
	reloadingTicksTimeLeft -= Game.delta;

	//Timer Finish
	if (reloadingTicksTimeLeft < 0) {
		
		//Should Drop
		if (holdingDroppable) {
		
			//Set to Pickup
			holdingDroppable = false;
		
			var dropDepth = depth - 1;
		
			//Drop a coin that deals damage
			if (!reloadIsABunfet) {
							
				var dropped = platinum_create_coin(x, y, dropDepth, ceil(coinHoldingValue));
				dropped.shouldDealDamage = true;
				dropped.hp = bunfetHp;
			
		
			//Drop the Bunfet
			} else {
			
				//
				var dropped = instance_create_depth(x, y, dropDepth, oBunfet);
				dropped.shouldDealDamage = true;
				dropped.dropped = true;
			
			}

			//More Time until I reset State
			reloadingTicksTimeLeft = room_speed;

		} else {
				
			//
			//Exit State
			STATE = state.base;
		
		}
		
	}

}
	
//
//blocking -- nothing is pickupable. Just accept fate

if (STATE == state.blocking) {
	goalSpd = 0;	
}
	
//Dead States
if (STATE == state.dead) {
	knockbackVSpeed = lerp(knockbackVSpeed, 0, knockbackSlide/3*time);
	knockbackHSpeed = lerp(knockbackHSpeed, 0, knockbackSlide/3*time);
	vSpeed = round((knockbackVSpeed) * 10) / 10;
	hSpeed = round((knockbackHSpeed) * 10) / 10;	
}
enemy_generic_death_timer();

//Collision
generic_collide_solid();

//Spikes
enemy_hit_spikes();
	
//Visuals Call
event_user(0);

//
//
//Move

//Get The Pointer Position which will lead me to the goal.
var p = pathfinder_get_positon(pathFinder, pathfinderRegenerateRange);

var pointerX, pointerY;
if (STATE == state.attack) {
	//
	pointerX = target.x;
	pointerY = target.y + hoverOverDropPlayerY*2; //no clue why this is needed
	
	//Move to Directly over Player
	goalSpd = 1 * (point_distance(x, y, pointerX, pointerY) > 5);
	
} else {
	pointerX = p[0];
	pointerY = p[1];
}

//Move
	var goalDi = point_direction(x, y, pointerX, pointerY);
	var angleDiff = angle_difference(dirMoving, goalDi);
	dirMoving -= angleDiff * turningSpeed * time;

	var turnPercent = abs(angleDiff / 180);
	var spdTo = (1-turnPercent) * goalSpd * (move);
	spd = lerp(spd, spdTo, 0.3*time);

	//Movement
	var hspd2 = lengthdir_x(spd, dirMoving);
	var vspd2 = lengthdir_y(spd, dirMoving);
	controlHSpeed = lerp(controlHSpeed, hspd2, 0.2*time);
	controlVSpeed = lerp(controlVSpeed, vspd2, 0.2*time);

	//Speed
	knockbackVSpeed = lerp(knockbackVSpeed, 0, knockbackSlide*time);
	knockbackHSpeed = lerp(knockbackHSpeed, 0, knockbackSlide*time);
	
	vSpeed = round((controlVSpeed + knockbackVSpeed) * 10) / 10;
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;

	directionFacing = (controlHSpeed != 0) ? sign(controlHSpeed) : directionFacing;

//Speed
var index_speed_goal = 0.2*(spd / maxSpeed) + 0.1
index_speed = lerp(index_speed, index_speed_goal, 0.1*time);

//Create Damage
if (!instance_exists(myDamage)) {
			
	var w = 18;
	var h = 12;
	myDamage = enemy_damage_create(-1, x-w/2, y-h, w, h, 2, 1);
	myDamage.canDamageEnemies = false; //don't damage Bunfets

}	


