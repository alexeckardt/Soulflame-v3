//
//DESC:
//
//
//
function platinum_get_coin_sprite(val) {

	if (val < 5) {
		return sPlatinumCoin;
	}
	
	if (val < 25) {
		return sPlatinumChunk;
	} 
	
	return sPlatinumBar;
	
}