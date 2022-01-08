/// @description 

justDied = false;

enemy_global_death_events();

//Create Peices
enemy_piece_create(sMagpiePeice0, 5, -6,	directionFacing,	false,	0.5, 0.4); //front wing
enemy_piece_create(sMagpiePeice3, -4, -6,	directionFacing,	false,	0.5, 0.3); //backwing

enemy_piece_create(sMagpiePeice1, 2, -6,	directionFacing,	true,	1, 0.4); //head
enemy_piece_create(sMagpiePeice2, 0, 0,		directionFacing,	true,	2,	 0.1); //body

instance_destroy();
exit;
	