//
//DESC:
//
//
//
function effect_add(flowerType, mutator){

	var flowerEffect = flower_create_effect_struct(flowerType, mutator);
	
	//Add to effect
	ds_list_add(Player.effectList, flowerEffect);

}