// @desc
//
//Create the layers (front to back) of the background
//
function background_create_background_chasm() {

	function chasm_simple_create_layer(list, spr, ind, pamount) {
		ds_list_insert(list, 0 ,
				background_create_layer_struct(
						spr, 
						ind--, 
						0,
						new BackgroundParalaxAmount(.5, .1, false, false, true, false),
						globalXoffset, 
						globalYoffset
					)
				);	
	}

	//List Adding
	var list = layerInfo;
	
	//
	//Some Const Info
	var spr = sBackgroundChasm;
	var ind = sprite_get_number(spr)-1;
	
	//
	//Do the Backgrounds!
	//
	
	backColTop = bgr($0c0906);
	backColMid = 0;
	backColBot = bgr($0c0906);
	
	//Base Bkg
	
	chasm_simple_create_layer(list, spr, ind--, .5);		
	chasm_simple_create_layer(list, spr, ind--, .6);		
	chasm_simple_create_layer(list, spr, ind--, .8);
	chasm_simple_create_layer(list, spr, ind--, .9);
	chasm_simple_create_layer(list, spr, ind--, .99);
}