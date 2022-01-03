// @desc
//
//Moves an Entity Obj to a certian X position, whether it be realative or absolute.
//Uses the entity's own speed attributes.
//
//SkipCase: Warp Object to Position
//
function cutscene_event_move_entity_to_position(objId, xpos, isRealtive, allowedRange) {

	//Get The Real Xposition to Move To
	if (moveToX == undefined) {
		moveToX = (isRealtive) ? objId.x + xpos : xpos;}

	//Skip
	if (skipCutscene) {
		objId.x = moveToX;}


	//Player Case
	var isPlayer = false;
	if (objId.object_index == oKeira) {
		
		//For End
		isPlayer = true;
		
		//Take Away Control
		objId.inControl = false;
		
		//Set MX (If Skipped, this will be zero)
		objId.noControlMx = sign(floor(moveToX - objId.x))
		
	//NPC Case
	} else {	
		
	}
	
	//
	//
	//End Case
	if (abs(objId.x - moveToX) < allowedRange) {
		
		//Reset
		moveToX = undefined;
		
		//Stop Player Moveing
		if (isPlayer) {
			objId.noControlMx = 0;
		}
		
		//End
		cutscene_event_end_action();
	}
	
}