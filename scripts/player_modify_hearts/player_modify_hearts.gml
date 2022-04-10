//
//DESC:
//
//
//
function player_modify_hearts() {

	var heartsInList = ds_list_size(heartList);
	
	//Add New Basic Heart To The List
	if (floor(currentMaxHealth) != heartsInList) {
		while (heartsInList < floor(currentMaxHealth)) {
			var newHeart = new HealthHeart(heartsInList);
			ds_list_add(heartList, newHeart);
			heartsInList++;
		}		
	}
	
	//
	//Mutate
	for (var i = 0; i < heartsInList; i++) {
	
		//Get
		var heart = heartList[| i];
		
		//Call Updates
		heart.update();
		
		//
		//Break / Fix The Heart
		if (heart.broken) {
			if (hp > i) {
				heart.mend_heart();
			}
		} else {
			if (hp <= i) {
				heart.break_heart();
			}	
		}
		

	}

}