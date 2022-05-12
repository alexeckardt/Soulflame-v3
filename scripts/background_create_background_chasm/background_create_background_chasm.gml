// @desc
//
//Create the layers (front to back) of the background
//
function background_create_background_chasm() {

	function chasm_simple_create_layer(list, spr, ind, pamount, vpamount) {
		
		var newLayer = background_create_layer_struct(
						spr, 
						ind, 
						0,
						new BackgroundParalaxAmount(pamount, vpamount, false, false, true, false),
						globalXoffset, 
						globalYoffset
					);
					
		//Draw Obstruction 
		newLayer.drawObstruction = (ind == sprite_get_number(spr)-1)
		
		ds_list_insert(list, 0, newLayer);	
				
	}

	//List Adding
	var list = layerInfo;
	
	//
	//Some Const Info
	var spr = sBackgroundChasm;
	var ind = sprite_get_number(spr)-1;
	
	//Base Bkg
	
	chasm_simple_create_layer(list, spr, ind--, .5, .6);		
	chasm_simple_create_layer(list, spr, ind--, .6, .7);		
	chasm_simple_create_layer(list, spr, ind--, .8, .8);
	chasm_simple_create_layer(list, spr, ind--, .9, .9);
	chasm_simple_create_layer(list, spr, ind--, .99, .99);
}