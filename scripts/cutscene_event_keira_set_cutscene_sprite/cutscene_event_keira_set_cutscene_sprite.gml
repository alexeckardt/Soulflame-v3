// @desc
//
//Sets Keiras State variable.
//Skip Event: No Difference
//
function cutscene_event_keira_set_cutscene_sprite(newSpr, indexspd, pauseOnAnimEnd) {

	var keira = instance_nearest(x, y, oKeira);
	
	
	var newState = (pauseOnAnimEnd) ? state.cutscene_pause_on_end_anim
									: state.cutscene_loop_animation;
	keira.STATE = newState;
	keira.cutsceneStateSprite = newSpr;
	keira.cutsceneStateIndexSpeed = indexspd;
	
	
	cutscene_event_end_action();

}