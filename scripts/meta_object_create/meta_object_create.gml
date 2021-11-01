//
//DESC:
//
//
//
function meta_object_create(objectId, depthh) {

	//Display
	show_debug_message("Attempting to create meta obj " + object_get_name(objectId) + "...");

	if (!instance_exists(objectId)) {
		instance_create_depth(0, 0, depthh, objectId);	
		show_debug_message("\tCreated!");
	} else {
		show_debug_message("\tFailed! Already Exists");	
	}

}