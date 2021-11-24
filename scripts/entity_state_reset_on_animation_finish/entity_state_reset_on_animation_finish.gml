//
//DESC:
//
//
//
function entity_state_reset_on_animation_finish(_should) {
	
	if (image_index + index_speed >= image_number - index_speed) {
	
		if (_should) {
			STATE = state.base;
			forceHalfGravity = false;
			inControl = true;
		}
	}
	
}