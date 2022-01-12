/// @description 

//kill Self
if (!instance_exists(parentDialouge)) {
	instance_destroy();
}

//Check If Left
var leftGroupSize = parentDialouge.leftGroupSize
var isLeft = orderPosition < leftGroupSize;

//
//Decide Goal Position. All Calcultions will be in percents of the width of the screen.
var groupPosition = parentDialouge.characterEdgeGoalPositions;
var gXp = (isLeft) ? groupPosition : 1-groupPosition;
var myGroupOrder = orderPosition - (!isLeft*leftGroupSize)
var myGroupSize = (isLeft) ? leftGroupSize : parentDialouge.characterCount - leftGroupSize;

//Set Position
goalX = gXp + (myGroupOrder - ((myGroupSize-1) / 2))*0.12;

//
//Set Position Alt
//

	//Enter Frame
	if (parentDialouge.display && enterFrame) {
		enterFrame = false;
		enteringFrame = true;
		x = (isLeft) ? -0.4 : 1.4;}

	if (enteringFrame) {
		if (abs(x - goalX) < 0.001) { //less that .1% ~ 1 pixel
			enteringFrame = false;	
		}
	}

	//Exit Frame override
	if (!parentDialouge.display) {
		goalX = (isLeft) ? -0.4 : 1.4;
		enterFrame = true;
		enteringFrame = false;	
		}

//Slide To Correct Position
x = lerp(x, goalX, slideSpeed*Game.delta);

