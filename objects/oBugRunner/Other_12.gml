/// @desc

justDied = false;

enemy_global_death_events();

//Create Peices
enemy_piece_create(sBunfetDead, 0, -1,	directionFacing,	true,	1, 0.9); //front wing

instance_destroy();
exit;
	