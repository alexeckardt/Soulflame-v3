// @desc
//
//Creates a cuytscene using oCollisionTrigger variaibles.
//Should only be run by oCollisionTrigger or children.
//
function cutscene_create(t_scene_info) {

	//Setup
		keira = instance_nearest(x, y, oKeira);
	
	//Create
		var inst = instance_create_depth(0, 0, 0, Cutscene)
	
		//Retain In Trigger
		cutsceneObject = inst;
		inst.myTrigger = id;
	
	//Update Vars
		inst.scene_info = t_scene_info;
		event_perform_object(inst, ev_other, ev_user0);
	
		inst.cutsceneId = c_persistance_id;
	
	//Player
		keira.inControl = playerHasControlDuringCutscene;

	//Die If Repeatable		
	if (!repeatable) {
		instance_destroy();	
	}
		
}