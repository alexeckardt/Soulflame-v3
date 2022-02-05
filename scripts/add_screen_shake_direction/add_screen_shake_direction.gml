//
//DESC:
//
//
//
function add_screen_shake_direction(dirLength, dirPreferance, variance){

	//Update Direction If we need to
	if (dirLength != 0) {
		
		//Get Exsiting Vector
		var cameraLen = Camera.screenShakeLen;
		var cameraDir = Camera.screenShakeDir;
		
		var magAX = lengthdir_x(cameraLen, cameraDir);
		var magAY = lengthdir_y(cameraLen, cameraDir);
		var magBX = lengthdir_x(dirLength, dirPreferance);
		var magBY = lengthdir_y(dirLength, dirPreferance);
	
		//Combine
		var totX = magAX + magBX;
		var totY = magAY + magBY;

		//Collapse as New
		Camera.screenShakeDir= point_direction(0, 0, totX, totY);
		Camera.screenShakeLen= point_distance(0, 0, totX, totY);
		
	}
	
	//
	//Shake Amount
	Camera.screenShakeMulti = max(variance, Camera.screenShakeMulti);

}