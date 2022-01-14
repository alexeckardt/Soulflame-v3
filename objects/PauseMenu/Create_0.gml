/// @description 

//
close = false;

//Pages
menu_pages_create();
page = master_page;

//Selecting
elementHoverID	= 0;
prevElementHoverID	= -1;
ticksOnSameElement = 0;

//Sizes
displayWidth =	Camera.view_width * Game.uiScale;
displayHeight = Camera.view_height * Game.uiScale;

//
//Positions
	menuElementFont = fontKeira;
	draw_set_font(menuElementFont);
	
	startDrawElementAtY = 96;
	elementHeight		= string_height("|");
	elementSpacing		= 5;

	middleLine			= displayWidth / 2;
	middleBuffer		= 16;

	//Visual
	elementYShakeMulti  = 0;
	elementYShakeTime	= 0;
	sliderWidth			= 32;
	
//
//Scrolling
scrollYOffset = 0;
lastMY = 0;
lastMX = 0;
inputHeldDoneFirstTick = 0;

hInputTime = -1;
vInputTime = -1;
scrollingHowLongHoldUntilFast = floor(room_speed * 0.3);
vScrollResetTime = 0;
hScrollResetTime = 0;

//Surface
menuSurface = -1;

//Visual
selectedColour = c_white;