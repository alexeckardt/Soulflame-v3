/// @desc Death

justDied = false;

enemy_global_death_events();

//Create Peices
enemy_piece_create(headSprite, 0, 0,	directionFacing,	true,	2, 0.4); //head
for (var i = 1; i < bodyNodeCount+1; i++) {
		
		var node = nodes[| i];
		var xx = node.xx - x
		var yy = node.yy - y;
		
		enemy_piece_create(bodySprite, xx, yy,	1,	false, 1, 0.1); //head
		
}



instance_destroy();
exit;
	
