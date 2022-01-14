// @desc
//
//
//
function menu_element_create(_elementInfo) {
		
	//Check Valid
	if (is_array(_elementInfo)) {
		
		if (array_length(_elementInfo) > 2) {
		
			var nameSuffix = _elementInfo[0];
			var type = _elementInfo[1];
		
			switch (type) {
			
				default:
					return [-1];
		
				//
				//
				case m_e.page_transfer:
			
					//Unpack
					var pageTo = _elementInfo[2];
				
					//Name
					var name = lang_get_text("menu.page." + nameSuffix);	
				
					//Return
					return [type, name, "", pageTo];
			
				//
				//
				case m_e.script_runner:
			
					//Upack
					var scriptRun = _elementInfo[2];
					var argsUse = _elementInfo[3];
				
					//Name
					var name = lang_get_text("menu.s." + nameSuffix);
					var desc = lang_get_text("menu.s." + nameSuffix + ".desc")
				
					//Repack
					return [type, name, desc, scriptRun, argsUse];
				
				//
				//
				case m_e.shift_through_indexes:
			
					//Unpack
					var instanceId					= _elementInfo[2];
					var variableName				= _elementInfo[3];
					var displayForIndex				= _elementInfo[4];
				
					//Get Name and Desc
					var name = lang_get_text("menu.e." + nameSuffix);
					var desc = lang_get_text("menu.e." + nameSuffix + ".desc")

					//Update Options To Be Lang
					var optionCount = array_length(displayForIndex);
					for (var i = 0; i < optionCount; i++) {
						displayForIndex[i] = lang_get_text(displayForIndex[i]);	
					}

					//Repack
					return [type, name, desc, instanceId, variableName, displayForIndex, ];
					
				case m_e.slider:
			
					//Unpack
					var instanceId					= _elementInfo[2];
					var variableName				= _elementInfo[3];
					var minVal						= _elementInfo[4];
					var maxVal						= _elementInfo[5];
					var segments					= _elementInfo[6];
					var asPercent					= _elementInfo[7];
				
					//Get Name and Desc
					var name = lang_get_text("menu.e." + nameSuffix);
					var desc = lang_get_text("menu.e." + nameSuffix + ".desc");
					
					//Repack
					return [type, name, desc, instanceId, variableName, minVal, maxVal, segments, asPercent];
			}
		
		}
		
	} 
	
	//Blank Spacer
	return [-1, "", ""];
	
}