///@Desc Destroy HB

//Kill My Hitboxes
var count = ds_list_size(hitboxes);
for (var i = 0; i < count; i++) {
	var hitboxId = hitboxes[| i];
	instance_destroy(hitboxId);	
}

//Destroy Hitbox List
ds_list_destroy(hitboxes);