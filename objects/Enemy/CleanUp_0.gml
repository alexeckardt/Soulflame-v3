///@Desc Destroy HB

//Kill My Hitboxes
if (ds_exists(hitboxes, ds_type_list)) {
	
	var count = ds_list_size(hitboxes);
	for (var i = 0; i < count; i++) {
		var hitboxId = hitboxes[| i];
		instance_destroy(hitboxId);	
	}

	//Destroy Hitbox List
	ds_list_destroy(hitboxes);
	
}
