// @desc
//
//
//
function essence_get_colour_bright(_essenceVal) {

	if (_essenceVal == -1)	return bgr($f267ff)
	if (_essenceVal == 0)	return bgr($dcecf8)
	if (_essenceVal == 1)	return bgr($ffe2a8)

	return merge_colour(essence_get_colour_bright(0), essence_get_colour_bright(sign(_essenceVal)), abs(_essenceVal))

}