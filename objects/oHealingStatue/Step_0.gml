/// @description 

//Don't redo cutscene
if (interactable) && (game_persistence_check(persistenceId) == undefined) {
	interactable = false;
	glowbyProx = true;
}


if (!instance_exists(Cutscene)) {

	if (place_meeting(x, y, oKeira)) {
		
		if (oKeira.inControl || !playerMustBeInControl) {
		
			//Wait for Input From Player
			//(This is done so only one trigger is activated)
			if (activate) {
				
				cutscene_create(first_activate_scene);
				activate = false;

			}

		}
		
	}
	
}

//Glow
if (glow) {
	glowAlphaTo = 1;	
} else {
	glowAlphaTo = 0;	
	if (glowbyProx) {
		var z = (glowProxMaxGlowRange + glowProxActiveRange 
					- point_distance(x, y, oKeira.x, oKeira.y)) / glowProxActiveRange;
		glowAlphaTo = clamp(z, 0, 1);	
	}
}
glowAlpha = lerp(glowAlpha, glowAlphaTo, 0.3*Game.delta);
