///@description returned = script_execute_alt
///@arg ind
///@arg [arg1,arg2,...]
function script_execute_alt(argument0, argument1) {

	var s = argument0;
	var a = argument1;
	var len = array_length(argument1);

	var returned = -1;

	switch(len){
		case 0:  returned = script_execute(s); break;
		case 1:  returned = script_execute(s, a[0]); break;
		case 2:  returned = script_execute(s, a[0], a[1]); break;
		case 3:  returned = script_execute(s, a[0], a[1], a[2]); break;
		case 4:  returned = script_execute(s, a[0], a[1], a[2], a[3]); break;
		case 5:  returned = script_execute(s, a[0], a[1], a[2], a[3], a[4]); break;
		case 6:  returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5]); break;
		case 7:  returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6]); break;
		case 8:  returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]); break;
		case 9:  returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8]); break;
		case 10: returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9]); break;
		case 11: returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10]); break;
		case 12: returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11]); break;
		case 13: returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12]); break;
		case 14: returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13]); break;
		case 15: returned = script_execute(s, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14]); break;
	}

	return returned;

}
