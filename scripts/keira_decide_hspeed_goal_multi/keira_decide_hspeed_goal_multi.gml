//
//DESC:
//
//
//
function keira_decide_hspeed_goal_multi(){

	//Base Multi
	var hspdGoalsMultipliers = 1;

	//In Water
	if (inWater) {
		//Range (in little amount of water, do less drag
		hspdGoalsMultipliers *= lerp(waterMinDrag, waterDrag, waterDepthPercent);
	}

	//Return
	return hspdGoalsMultipliers;

}