//
//DESC:
//
//
//
function corruption_add(alignment, base) {

	
	var playerAlign = sign(round(Player.corruptionPercent * 1000) * 0.001);
	
	//Any Artifacts to Dampen Corruption?
	
	
	var baseCorruptionAdd = base*alignment;
	
	
	//
	//
	//	Change Corruption Percent
	//
	//
	
	//Zero Corruption; Pure Cancel
	if (alignment == 0) {
		Player.corruptionPercent = playerAlign*max(0, abs(Player.corruptionPercent) - base/Player.corruptionResistance);
	}
		
	
	//
	//
	//Basic Addition Of Corruption
	if (playerAlign == alignment || playerAlign == 0) {
		Player.corruptionPercent += baseCorruptionAdd / Player.corruptionResistance;	
	}
	
	//
	//Subtraction of Corruption
	else if (playerAlign == -alignment) {
		var oppositeAlignmentCancelCoef = 2;
		var change = baseCorruptionAdd / (oppositeAlignmentCancelCoef*Player.corruptionResistance);
		
		Player.corruptionPercent += change;
	}
	
	
	//Clamp
	Player.corruptionPercent = clamp(Player.corruptionPercent, -1, 1);
	

}