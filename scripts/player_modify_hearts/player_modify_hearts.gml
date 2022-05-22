//
//DESC:
//
//
//
function player_modify_hearts() {

	var list = heartList;

	var heartTypes = player_recheck_heart_count();
	var regHearts = heartTypes[0];
	var blueHearts = heartTypes[1];
	
	//Add New Basic Heart To The List
	while (regHearts < floor(baseMaxHealth)) {
		var newHeart = new HealthHeart();
		ds_list_insert(list, regHearts, newHeart);
		regHearts++;
	}		
	//Correct Base Hearts ^^
	
	var blueHeartsShouldHave = effect_get_multiplier(flower.lapis_radiance);
	if (blueHeartsShouldHave != blueHearts) {
		while (blueHeartsShouldHave < blueHearts) {
			player_remove_heart_with_type(1);
			blueHearts--;
		}
		
		while (blueHeartsShouldHave > blueHearts) {
			var newHeart = new BlueHealthHeart();
			ds_list_add(list, newHeart);
			blueHearts++;
		}
		
	}
	
	
	//
	//Mutate
	var heartsInList = ds_list_size(list);
	for (var i = 0; i < heartsInList; i++) {
	
		//Get
		var heart = list[| i];
		
		//Set
		heart.heartPosition = i;
		
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
	
	//Save Count
	heartCount = heartsInList;

}