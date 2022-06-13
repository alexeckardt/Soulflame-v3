// @desc
//
//Create the layers (front to back) of the background
//
function background_create_background_surface() {


	//
	//
	function surface_simple_create_layer(list, spr, ind, pamount, vpamount, yoff, windspeed = 0) {
		
		var newLayer = background_create_layer_struct(
						spr, 
						ind, 
						0,
						new BackgroundParalaxAmount(pamount, vpamount, windspeed, 0, true, false),
						globalXoffset, 
						globalYoffset + yoff
					);
					
		//Draw Obstruction 
		newLayer.drawObstruction = (ind == sprite_get_number(spr)-1)
		
		ds_list_insert(list, 0, newLayer);	
		return 
	}
	
	

	//List Adding
	var list = layerInfo;


	//
	//Valley
	var spr = sValleyTopBackground;
	var ind = sprite_get_number(spr)-1;
	
	//Base Bkg
	surface_simple_create_layer(list, spr, ind--, .7, .6, 0);		
	surface_simple_create_layer(list, spr, ind--, .8, .7, 0);		
	surface_simple_create_layer(list, spr, ind--, .9, .8, 0);
	
	
	
	//
	//Mountain and Sky
	var spr = sMountainDistanceBackground;
	var ind = sprite_get_number(spr)-1;
	var off = -120;
	
	//mountain
	surface_simple_create_layer(list, spr, ind--, 1, 1, off, 0);
	
	//sky
	surface_simple_create_layer(list, spr, ind--, 1, 1, off, -1);		
	surface_simple_create_layer(list, spr, ind--, 1, 1, off, -0.2);
	surface_simple_create_layer(list, spr, ind--, .99, .99, off, -0.1);	
}