/// @desc State Actions + Visuals


switch (STATE) {
	default:
	
		//Base State; Simple Sprite Switches
		keira_stateaction_default();
	
	break;
	
	//
	//Base
	case state.combat_neutral:
	case state.combat_running:
	case state.combat_htilt:
	case state.combat_up:
	case state.combat_air_up:
	case state.combat_air_neutral:
	case state.combat_air_horizontal:
	
		//Ideally, All of the above will have their own stateaction;
		//where different events playout based on the weapon
		keira_stateaction_attack_regular();
		
	break;
	
	case state.combat_air_down:
		
		//Air down
		keira_stateaction_down_air()
	
	break;
	
	case state.combat_slide:
	
		//Combat Slide
		keira_stateaction_sliding_equivalant();
	
	break;
	
	
	case state.combat_slide_recover:
		
		//Recovery Animation States
		keira_stateaction_slide_recover_equivalant()
		
	break;
	
}	

//Reset
entity_state_reset_on_animation_finish(resetStateOnAnimationFinish);
resetStateOnAnimationFinish = false;
