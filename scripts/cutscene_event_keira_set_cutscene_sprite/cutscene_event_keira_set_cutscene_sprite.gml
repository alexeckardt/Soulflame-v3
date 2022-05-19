// @desc
//
//Sets Keiras State variable.
//Skip Event: No Difference
//
function cutscene_event_keira_set_cutscene_sprite(newSpr, indexspd, loopAnim) {

	var keira = instance_nearest(x, y, oKeira);
	
	
	var newState = (loopAnim)	? state.cutscene_loop_animation
								: state.cutscene_pause_on_end_anim;
									
	keira.STATE = newState;
	keira.cutsceneStateSprite = newSpr;
	keira.cutsceneStateIndexSpeed = indexspd;
	keira.image_index = 0;
	keira.index_speed = 0;

	cutscene_event_end_action();

}