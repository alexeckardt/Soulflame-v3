// @desc
//
//
//
function essence_get_colour_emission(_essenceVal) {
	
	if (_essenceVal == -1)	return bgr($bb2eff);
	if (_essenceVal == 0)	return bgr($b4babe);
	if (_essenceVal == 1)	return bgr($b58d46);

	return merge_colour(essence_get_colour(0), essence_get_colour(sign(_essenceVal)), abs(_essenceVal))

}