// @desc
//
//Creates A Singular Page

function menu_page_create(_pageName, _elementArray, allowScroll = true){

	//
	//Create The Page
	var n = lang_get_text(_pageName)
	var ds_list_id = ds_list_create();
	
	//
	//Go Through And Create The Elements
	var l = array_length(_elementArray);
	for (var i = 0; i < l; i++) {
	
		//Create Element
		var processedelementArray = menu_element_create(_elementArray[i]);
		
		//Put In List List
		ds_list_add(ds_list_id, processedelementArray);

	
	}
	
	//Return
	return [n, ds_list_id, 0, allowScroll]

}