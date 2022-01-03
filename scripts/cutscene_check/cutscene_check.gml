// @desc
//
//Checks if a Cutscene ID has been completed in the current save file.
//Cutscenes are found in the persistance ds map.
//If they are completed, they will have the form
//		key : 1					(for true)
//
// If a cutscene is not completed, it will not be in the ds_map.
// Therefor, it will return undefined.

function cutscene_check(cutscene_id_to_check) {

	var persistance_map = Game.persistance;
	return !is_undefined(persistance_map[? cutscene_id_to_check]);

}