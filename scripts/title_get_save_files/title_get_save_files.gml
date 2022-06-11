//
// Get The Save File Paths from the
//
function title_get_save_files() {
	
	//Get The Save File
	var savesFile = game_save_id + "save_files.txt";
	amountOfSaves = 0;
	ds_list_clear(saveFilePaths);
	
	//See If File Exists
	if (file_exists(savesFile)) {

		directory = game_save_id;
		
		//open file
		var readFile = file_text_open_read(savesFile);

		//Parse, Find All Save File Names
		var filesIn = 0;
		while (!file_text_eof(readFile)) {
				
			//Add Save File Name To Ds_List
			var extension = Game.saveExtension;
			
			var str = file_text_readln(readFile);
			var extPos = string_pos(extension, str);
			var savefilePath = string_copy(str, 0, extPos + 3);
			
			if (file_exists(directory + savefilePath)) {
				
				//Get Substring
				var extentionPosition = string_pos(".", savefilePath);
				if (extentionPosition != 0) {
					
					var path = string_copy(savefilePath, 1, extentionPosition + 3); 	
					ds_list_add(saveFilePaths, path);
					filesIn++;
				
				}	
			} 
		}
		file_text_close(readFile);
		
		
		//Recreate The File
		file_delete(readFile);
		var writeFile = file_text_open_write(savesFile);
		
		//Add Info Back To New File (This will disregard any deleted files)
		for (var i = 0; i < filesIn; i++) {
			
			//Write SaveFile Names To The File Per Line
			var filePath = saveFilePaths[| i];
			file_text_write_string(writeFile, filePath);
			file_text_writeln(writeFile);
			
		}
		file_text_close(writeFile);
		
		//Recreate Drawing Info
		saveFileInfoCreated = false;
	}	
}