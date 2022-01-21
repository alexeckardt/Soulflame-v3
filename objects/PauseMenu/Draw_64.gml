/// @description 
//
//--------------------------------------------------------------------------
//

//TempVariable Setup

var pageName = page[0];
var pageList = page[1];

draw_set_font(menuElementFont);

//
//Size

//
//Surface Create & Resize
if (!surface_exists(menuSurface)){
	menuSurface = surface_create(displayWidth + 2, displayHeight + 2);
}
	
if (surface_get_width(menuSurface) != displayWidth + 2) {
	surface_resize(menuSurface, displayWidth + 2, displayHeight + 2);
	surfaceScaleCreatedAt = Player.uiScale;
}
	
//
//Constant Background
if (!surface_exists(backgroundSurf)){
	backgroundSurf = surface_create(Camera.view_width+2, Camera.view_height+2);
}
	
	

//Resize
var middleLine	= displayWidth div 2;


//-----------------------------------------------------------------------------------
//===============================Background Frame========================
//-----------------------------------------------------------------------------------

//Temp
surface_set_target(backgroundSurf);
draw_clear_alpha(backgroundColour, 0.8);

surface_reset_target();

//-----------------------------------------------------------------------------------
//===============================Particles========================
//-----------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------
//===============================Page Text Background========================
//-----------------------------------------------------------------------------------



//-----------------------------------------------------------------------------------
//===============================Elements===========================================
//-----------------------------------------------------------------------------------

//Green Screen
surface_set_target(menuSurface);

draw_clear($00ff00);
 
//Page name
	draw_set_font(fontExcelsiorLarge);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	var titleC	= c_dkgray;
	var titleYY	= 48 / Player.uiScale - scrollYOffset*0.5;

	draw_text_colour(middleLine, titleYY, pageName, titleC,titleC,titleC,titleC,1);

//Elements
draw_set_font(menuElementFont);

//Scroll Position
var baseYY = (startDrawElementAtY) / Player.uiScale - floor(scrollYOffset);

//Eclipse Title
draw_sprite_ext(sPixel, 0, 0, baseYY - 5, displayWidth, displayHeight, 0, $00ff00, 1);

//Loop Through Each Elements
var elementsOnPage = ds_list_size(pageList);
for (var j = 0; j < elementsOnPage; j++) {

	//Reset Alignment
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var elementInfo = pageList[| j];

	//Get If Hovering Over
	var shakee = 0;
	var thisElementSelected = (elementHoverID == j);
	if (thisElementSelected) {
			
		//Shake
		if (elementYShakeMulti > 0) {
			var period = 30 + abs(1-elementYShakeMulti)*100;
			var sinnes = cos((current_time-elementYShakeTime)/period) * -2;
				
			//Shake
			shakee = sinnes * elementYShakeMulti;
			
			//Lower
			elementYShakeMulti = lerp(elementYShakeMulti, 0, 0.02);
		}
		
		//Colour
		thisElementSelected = true;
		
	}
	//Get Draw Poosition
	var drawY = baseYY + (elementHeight + elementSpacing)*j + shakee;
	
	
	//Only Draw If Within Screen, Not Below
	if (drawY > 0 && drawY < displayHeight) {
		
		//---------------------------------------------------------------------------------------
		
		//Right Align Text On Left Side Of Line (The Element Name)
		draw_set_halign(fa_right);
		var drawElementLeftX = (middleLine - middleBuffer);
		var drawElementRightX = (middleLine + middleBuffer);
		
		//Colour Set
		var c = (thisElementSelected) ? selectedColour : c_gray;
		
		//---------------------------------------------------------------------------------------
		
		var elementType = elementInfo[0];
		
		//If Empty, Act as Buffer
		if (elementType == -1) continue;
		
		//All Elements Have These Components In These Positions
		var elementName = elementInfo[1];
		var elementDesc = elementInfo[2];
		
		//
		
		//Draw The Element based on type
		switch(elementType) {
				
			//----------------------------------------------------------------
			
			default:
			case m_e.script_runner:
			case m_e.page_transfer:
			
					//Center And Draw
					draw_set_halign(fa_center);
					draw_text_colour(middleLine, drawY, elementName, c,c,c,c,1);
					break;

				
			//----------------------------------------------------------------
			
			case m_e.debug_conditional:
			
					//Choose a new colour for this (Must be active)
					var c = (thisElementSelected) ? selectedColour : c_gray;
					c = (!Game.showDebugOverlay) ? c_dkgray : c;
					
					//Draw Name Right Aligned
					draw_text_colour(drawElementLeftX, drawY, elementName, c,c,c,c,1);
					
					//Upack
					var objId = elementInfo[3];
					var varName = elementInfo[4];
					
					//Get Value
					var varValue = variable_instance_get(objId, varName);
					var optionsAsLanguageArray = elementInfo[5];
					var currentOptionState = optionsAsLanguageArray[varValue];
					
					draw_set_halign(fa_left);
					draw_text_colour(drawElementRightX, drawY, currentOptionState, c,c,c,c,1);
					
					break;
					
			//----------------------------------------------------------------
			
			case m_e.shift_through_indexes:
			
					//Draw Name Right Aligned
					draw_text_colour(drawElementLeftX, drawY, elementName, c,c,c,c,1);
					
					//Upack
					var objId = elementInfo[3];
					var varName = elementInfo[4];
					
					//Get Value
					var varValue = variable_instance_get(objId, varName);
					var optionsAsLanguageArray = elementInfo[5];
					var currentOptionState = optionsAsLanguageArray[varValue];
					
					draw_set_halign(fa_left);
					draw_text_colour(drawElementRightX, drawY, currentOptionState, c,c,c,c,1);
					
					break;
				
				
			//----------------------------------------------------------------
			
			case m_e.slider:
			
					//Draw Name Right Aligned
					draw_text_colour(drawElementLeftX, drawY, elementName, c,c,c,c,1);
					
					//Upack
					var objId = elementInfo[3];
					var varName = elementInfo[4];
					var minVal = elementInfo[5];
					var maxVal = elementInfo[6];
					var segments = elementInfo[7];
					var asPercent = elementInfo[8];
					
					//Get Value
					var varValue = variable_instance_get(objId, varName);			
					var valueSlider = floor((varValue / maxVal) * segments);
					
					var sliderSegmentWidth = sliderWidth div segments;
					var noDoneC = c_dkgray;
					
					//
					//
					for (var i = 0; i < segments; i++) {
					
						var sliderSegmentC = (i < valueSlider) ? c : noDoneC;
						var segX = drawElementRightX + i*sliderSegmentWidth;
						
						//
						draw_sprite_ext(sPixel, 0, segX, drawY-2, sliderSegmentWidth, elementHeight, 0, sliderSegmentC, 1);
					}
					
					draw_set_halign(fa_left);
					if (asPercent) {
						varValue = string(round(varValue * 100)) + " %";}
					draw_text_colour(drawElementRightX + sliderWidth + 3, drawY, string(varValue), c,c,c,c, 1);
					
					break;
				
				
			//----------------------------------------------------------------
						
		}
	}
}

//-----------------------------------------------------------------------------------
//===============================DRAW SURFACE===========================================
//-----------------------------------------------------------------------------------

//Exit
surface_reset_target();

//Draw Surfaces
display_set_gui_size(Camera.view_width, Camera.view_height);
draw_surface(backgroundSurf, -1, -1);

display_set_gui_size(displayWidth, displayHeight);
shader_set(shdGreenScreen);
	draw_surface(menuSurface, -1, -1);
shader_reset();