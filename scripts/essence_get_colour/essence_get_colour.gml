// @desc
//
//
//
function essence_get_colour(_essenceVal) {

	if (_essenceVal == -1)	return bgr($560a96)
	if (_essenceVal == 0)	return bgr($6e767c)
	if (_essenceVal == 1)	return bgr($985c16)

	return merge_colour(essence_get_colour(0), essence_get_colour(sign(_essenceVal)), abs(_essenceVal))

}