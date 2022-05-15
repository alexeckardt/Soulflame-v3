//
//DESC:
//
//
//
function water_draw_godray(edgeBuffer) {

	if (drawGodrays) {

		var l = godrays;
		var s = godrayCount
	
		//Draw
		for (var i = 0; i < s; i++) {
			l[| i].draw(edgeBuffer, godrayXstep);
		}
		
	}

}