//
//DESC:
//
//
//
function flower_consume(idInCollectedList, mutator) {

	//Get flower type
	var list = Player.flowersHave;
	var flowerType = list[| idInCollectedList];
	
	//Create the struct
	var flowerEffect = flower_create_effect_struct(flowerType, mutator);
	
	//Add to effect
	ds_list_add(Player.effectList, flowerEffect);
	
	//Finish + Consume
	ds_list_delete(list, idInCollectedList);
	return 0;

}