/// @desc

//Flag all points to be deleted
var s = ds_list_size();
for (var i = 0; i < s; i++) {
	delete points[| i];
}

//destroy list
ds_list_destroy(points);