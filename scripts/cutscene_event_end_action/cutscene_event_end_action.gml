// @desc
//
//
//
function cutscene_event_end_action() {

	scene++;
	
	if (scene > array_length(scene_info)-1) {
		
		//Finish Cutscene
		
		
		//Return
		var keira = instance_nearest(x, y, oKeira);
		keira.inControl = true;
		
		//Destroy
		instance_destroy();
		exit;
	}
	
	//Setup Next Scene Access
	event_user(0);
}