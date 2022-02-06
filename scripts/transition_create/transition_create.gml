// @desc
//
//
//
function transition_create(transitionObj, nextRoom, nextPX, nextPY, nextPD, 
									alphaDirection, otherinfo0, otherinfo1, otherinfo2,
									force = false) {

	if (!instance_exists(oRoomTransition) || force) {
		
		var obj			= instance_create_depth(x, y, 10, transitionObj);
		obj.nextRoom	= nextRoom;		
		obj.nextPX		= nextPX;
		obj.nextPY		= nextPY;
		obj.nextPD		= nextPD;
		
		
		obj.alphaDirection	= alphaDirection;
		obj.alpha			= (alphaDirection == -1) * 1.5;
	
	
		obj.otherinfo0 = otherinfo0;
		obj.otherinfo1 = otherinfo1;
		obj.otherinfo2 = otherinfo2;
		
		return obj

	}
	
	return noone
}