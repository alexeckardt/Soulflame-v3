/// @desc State Actions + Visuals

var time = Game.delta

switch (STATE) {
	default:
	
		//Base State; Simple Sprite Switches
		keira_stateaction_default();
	
	break;
	
	//
	//Base
	case state.combat_neutral:
	case state.combat_htilt:
	case state.combat_up:
	case state.combat_air_up:
	case state.combat_air_neutral:
	case state.combat_air_horizontal:
	case state.combat_down:
	
		//Ideally, All of the above will have their own stateaction;
		//where different events playout based on the weapon
		keira_stateaction_attack_regular();
		
	break;
	
	//Running Attack
	case state.combat_running:	keira_stateaction_attack_running();break;
	
	//Air down
	case state.combat_air_down:	keira_stateaction_down_air();break;
	
	//Combat Slide
	case state.combat_slide:	keira_stateaction_sliding_equivalant();break;
	
	
	case state.combat_slide_recover:
		
		//Recovery Animation States
		keira_stateaction_slide_recover_equivalant();
		
	break;
	
}	

//Reset
entity_state_reset_on_animation_finish(resetStateOnAnimationFinish);
resetStateOnAnimationFinish = false;

image_index += index_speed*time/2;
//
//time/2 because the sprites internal image_speed is 30
//while the goal game speed is 60 (thus half speed)
//
	
