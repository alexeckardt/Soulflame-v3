/// @desc State Actions + Visuals

var time = Game.delta

if (lastWeaponUsing != Player.weaponUsing) {
	keira_update_movement_sprites();	
}


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
	
	case state.sitdown:
	case state.sit:
	case state.situp:
	
		//Sit
		keira_stateaction_sit_states();
	
		break;
		
	case state.hurt:
	case state.hurt_spikes:
	
		//Sit
		keira_stateaction_hurt_states();
	
		break;
	
}	

//Botch
if (haveSlideDamage) {
	if (STATE != state.combat_slide) {
		if (instance_exists(damageObj)) {
			damageObj.allowLifeDecay = true;
			damageObj.life = -1;
			haveSlideDamage = false;	
		}
	}
}

//
//Hurt State
if (STATE != state.hurt) {
	//Invulnerability Time Post Damage
	invulnerableTicks -= time;	
}

//Reset
entity_state_reset_on_animation_finish(resetStateOnAnimationFinish);
resetStateOnAnimationFinish = false;

var deltaIndex = index_speed*time/2;
if (image_index + deltaIndex > image_number - deltaIndex) {
	image_index = 0;	
} else {
	image_index += deltaIndex;}

//
//time/2 because the sprites internal image_speed is 30
//while the goal game speed is 60 (thus half speed)
//
	
