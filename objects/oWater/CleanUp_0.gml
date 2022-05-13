/// @desc

if (ds_exists(points, ds_type_list)) {

	//Flag all points to be deleted
	var s = ds_list_size(points);
	for (var i = 0; i < s; i++) {
		//Del
		delete points[| i];
	}

	//destroy list
	ds_list_destroy(points);
	points = -1;

}

//Links
if (ds_exists(links, ds_type_list)) {
	
	var s = ds_list_size(links);
	for (var i = 0; i < s; i++) {	
		//Del
		delete links[| i];
	}

	ds_list_destroy(links);
	links = -1;

}

delete pointmassLeft;
delete pointmassRight;

cleanup_surface(waterSurf);
