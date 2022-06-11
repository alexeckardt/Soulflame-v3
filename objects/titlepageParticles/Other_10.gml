/// @description Create Particles
tick = 0;
quickLoad = true;

smokeTitleSys = part_system_create();
part_system_depth(smokeTitleSys, 0);

smokeTitleEmit = part_emitter_create(smokeTitleSys);
part_emitter_region(smokeTitleSys, smokeTitleEmit,	-100, room_width+100,
												room_height+64, room_height, 
												ps_shape_rectangle, ps_distr_linear);
						
						
smokeTitleType = part_type_create();
part_type_shape(smokeTitleType, pt_shape_cloud);
part_type_size(smokeTitleType, 5, 5, -0.003, 0);
part_type_orientation(smokeTitleType, 0, 360, 0, 0, false);
part_type_direction(smokeTitleType, -45, 215, 0, false);
part_type_speed(smokeTitleType, .01, .03, 0, 0);
part_type_blend(smokeTitleType, false);
part_type_gravity(smokeTitleType, 0.001, 90);
part_type_life(smokeTitleType, room_speed*6.75, room_speed*12.4);
part_type_alpha3(smokeTitleType, 0, .05, .01);


emberTitleType = part_type_create();
part_type_shape(emberTitleType, pt_shape_flare);
part_type_size(emberTitleType, 0.05, 0.1, 0, 0);
part_type_orientation(emberTitleType, 0, 360, 0, 0, false);
part_type_direction(emberTitleType, 0, 359, 0, false);
part_type_speed(emberTitleType, 0.5, 2, 0, 0);
part_type_blend(emberTitleType, true);
part_type_gravity(emberTitleType, 0.006, 45);
part_type_life(emberTitleType, room_speed*3.75, room_speed*7.4);
part_type_alpha3(emberTitleType, 0.5, 1, 0);

