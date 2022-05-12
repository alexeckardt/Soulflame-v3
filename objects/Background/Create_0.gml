/// @description 

//
//
//

#region prelim -- get stuff from the location object

	//if exit, don't crash bcs this hasn't been set
	layerInfo = -1;
	
	//Get Object
	locationObj = instance_nearest(x, y, Location); //should be created per room.
	
	//Make Sure Setup
	if (locationObj == noone) {
		//No Background
		instance_destroy();
		exit;
	}else if (locationObj.backgroundCreationScript == -1) {
		//No Background
		instance_destroy();
		exit;
	}

#endregion

//
//
//

//Poses
globalXoffset = locationObj.backgroundGlobalXoffset;
globalYoffset = locationObj.backgroundGlobalYoffset;

//Create Info
layerInfo = ds_list_create();
script_execute(locationObj.backgroundCreationScript); //Runs the script

//Count
layerCount = ds_list_size(layerInfo);

//Surf
surfToDrawOn = -1;
