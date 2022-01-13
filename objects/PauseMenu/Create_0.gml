/// @description 

//
close = false;

//Pages
page = 0;

//Selecting
elementHoverID	= -1;
prevElementHoverID	= -1;
ticksOnSameElement = 0;

//Sizes
displayWidth =	Camera.view_width * Game.uiScale;
displayHeight = Camera.view_height * Game.uiScale;

//
//Positions
	menuElementFont = fontKeira;
	
	startDrawElementAtY = 96;
	elementHeight		= 12;
	elementSpacing		= 10;

	middleLine			= displayWidth / 2;
	middleBuffer		= 16;

	//Visual
	elementYShakeMulti  = 0;
	elementYShakeTime	= 0;
	
//Surface
menuSurface = -1;