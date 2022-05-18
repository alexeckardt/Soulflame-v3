/// @desc Create One Time Things (Persistant Objects)

//Only Create One
if (instance_number(Meta) > 1) exit;


//Generate Persistant Objects
meta_object_create(Game, 0);
meta_object_create(Player, 1);
meta_object_create(Lang, 2);

//Go To Room (Meta is created once);
room = Room1;

