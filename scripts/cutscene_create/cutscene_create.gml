// @desc
//
//Creates a cuytscene using oCollisionTrigger variaibles.
//Should only be run by oCollisionTrigger or children.
//
function cutscene_create(t_scene_info) {

	//Setup
		var keira = instance_nearest(x, y, oKeira);
	
	//Create
		var inst = instance_create_depth(0, 0, 0, Cutscene)
	
		//Retain In Trigger
		cutsceneObject = inst;
		inst.myTrigger = id;
	
	//Update Vars
		with (inst) {
			scene_info = t_scene_info;
			event_user(0);
		}
	
		inst.cutsceneId = c_persistance_id;
		inst.playerHasControlDuringCutscene = playerHasControlDuringCutscene;
		inst.returnControlToPlayer = returnControlToPlayer;
	
	//Player
		keira.inControl = playerHasControlDuringCutscene;
		

	//Die If Repeatable		
	if (!repeatable) {
		instance_destroy();	
	}
		
}