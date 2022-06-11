/// @description 

var c = c_white
var h = color_get_hue(c);
var s = color_get_saturation(c);
var v = color_get_value(c);
var c1 = make_colour_hsv(h - 10, s + 10, v);
part_type_color_mix(emberTitleType, c, c1);

if (quickLoad) {
	quickLoad = false;
	
	repeat(room_speed*6.75) {
		part_system_update(smokeTitleSys);	
		part_emitter_burst(smokeTitleSys, smokeTitleEmit, smokeTitleType, -16);
			part_emitter_burst(smokeTitleSys, smokeTitleEmit, emberTitleType, -6);
	}
}


part_emitter_burst(smokeTitleSys, smokeTitleEmit, smokeTitleType, -16);
part_emitter_burst(smokeTitleSys, smokeTitleEmit, emberTitleType, -3);