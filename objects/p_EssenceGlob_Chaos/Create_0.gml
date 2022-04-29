/// @description 

event_inherited();

part_type_alpha1(part_type, 1)
part_type_sprite(part_type, sPartEssenceGlob, false, false, true);
part_type_blend(part_type, false);
part_type_color1(part_type, essence_get_colour_bright(-1));
part_type_size(part_type, 0.8, 1.2, -0.04, 0);

part_type_life(part_type, 30, 50);
part_type_direction(part_type, 0, 180, 0, false)
part_type_gravity(part_type, 0.001, 270);
part_type_speed(part_type, 0, 0.2, 0, 0);
