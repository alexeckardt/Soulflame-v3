// @desc
//
//
//
function in_array(_ar, value) {

	var s = array_length(_ar);
	for (var i = 0; i <s;i++){
		if(_ar[i]==value){
			return true	
		}
	}

	return false;
}