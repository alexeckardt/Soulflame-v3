/// @description 

event_inherited();

//Decide Sprite
if (!decidedIndex) {
	decidedIndex = true;
	
	var xx = (abs(value)+1)*3; //cannot be zero
	image_index = min(	floor(logn(5,xx)), image_number-1);
	minPlat = value;
	maxPlat = value;
	
}