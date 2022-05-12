/// @description 

/// @desc Default Draw

if (draw) {

	for (var i = 0; i < linkCount; i++) {
		var link = links[| i];
		link.drawPrimative();
	}

	for (var i = 0; i < pointCount; i++) {
		var point = points[| i];
		point.drawPrimative();
	}

}
