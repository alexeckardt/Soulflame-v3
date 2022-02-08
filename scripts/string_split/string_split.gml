//
//DESC:
//
//Splits string based on words (spaces)
//
function string_split(str) {

	//Create New Array
	var wordArray;
	var spaces = string_count(" ", str);
	wordArray[max(spaces-1, 0)] = "";
	
	//Remove the /
	str = string_replace(str, "/", "");
	
	//Reset
	var currentSubstr = str;
	var substrLength = string_length(str);
	var wordAdding = 0;
	
	//
	for (var i = 0; i < spaces+1; i++) {
	
		//Find Next Position With Space
		var nextSpacePos = string_pos(" ", currentSubstr); 
		if (nextSpacePos == 0) {
			nextSpacePos = substrLength+1; }
		
		//Get The Word
		var word = string_copy(currentSubstr, 1, nextSpacePos-1);
	
		//Set In Array
		wordArray[wordAdding] = word;
		wordAdding++;
		
		//Remove the First Word
		currentSubstr = string_copy(currentSubstr, nextSpacePos+1, substrLength-nextSpacePos);
	}
	
	return wordArray;

}