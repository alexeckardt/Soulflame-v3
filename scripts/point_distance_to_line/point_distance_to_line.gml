// @desc
//
//BAAAAD ALGORITHM
//
function point_distance_to_line(px, py, x1, y1, x2, y2) {


	var lineLength = point_distance(x1, y1, x2, y2);

	//Same Point, get point distance  (avoid div by 0)
	if (x1 == x2 && y1 == y2) {
		return point_distance(px, py, x1, y1);	
	}
	
	//Formaula (wikipedia) https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line
	var num = abs((x2 - x1)*(y1-py) - (x1-px)*(y2-y1))
	var denum = point_distance(x1, y1, x2, y2);

	var disToLine = num / denum;
	
	var disToEnd1 = point_distance(px, py, x1, y1);
	var disToEnd2 = point_distance(px, py, x2, y2);
	
	var farthestEnd = max(disToEnd1, disToEnd2);
	
	//Check If The nearest Point on line is inside the line boundries
	if (farthestEnd*farthestEnd - disToLine*disToLine < lineLength) {
		return disToLine;
	}
	
	//Otherwise, Cloestest is an Endpoint
	return min(disToEnd1, disToEnd2);


}