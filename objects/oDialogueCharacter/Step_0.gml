/// @description 

//kill Self
if (!instance_exists(parentDialogue)) {
	instance_destroy();
}

//Check If Left
var leftGroupSize = parentDialogue.leftGroupSize
if (!exitFrame) {
	isLeft = orderPosition < leftGroupSize;}

//
//Decide Goal Position. All Calcultions will be in percents of the width of the screen.
var groupPosition = parentDialogue.characterEdgeGoalPositions;
var gXp = (isLeft) ? groupPosition : 1-groupPosition;
var myGroupOrder = orderPosition - (!isLeft*leftGroupSize)
var myGroupSize = (isLeft) ? leftGroupSize : parentDialogue.characterCount - leftGroupSize;

//Set Position
goalX = gXp + (myGroupOrder - ((myGroupSize-1) / 2))*0.12;

//
//Set Position Alt
//

	//Enter Frame
	if (parentDialogue.display && enterFrame && !exitFrame) {
		enterFrame = false;
		enteringFrame = true;
		x = (isLeft) ? -0.4 : 1.4;}

	if (enteringFrame) {
		if (abs(x - goalX) < 0.001) { //less that .1% ~ 1 pixel
			enteringFrame = false;	
		}
	}

	//Exit Frame override
	if (!parentDialogue.display || exitFrame) {
		goalX = (isLeft) ? -0.4 : 1.4;
		enterFrame = true;
		enteringFrame = false;	
		}

//Slide To Correct Position
x = lerp(x, goalX, slideSpeed*Game.delta);

var name = nameStr;
