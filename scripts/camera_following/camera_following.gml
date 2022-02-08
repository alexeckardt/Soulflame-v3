// @desc
//
//
//
function camera_following(){
	
	//Dimention
	var ww = view_width div 2;
	var hh = view_height div 2;
	
	//Time
	var time = Game.delta;
	
	//Speed
	var cameraFollowSpeed = 4;
	
	//Keira
	var k = oKeira.id;

	//Check for Combat Camera
	updateCombatCameraTicks += time;
	if (updateCombatCameraTicks > updateCombatCameraEveryNTicks) {
		updateCombatCameraTicks = 0;
	
		//Reset
		combatCamera = false;
		ds_list_clear(agressedEnemies);
		
		//Check For Enemies
		if (instance_exists(Enemy)) {
			//var loopChecks = instance_number(pEnemy);
		
			//Loop Through all enemies to add them to the list that is agro
			var list = agressedEnemies;
			var camFollow = follow;
			with (Enemy) {
				
				inCombatCamera = false;
				
				var dd = point_distance(x, y, camFollow.x, camFollow.y);
				if (dd < sightRange) {
					if (cameraWeight > 0) {
						ds_list_add(list, id);	
						inCombatCamera = true;
					}
				}
				
				
			}
		
			//Update
			combatCamera = ds_list_size(list) > 0;	
		}	
	}
	
	//
	//Reset On Final Enemy Death
	if (combatCamera) && (!instance_exists(Enemy) || instance_exists(PauseMenu)) {
		combatCamera = false;	
	}

	//
	//
	//

	//Follow
	if (instance_exists(follow) && follow != id) {
	
		//Goal XY
		var cX = 0;
		var cY = 0;
		
		//Goals
		var followX = follow.x + followOffsetX;
		var followY = follow.y + followOffsetY;
	
		//NORMAL FOLLOWING
		if (!combatCamera) {
	
			//Position
			cX = clamp(followX, ww+horizontalBuffer, room_width-horizontalBuffer-ww);
			cY = clamp(followY, hh, room_height-hh);

			goalCx = cX;
			goalCy = cY;
			

		//COMBAT CAMERA
		} else {
			
			//
	
			//COMBAT CAMERA
			var playerCamWeight = 1;
			var avgX = followX*playerCamWeight;
			var avgY = followY*playerCamWeight;
	
			var enemiesWeightAdded = 0;
	
	
			//Get Agressed Enemy Positions
			var listLen = ds_list_size(agressedEnemies);
			for (var i = 0; i < listLen; i++) {
				
				//Enemy
				var thisEnemy = agressedEnemies[| i];
		
				//Get Enemy Position
				if (!instance_exists(thisEnemy)) continue;
				
				//Get Position
				var enX = thisEnemy.x;
				var enY = thisEnemy.y;

				//Distances
				var dd = point_distance(enX, enY, followX, followY);
				var minPullDistance = thisEnemy.sightRange;
				var maxPullDistance = thisEnemy.sightRange div 4;
				
				//Percent Pull
				var diffFromMaxPull = max(0, dd - maxPullDistance);
				var noPullDistance = abs(minPullDistance-maxPullDistance);
				var distRatio = (diffFromMaxPull) / (noPullDistance);
				var percentPull = 1 - clamp( sqrt(distRatio), 0, 1);
				percentPull *= percentPull; //sqr

				//Get the amount to add to the total pool
				var addToX = lerp(followX, enX, percentPull);
				var addToY = lerp(followY, enY, percentPull);
			
				//Add to the pool
				var m = thisEnemy.cameraWeight;
				avgX += addToX*m;
				avgY += addToY*m;
				enemiesWeightAdded += m;
				
			}
		
			//Average the Position based on the rolls
			avgX /= (enemiesWeightAdded + playerCamWeight);
			avgY /= (enemiesWeightAdded + playerCamWeight);
	
	
			//SAVE
			cX = clamp(avgX, ww+horizontalBuffer, room_width-horizontalBuffer-ww);
			cY = clamp(avgY, hh, room_height-hh);
			//	
			
			goalCx = lerp(goalCx, cX, 0.5*time);
			goalCy = lerp(goalCy, cY, 0.5*time);
			
		}
		
		//
		//
		//Move
		if (time != 0) {
			viewX = lerp(viewX, goalCx, time/cameraFollowSpeed);
			viewY = lerp(viewY, goalCy, time/cameraFollowSpeed);
		}
		
	
	} else {
	
		//Move To Locked position
		var bS = 0.1;
		var lerpP = bS + (1-bS)*(!panCameraToLock)
		viewX = lerp(viewX, lockX, lerpP*time);
		viewY = lerp(viewY, lockY, lerpP*time);

	}
	
	
	/*

	if (instance_exists(follow)) {
		
		if (follow != id) {
		
			var cX = clamp(follow.x + followOffsetX, ww+horizontalBuffer, room_width-horizontalBuffer-ww);
			var cY = clamp(follow.y + followOffsetY, hh, room_height-hh);


			viewX = lerp(viewX, cX, 0.25*time);
			viewY = lerp(viewY, cY, 0.25*time);
		
		} else {

			var bS = 0.1;
			var lerpP = bS + (1-bS)*(!panCameraToLock)
			viewX = lerp(viewX, lockX, lerpP*time);
			viewY = lerp(viewY, lockY, lerpP*time);
			
		}
	}
*/
}