//
//DESC:
//
//
//
function keira_spikes_action() {

	//
	//
	//
	
	var spikeResetMarker = instance_place(x, y, oSpikeResetMarker);
	if (spikeResetMarker != noone) {
	
		//Set Go To Position
		spikeResetPositionX = spikeResetMarker.x;
		spikeResetPositionY = spikeResetMarker.y;
		spikeResetPositionD = directionFacing;
	
		//Fix Y to Ground
		
	}
	
	
	//
	//
	
	var spikeTouching = instance_place(x, y, oSpikeArea);
	if (spikeTouching != noone) {
		
		//Check Active
		if (spikeTouching.active) {

			//Initial Hit
			if (STATE != state.hurt_spikes) {
				
				if (!touchingSpikes) {
				
					//Take Damage
					if (spikeTouching.dealDamage) {	
						Player.hp--;
						Player.dead = Player.hp <= 0
						add_screen_shake_direction(5, point_direction(0, 0, vSpeed, hSpeed), 0.5);
					}
		
					//
					//Reset Position
					if (spikeTouching.resetPosition) {
			
						doSpikesResetPosition = true;
						STATE = state.hurt_spikes;
			
					} else {
				
						doSpikesResetPosition = false;
						STATE = state.hurt;
				
					}
				}
					
				//No Control
				inControl = false;
			}
			
		}

	}
	
	//Slow Down Always
	if (STATE == state.hurt_spikes) {
		//Slow Down In Spikes
		var spd = 0.34;
		//controlHSpeed = lerp(controlHSpeed, 0, spd*Game.delta);	
		hSpeed = lerp(hSpeed, 0, spd*Game.delta);	
		controlVSpeed =	0;
		vSpeed =		lerp(vSpeed,		0, spd*Game.delta);
	}
	
	//Keep Track
	touchingSpikes = spikeTouching != noone;

	//Resetting Position?
	if (doSpikesResetPosition) {
	
		//If Dead, Let Dead Handle It
		if (!Player.dead) {
			
			//Timer
			spikesTimeLeftBeforeTransition -= Game.delta;
			if (spikesTimeLeftBeforeTransition < 0) {
	
				//Create Transition
				var transition = transition_create(oTransitionFade, room, 
					spikeResetPositionX, spikeResetPositionY, spikeResetPositionD,
					1, c_black, -1, -1);
	
				//See If Actually Created; else redo this on next tick
				if (instance_exists(transition)) {
				
					//Don't switch rooms on hit
					//Load on death
					transition.switchRooms = false;

					//Reset Vars; 
					spikesTimeLeftBeforeTransition = spikesTimeBeforeResetTransition;
					doSpikesResetPosition = false;

				
				}

			}
		
		}
		
	}

}