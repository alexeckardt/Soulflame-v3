/// @description 

event_inherited();

part_type_alpha1(part_type, 1)
//part_type_sprite(part_type, -1, false, false, true);
part_type_blend(part_type, false);
part_type_size(part_type, 1, 1, 0, 0);
part_type_orientation(part_type, 0, 360, 2, 0, true);

part_type_life(part_type, 20, 40);
var ai = 50;
part_type_direction(part_type, ai, 180-ai, 0, false)
part_type_gravity(part_type, 0.2, 270);
part_type_speed(part_type, 1.8, 3.5, 0, 0);
