// @desc
//
//
//
function keira_scarf_construct_list(_len) {

	//Create List
	var list = ds_list_create();

	//Fill List
	repeat(_len) ds_list_add(list, new cons_ScarfNode(0,0));

	//Return
	return list;
	
}