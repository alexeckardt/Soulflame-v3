/// @description 
image_index = irandom(image_number);
image_speed = 0;

depth = oKeira.depth + 5

partTypeKey = "potFragHumans";
potPartTypeSpr = sHumanPotFragments;

checkedAlreadyDestroyed = false;

//name
var roomname = string(room_get_name(room));
var potcreatedcount = 0;

//Check how many names have been created
with (oPot) {
	if (variable_instance_exists(id, "storename")) {
		potcreatedcount++;
	}
}

//Create
storename = roomname + ".pot." + string(potcreatedcount);

//Change Per Type
minPlat = 1;
maxPlat = 3;