// @desc
//
//
//
function dialouge_cutscene_setup_character_objs(orderedCharacterArray, allLeftBeforeIndex) {
	
	//
	//Setup Characters
	for (var i = 0; i < myDialouge.characterCount; i++) {
			
		var char = orderedCharacterArray[i];
		var obj;
			
		//Check Empty, not already in cutscene.
		//Only Update
		if (myDialouge.characters[? char] == undefined) {
				
			//Create Obj
			obj = instance_create_depth(x, y, depth+2, oDialougeCharacter);
			obj.parentDialouge = myDialouge;
				
			//Setup Simple
			obj.characterId = char;	
			obj.sprite_index = character_get_sprite(char, 0);	
			obj.nameStr = character_get_name(char);
			myDialouge.characters[? char] = obj;
				
		} else {
			
			//Grab
			obj = myDialouge.characters[? char];
				
		}
			
		//
		//Set Order To Position
		obj.orderPosition = i;
		obj.stickLeft = (i < allLeftBeforeIndex);
			
	}
}