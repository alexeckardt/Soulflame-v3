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
	effect_add(flowerType, mutator);
	
	//Finish + Consume
	ds_list_delete(list, idInCollectedList);
	return 0;

}