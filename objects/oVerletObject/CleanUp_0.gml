/// @desc

//Flag all points to be deleted
var s = ds_list_size(points);
for (var i = 0; i < s; i++) {
	
	var point = points[| i];
	
	//Destroy Link
	ds_list_destroy(point.links);
	point.link = -1;

	//Delete Point
	delete points[| i];
}

//destroy list
ds_list_destroy(points);
points = -1;