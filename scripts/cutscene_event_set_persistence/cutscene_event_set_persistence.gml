// @desc
//
//
//
function cutscene_event_set_persistence(key, value) {

	game_persistence_set(key, value);
	cutscene_event_end_action();

}