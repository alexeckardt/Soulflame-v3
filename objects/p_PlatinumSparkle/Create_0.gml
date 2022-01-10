/// @description 

event_inherited();

var platinumCol = Player.platinumCol
part_type_color1(part_type, platinumCol);
part_type_sprite(part_type, sPartCoinSparkle, true, true, false);
part_type_blend(part_type, false);
part_type_alpha1(part_type, 1);
					
part_type_speed(part_type, 0, 0, 0, 0);
part_type_size(part_type, 1, 1, 0, 0);
part_type_life(part_type, 10, 30);

sparklesToCreate = 0;
timer = 0;