// @desc
//
//
//
function Dialogue_cutscene_setup_character_objs(orderedCharacterArray, allLeftBeforeIndex) {
	
	//
	//Setup Characters
	for (var i = 0; i < myDialogue.characterCount; i++) {
			
		var char = orderedCharacterArray[i];
		var obj;
			
		//Check Empty, not already in cutscene.
		//Only Update
		if (myDialogue.characters[? char] == undefined) {
				
			//Create Obj
			obj = instance_create_depth(x, y, depth+2, oDialogueCharacter);
			obj.parentDialogue = myDialogue;
				
			//Setup Simple
			obj.characterId = char;	
			obj.sprite_index = character_get_sprite(char, 0);	
			obj.nameStr = character_get_name(char);
			myDialogue.characters[? char] = obj;
				
		} else {
			
			//Grab
			obj = myDialogue.characters[? char];
				
		}
			
		//
		//Set Order To Position
		obj.orderPosition = i;
		obj.stickLeft = (i < allLeftBeforeIndex);
			
	}
}