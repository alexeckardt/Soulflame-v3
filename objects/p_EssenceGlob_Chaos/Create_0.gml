/// @description 

event_inherited();

var c = essence_get_colour_bright(-1);

part_type_alpha1(part_type, 1)
part_type_sprite(part_type, sPartEssenceGlob, false, false, true);
part_type_blend(part_type, false);
part_type_color_mix(part_type, c, merge_colour(c, c_black, 0.5));
part_type_size(part_type, 0.5, 0.8, -0.02, 0);

part_type_life(part_type, 30, 50);
part_type_direction(part_type, 0, 180, 0, false)
part_type_gravity(part_type, 0.001, 270);
part_type_speed(part_type, 0, 0.1, 0, 0);
