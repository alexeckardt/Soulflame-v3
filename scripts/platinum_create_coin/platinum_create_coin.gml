//
//DESC:
//
//
//
function platinum_create_coin(xx, yy, depthh, val){

	//Create
	var instt;

	//Create based on value
	if (val < 5) {
		instt = instance_create_depth(xx, yy, depthh, oPlatinumCoin);
	} else 
	if (val < 25) {
		instt = instance_create_depth(xx, yy, depthh, oPlatinumChunk);
	} else
	{
		instt = instance_create_depth(xx, yy, depthh, oPlatinumBar);
	}

	//Set Value
	instt.value = val;

	//Return
	return instt;

}