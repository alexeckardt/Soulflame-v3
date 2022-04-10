//
//DESC:
//
//
//
function command_essence() {

	//Fill
	var c = Player.essenceTokensCanHold;
	for (var i = 0; i < c; i++) {
		essence_token_add_percent(choose(-1, 1), 100);
	}

}