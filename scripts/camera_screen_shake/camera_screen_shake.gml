//
//DESC:
//
//Called by Camera to update the view position of the Camera.
//
function camera_screen_shake() {
	
		var time = Game.delta;
	
	//Screen Shake Variance
	if (screenShakeMulti > 0.01) {
		randomize();
		screenXShake = random_range(-1, 1) * screenShakeMulti;
		screenYShake = random_range(1, 1) * screenShakeMulti;
		screenShakeMulti = lerp(screenShakeMulti, 0, 0.03*time);
	}

	//Move
	viewX += screenXShake + lengthdir_x(screenShakeLen, screenShakeDir);
	viewY += screenYShake + lengthdir_y(screenShakeLen, screenShakeDir);

	//Slowly Pull Back In
	screenShakeLen = lerp(screenShakeLen, 0, 0.03*time);

	
}