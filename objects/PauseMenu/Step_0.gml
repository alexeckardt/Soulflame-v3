/// @description 

if (close) {
	instance_destroy();
	exit;
}

//Scaling
displayWidth =	Camera.view_width * Game.uiScale;
displayHeight = Camera.view_height * Game.uiScale;

//Get
var pageList = page[1];

//Selecting + Scrolling
	
	//Wait For Vertical Input
	var my = Controller.uiDown - Controller.uiUp;

	//On First 
	if (my != lastMY) {
		lastMY = my;
		vScrollResetTime = 100;}

	//Input
	if (my != 0) {
			
		vInputTime -= Game.indepedentDelta;
		vScrollResetTime -=  Game.indepedentDelta
		
		//Scroll Slow then Fast
		var ticksUntilIncreaseOnHold = 3;
		var elementCount = ds_list_size(pageList);
		if ((vScrollResetTime < 0) && (vInputTime < 0)) || (vScrollResetTime > ticksUntilIncreaseOnHold) { 
			
			//Next, Scroll
			var newId = elementHoverID;
			do {
				newId += my;
			}
			//Skip Blanks
			until (newId < 0 || newId >= elementCount) || (pageList[| newId][0] != -1);

			//Set
			elementHoverID = clamp(newId, 0, elementCount-1)

			//Reset Scroll Time
			vScrollResetTime = ticksUntilIncreaseOnHold
			
		}	
	} else {
		
		vInputTime = scrollingHowLongHoldUntilFast
		
	}
	
	
//Interacting
if (Controller.uiBackPressed) {
	
	//Controller
	Controller.uiSelectPressed = false;
	
	//Go Back A Page
	elementHoverID = 0;
	var elementInfo = pageList[| elementHoverID];
	var pageTo = elementInfo[3];
	page = variable_instance_get(id, pageTo);
	elementHoverID = 0;
}



	if ( elementHoverID != -1 ) {
		
		//Pressed To Show Description
		var elementInfo = pageList[| elementHoverID];
		
		if (!is_undefined(elementInfo)) {
			
			var type = elementInfo[0];
		
			//Interact
			if (Controller.uiSelectPressed) {

				switch (type) {
				
					case m_e.page_transfer:
				
						var pageTo = elementInfo[3];
						page = variable_instance_get(id, pageTo);
						elementHoverID = 0;
					
						break;
					
					case m_e.script_runner:
				
						var scriptt = elementInfo[3];
						var argsUse = elementInfo[4];
						script_execute_alt(scriptt, argsUse)
					
						break;
					
					case m_e.shift_through_indexes:
				
						//Upack
						var objId = elementInfo[3];
						var varName = elementInfo[4];
						var optionsAsLanguageArray = elementInfo[5];
					
					
						//Get Value
						var varValue = variable_instance_get(objId, varName);
				
						//Set Value
						var nextShift = (varValue+1) % array_length(optionsAsLanguageArray);
						variable_instance_set(objId, varName, nextShift);
					
						break;
				
				}
		
			}
		
			//!!
			if (type == m_e.slider) {
			
				var mx = Controller.right - Controller.left;
			
				//On First 
				if (mx != lastMX) {
					lastMX = mx;
					hScrollResetTime = 100;}

				//Input
				if (mx != 0) {
			
					hInputTime -= Game.indepedentDelta;
					hScrollResetTime -=  Game.indepedentDelta
		
					//Scroll Slow then Fast
					var ticksUntilIncreaseOnHold = 3;
					if ((hScrollResetTime < 0) && (hInputTime < 0)) || (hScrollResetTime > ticksUntilIncreaseOnHold) { 
			
						//Upack
						var objId = elementInfo[3];
						var varName = elementInfo[4];
						var minVal = elementInfo[5];
						var maxVal = elementInfo[6];
						var segments = elementInfo[7];
					
						//Get Value
						var varValue = variable_instance_get(objId, varName);
				
						var segmentValue = (maxVal - minVal)/segments;
				
						//Set Value
						var nextShift = clamp(varValue + segmentValue*mx, minVal, maxVal);
						variable_instance_set(objId, varName, nextShift);
	
					}
			
				} else {
		
					hInputTime = scrollingHowLongHoldUntilFast
		
				}
			
				//Reset
				lastMX = mx;
					
			}
		
		}
		
	}