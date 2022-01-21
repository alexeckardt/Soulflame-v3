//
//DESC:
//
//Destroys all damages created by a certain Instance ID.
//

function damage_via_owner_destroy(_instanceOfCreator){
	
	var instanceHasBeenDestroyed = false;
	
	with (oDamage) {
		if (creator == _instanceOfCreator) {
			instanceHasBeenDestroyed = true;
			instance_destroy();	
		}
	}
	
	return instanceHasBeenDestroyed;
}