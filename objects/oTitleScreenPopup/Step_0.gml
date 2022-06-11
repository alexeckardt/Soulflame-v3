/// @description 

if (!setBoxDimensions) {
	setBoxDimensions = true;
	
	//Update
	maxW = camW * 0.75;
	var goalW = camW * 0.5;
	
	//Title Dimensions
	draw_set_font(fontExcelsior);
	titleString = string_wrap(titleString, maxW);	
	var titleWidth = string_width(titleString);
	titleHeight = string_height(titleString);
	
	//Set W Dimention
	draw_set_font(baseFont);
	boxW = max(titleWidth, goalW) + 2*buffer;	
	
	//Keep Body In Wraps 
	bodyString = string_wrap(bodyString, boxW - 2*buffer);
	
	//Box Height
	boxH = titleHeight + string_height(bodyString) + 2*buffer;	
	
	//Update (Redundant, Because It was originally supposed to lerp)
	w = boxW;
	h = boxH;
}

boxX = (camW - w) div 2
boxY = (camH - h) div 2

//Exit Box Top Left
closeX = boxX + boxW - 18;
closeY = boxY + 3;
hoveringOverClose = false;
if (clamp(mouse_x, closeX, closeX+16) == mouse_x) {
	if (clamp(mouse_y, closeY, closeY+16) == mouse_y) {
		hoveringOverClose = true;
	}
}
		
	
//Closeing
if (keyboard_check_pressed(vk_escape)) {
	open = false;
}

//Closeing Part 2
if (Controller.uiSelectPressed) {	
	if (Controller.PLAYMODE == "Mouse") {
		if (hoveringOverClose) {
			open = false;
		}
	} else {
		open = false;
	}
}

//Destroy
if (!open) {
	instance_destroy();	
}