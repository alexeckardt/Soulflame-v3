/// @description 

//Don't redo cutscene
if (interactable) && (game_persistence_check(persistenceId) != undefined) {
	interactable = false;
	glowbyProx = true;
}


if (!instance_exists(Cutscene)) {

	if (place_meeting(x, y, oKeira)) {
		
		if (oKeira.inControl || !playerMustBeInControl) {
		
			if (interactable) {
		
				//Wait for Input From Player
				//(This is done so only one trigger is activated)
				if (activate) {
				
					cutscene_create(first_activate_scene);
					activate = false;
					interactable = false;

				}
			
			}

		}
		
	}
	
}

//
//Glow
if (glow) {
	glowAlphaTo = lerp(glowAlphaTo, 1, 0.05*Game.delta);	
} else {
	glowAlphaTo = 0;	
	if (glowbyProx) {
		var z = (glowProxMaxGlowRange + glowProxActiveRange 
					- point_distance(x, y, oKeira.x, oKeira.y)) / glowProxActiveRange;
		glowAlphaTo = clamp(z, 0, 1);	
	}
}
glowAlpha = lerp(glowAlpha, glowAlphaTo, 0.3*Game.delta);

var cto = merge_colour(c_black, activeCol, glowAlpha);
var sizeto =  lerp(lightminSize, lightmaxSize, glowAlpha);
healStone_edit_light(cto,sizeto);

//
//Lights
if (glowAlphaTo > 0) {
	
	if (irandom(100) < 5*Game.delta) {
	
		//Point Light Floor
		var sec = room_speed;
		var l = point_light_create_ext(x-16, x+16, y, y, 0.1, 0.4, 90, 5, 3*sec, 10*sec, activeCol, c_black, 0, 0);
		l.size = 8;
		
	}
}
