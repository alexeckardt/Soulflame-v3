/// @desc

//
//Pop Off Lights
var c = bgr($00ffff);
repeat(20) {
	point_light_create_ext(bbox_left, bbox_right, bbox_top, bbox_bottom, 0, 0.3, 90, 10, 
		room_speed, room_speed*1.4, c, 0, 0.01, 90);
}


//
//Store In Memory
game_persistence_set(map_id, true);


//
//Act as Save
save_game(true, false);

