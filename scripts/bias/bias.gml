// @desc
//
//
//

function bias(percentage, _curveSteepness) {

	//Decimal Should be from 0-1, otherwise clamped.

	//Curve Steepness
	// > 0 values (+0.8) will have a steep RoC near 1; most values will be closer to 0
	// < 0 values (-0.8) will have a steep RoC near 0; most values will be closer to 1
	// 0 Will be a linear dist.

	//larger absolute bias values will make the change more rapid
	//Although Stay within -1 and 1 for that
	
	// > 0 values will have a lower slope, turning to steep near 1
	// < 0 values will have a steep slope, turning to shallow near 1

	
	//This will make lower values (basically below the bias) low, and anything high (near 1) high
	//Follows an e^x curve but not really
	//Its a ^3 curve zoomed in lol

	/*
	//DESMOS CODE:
	
		b\ =\ 0.5\ 
		k=\ \left(1-b\right)^{3}\ 
		\frac{kx}{kx-x+1}\left\{0\le x\le1\right\}
	
	*/

	var xx = percentage;
	var bi = _curveSteepness;

	var k = power(1 - bi, 3);
	
	var num		= (xx*k)
	var denom	= (xx * k - xx + 1);
	
	//Error Code
	var returnValue = -1000;
	if (denom == 0) {
		show_debug_message("This Is An Error. Report This With The Message #biasDivideBy0");
	} else {
		returnValue = num / denom;	
	}
	
	//Return
	return returnValue;


}

function random_bias(_curve_steepness) {
	var randVal = random(1);
	var returnVal = bias(randVal, _curve_steepness);
	return returnVal
}