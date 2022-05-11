// @desc
//
//
//
function cutscene_event_end_action() {

	scene++;
	
	var scene_count = array_length(scene_info);
	if (scene > scene_count-1) {
		
		//Finish Cutscene
		
		//Return
		if (returnControlToPlayer) {
			var keira = instance_nearest(x, y, oKeira);
			keira.inControl = true;
		}
		
		//Destroy
		myDialogue.toDie = true;
		dead = true;
		instance_destroy();
		exit;
	}
	
	//Setup Next Scene Access
	event_user(0);
}