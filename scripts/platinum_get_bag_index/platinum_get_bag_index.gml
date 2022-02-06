//
//DESC:
//
//
//
function platinum_get_bag_index(amount){
	var xx = (abs(amount)+1)*3; //cannot be zero
	return min(	floor(logn(5,xx)), sprite_get_number(sPlatinumBag)-1);
}