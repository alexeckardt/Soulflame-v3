// @desc
//
//
//
function menu_close_menu() {
	if (Game.paused) {
		Game.pauseMenuObj.close = true;
		Game.pauseMenuObj = noone;	
		
		Game.someUIopen = false;
		Game.paused = false;
	}
}