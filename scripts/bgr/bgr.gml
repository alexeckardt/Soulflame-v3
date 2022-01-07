// @desc
//
//Takes a hex in RGB and returns it's RGB value.
//This is done because hex values in GML are formatted as BGR; so we have to swap the B and R values
//To get the proper colour.
//
function bgr(rgbHex) {
	return make_color_rgb(colour_get_blue(rgbHex), colour_get_green(rgbHex), colour_get_red(rgbHex));
}