 /// @description 
image_index = irandom(image_number);
image_speed = 0;

depth = oKeira.depth + 5

partTypeKey = "potFragHumans";
potPartTypeSpr = sHumanPotFragments;

checkedAlreadyDestroyed = false;

//name
storename = game_persistence_create_name_room_specific("pot");

//Change Per Type
minPlat = 1;
maxPlat = 3;