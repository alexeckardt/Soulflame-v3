/// @description 

//Enter Thingy
var cDist = point_distance(x, y, Camera.viewX, Camera.viewY);
var pInside = (minimumEffectDistance - cDist) / (minimumEffectDistance - maximumEffectDistance)
	pInside = clamp(pInside, 0, 1);

	//Above will be 0 if father than farthest dist
	// 1 if closer than
	// range between depending on the positoin

//Push
if (cDist < minimumEffectDistance) {
		
	var c = Camera.id
		
	c.followOffsetX = coserp(c.deffollowOffsetX, goalfollowOffsetX, pInside);
	c.followOffsetY = coserp(c.deffollowOffsetY, goalfollowOffsetY, pInside);
}
