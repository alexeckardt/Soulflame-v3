// @desc
//
//
//
function menu_element_change_slider_value(){
	
	var ticksUntilIncreaseOnHold = 8;
	if ((sliderHoldTicks % ticksUntilIncreaseOnHold == 0)
	&& (sliderHoldTicks >= 0))
	|| (sliderHoldTicks == -27) { //Or One Tick Since Holding
			
		//Prevent Holding L or R, Reset in hover_over_optin
			
		if (mx != 0) {
				
			//Move and Clamp
			var clampped = clamp(currentlyOn+mx, minn, maxx);
				
			//Shake
			if (currentlyOn != clampped) {
				currentlyOn = clampped;
				elementYShakeMulti = 0.6;
				elementYShakeTime = current_time;
			}
				
			//Execute
			script_execute(grid[# 2, hoveringOverOption], currentlyOn);
				
				
		}
	}
}