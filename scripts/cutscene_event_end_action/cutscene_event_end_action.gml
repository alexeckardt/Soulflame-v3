// @desc
//
//
//
function cutscene_event_end_action() {

	scene++;
	
	if (scene > array_length(scene_info)-1) {
		
		//Finish Cutscene
		
		//Return
		if (returnControlToPlayer) {
			var keira = instance_nearest(x, y, oKeira);
			keira.inControl = true;
		}
		
		//Destroy
		myDialogue.toDie = true;
		instance_destroy();
		exit;
	}
	
	//Setup Next Scene Access
	event_user(0);
}