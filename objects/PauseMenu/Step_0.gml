/// @description 

if (close) {
	instance_destroy();
	exit;
}

//Scaling
displayWidth =	Camera.view_width / Player.uiScale;
displayHeight = Camera.view_height / Player.uiScale;

//Get
var pageList = page[1];

//Selecting + Scrolling
	
	//Wait For Vertical Input
	var my = Controller.uiDown - Controller.uiUp;
	var mx = Controller.right - Controller.left;
	 
	//On First 
	if (my != lastMY) {
		lastMY = my;
		vScrollResetTime = 100;}

	//Input
	if (my != 0 && mx == 0) {
			
		vInputTime -= Game.independentDelta;
		vScrollResetTime -=  Game.independentDelta
		
		//Scroll Slow then Fast
		var ticksUntilIncreaseOnHold = 3;
		var elementCount = ds_list_size(pageList);
		if ((vScrollResetTime < 0) && (vInputTime < 0)) || (vScrollResetTime > ticksUntilIncreaseOnHold) { 
			
			//Next, Scroll
			var newId = elementHoverID;
			var isValid = false;
			do {
				newId += my;
				
				var outOfBounds = (newId < 0 || newId >= elementCount);
				if (!outOfBounds) {
				
					//
					//Check If New Pos is Valid
					var type = pageList[| newId][0];
					var notEmpty = (type != -1);
				
					//Check if Disabled
						var debugDisabled = (type == m_e.debug_conditional && !Game.showDebugOverlay);
					var elementEnabled = !debugDisabled; //||
				
					//Should Skip this
					isValid = (notEmpty && elementEnabled);
				
				//Reached End; Do NOT Update position
				} else {
					newId = elementHoverID;
					break;
				}
			}
			//Skip Blanks
			until (isValid);

			//Set
			elementHoverID = clamp(newId, 0, elementCount-1)

			//Reset Scroll Time
			vScrollResetTime = ticksUntilIncreaseOnHold;
			
			//Shake
			shakeAtTime = current_time;
			shakeAmplitude = sign(my);
			
			//Scroll
			if (page[3] == true) {
				var hoveringOverY = startDrawElementAtY + (elementHeight+elementSpacing)*elementHoverID;
				startScrollY = displayHeight*0.6;
			
				//ChooSe Goal Y
				var pageHeight = ds_list_size(pageList) * (elementHeight + elementSpacing);
				scrollYGoal = clamp(hoveringOverY - startScrollY, 0, max(0, pageHeight - lastElementGoesXHigh));
			}
		}	
	} else {
		
		vInputTime = scrollingHowLongHoldUntilFast
		
	}
	
	//Scroll
	scrollYOffset = lerp(scrollYOffset, scrollYGoal, 0.1*Game.independentDelta);
	
	
//Interacting
var resetElementHoveringRetention = false;
if (Controller.uiBackPressed) {
	
	//Force Select
	Controller.uiSelectPressed = true;
	
	//Go To Find Index (We assume the first index is a "Back" command)
	elementHoverID = 0;
	resetElementHoveringRetention = true;
	
	
	//SCROLL INSTANT
	var hoveringOverY = startDrawElementAtY + (elementHeight+elementSpacing)*elementHoverID;
	startScrollY = displayHeight*0.6;
	var pageHeight = ds_list_size(pageList) * (elementHeight + elementSpacing);
	scrollYOffset = clamp(hoveringOverY - startScrollY, 0, max(0, pageHeight - lastElementGoesXHigh));
			
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
						
						//Remeber Element Pressed
						array_set(variable_instance_get(id, page_varname_one), 2, elementHoverID*(!resetElementHoveringRetention));
						
						
						//Go To Next Page
						page = variable_instance_get(id, pageTo);	
						page_varname_one = pageTo;
						
						//Reget
						elementHoverID = page[2];
						scrollYOffset = 0;
						scrollYGoal = 0;
						
						
					
						break;
					
					case m_e.script_runner:
				
						var scriptt = elementInfo[3];
						var argsUse = elementInfo[4];
						script_execute_alt(scriptt, argsUse)
					
						shakeAtTime = current_time;
						shakeAmplitude = -1;

					
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
					
						shakeAtTime = current_time;
						shakeAmplitude = -0.5;
					
					
						break;
						
					case m_e.debug_conditional:
				
						//Upack
						if (Game.showDebugOverlay) {
							
							var objId = elementInfo[3];
							var varName = elementInfo[4];
							var optionsAsLanguageArray = elementInfo[5];
					
							//Get Value
							var varValue = variable_instance_get(objId, varName);
				
							//Set Value
							var nextShift = (varValue+1) % array_length(optionsAsLanguageArray);
							variable_instance_set(objId, varName, nextShift);
							
							shakeAtTime = current_time;
							shakeAmplitude = -0.5;
						}
						
						break;
				
				}
		
			}
		
			//!!
			if (type == m_e.slider) {
					
				//On First 
				if (mx != lastMX) {
					lastMX = mx;
					hScrollResetTime = 100;}

				//Input
				if (mx != 0 && my == 0) {
			
					hInputTime -= Game.independentDelta;
					hScrollResetTime -=  Game.independentDelta;
		
					//Scroll Slow then Fast
					var ticksUntilIncreaseOnHold = 1;
					if ((hScrollResetTime < 0) && (hInputTime < 0)) || (hScrollResetTime > ticksUntilIncreaseOnHold) { 
			
						//Reset Scroll Time
						hScrollResetTime = ticksUntilIncreaseOnHold;
			
						shakeAtTime = current_time;
						shakeAmplitude = sign(mx)/2;
			
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
					
			}
		
		}
		
	}
	
//Shake
shakeOffset = cos((current_time-shakeAtTime) / shakePeriod) * shakeAmplitude * 2;
shakeAmplitude = lerp(shakeAmplitude, 0, 0.05*Game.independentDelta);