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
	updateCombatCameraTicks++;
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
	if (combatCamera) && (!instance_exists(Enemy)) {
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


		//COMBAT CAMERA
		} else {
			
			//
	
			//COMBAT CAMERA
			var avgX = 0;
			var avgY = 0;
	
			var rolls = 0;
	
			//Get Agressed Enemy Positions
			var listLen = ds_list_size(agressedEnemies);
			for (var i = 0; i < listLen; i++) {
				
				//Enemy
				var thisEnemy = agressedEnemies[| i];
		
				//Get Enemy Position
				if (!instance_exists(thisEnemy)) continue;
				var enX = thisEnemy.x;
				var enY = thisEnemy.y;
				var enDetect = thisEnemy.sightRange;
		
				//Distances
				var dd = point_distance(enX, enY, followX, followY);
				var ignoreRange = enDetect-30;
			
				//Choose The Intensity based on dist (smooths in and out)
				var p = clamp((ignoreRange - dd) / (ignoreRange*1.5), 0, 1); // if outside range, ignore totally
				var howMuchToIgnore = lerp(1, 1-clamp(thisEnemy.lerpCameraWeight, 0, 1), p) //if p is 1, then ignore my location
			
				//Get the amount to add to the total pool
				var addToX = lerp(enX, followX, howMuchToIgnore);
				var addToY = lerp(enY, followY, howMuchToIgnore);
			
				//Add to the pool
				var m = thisEnemy.cameraWeight;
				avgX += addToX*m;
				avgY += addToY*m;
				rolls += m;
				
			}
		
			//Add Following's Pos but with extra weight to it
			var weight = 1;
			avgX += (followX)*weight;
			avgY += (followY)*weight;
		
			//Average the Position based on the rolls
			avgX = avgX / (rolls+weight);
			avgY = avgY / (rolls+weight);
	
	
			//SAVE
			cX = clamp(avgX, ww+horizontalBuffer, room_width-horizontalBuffer-ww);
			cY = clamp(avgY, hh, room_height-hh);
			//	
		}
		
		//
		//
		//Move
		viewX = lerp(viewX, cX, time/cameraFollowSpeed);
		viewY = lerp(viewY, cY, time/cameraFollowSpeed);
		
	
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