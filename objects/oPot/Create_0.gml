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
value = irandom_range(0, 2);
valueLast = -1;
valueChanged = false; //Used for any children
