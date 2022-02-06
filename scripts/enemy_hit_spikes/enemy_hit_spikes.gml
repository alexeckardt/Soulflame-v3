//
//DESC:
//
//
//
function enemy_hit_spikes(){

	//Check Collision
	var spikeTouching = instance_place(x, y, oSpikeArea);
	if (spikeTouching != noone) {
		
		//Also Check For Some Hitbox Inside
		
		
			//Check Active
			if (spikeTouching.active && spikeTouching.killEnemies) {
		
				//Dead
				if (!dead) {
				
					//Set
					hp = -2;
				
					//Kill
					dead = true;
					justDied = true;
				
					//Go Back
					deathHeadingDirection = point_direction(hSpeed, vSpeed, 0, 0);
				
					//Auto Switch (Stagger)
					if (autoSwitchToDeadState) {
						STATE = state.dead;	
					}
				}	
		
		}
		
	}

}