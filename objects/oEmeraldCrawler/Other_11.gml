/// @desc - Nodes

//Create
if (!createdNodes) {

	//
	//Head
	ds_list_add(nodes, new LinkedSpriteNode(headSprite, 0, x, y, 0.03));

	//
	//Body
	var current_angle = irandom(360);
	var lastX = x;
	var lastY = y;
	
	for (var i = 0; i < bodyNodeCount; i++) {
		
		current_angle += irandom_range(-40, 40);
		
		var xx = lastX + lengthdir_x(bodyNodeSeperation*5,current_angle); 
		var yy = lastY + lengthdir_y(bodyNodeSeperation*5,current_angle);
		
		var struct = new LinkedSpriteNode(bodySprite, i, xx, yy, 0.2);
		
		//Each gets a hit box, add to my hitbox list
		struct.hitboxid = hitbox_create_for_list(hitboxes, 0, 0, 4, 4, true);
		struct.hitboxid.autoMoveToOwner = false;
			
		//Add
		ds_list_add(nodes, struct);	
		
	}
	
	createdNodes = true;
	
}

//
//
//Update
var headNode = nodes[| 0];
headNode.xx = x;
headNode.yy = y;
headNode.animate();

//Loop Body
var lastX, lastY;
lastX = x;
lastY = y;
for (var i = 1; i < bodyNodeCount+1; i++) {
		
	//Get Dir FROM last 
	var node = nodes[| i];
	var dir = point_direction(lastX, lastY, node.xx, node.yy);
		
	//Decide new Pos
	var newX = lastX + lengthdir_x(bodyNodeSeperation, dir);
	var newY = lastY + lengthdir_y(bodyNodeSeperation, dir);
		
	//Get Distance
	var dis = point_distance(newX, newY, node.xx, node.yy);
		
	//Save
	node.xx = newX;
	node.yy = newY;
	node.angle = dir + 180; //needs flipping
	
	//Animate
	var spd = node.index_speed * clamp(sqr(dis/maxSpeed), 0, 1);
	node.animate(spd);
	
	//Move Hitbox
	node.hitboxid.x = newX;
	node.hitboxid.y = newY;
	
	
	lastX = newX;
	lastY = newY;
	
}

//Don't let the head snap off it's body
var goalheadDir = nodes[| 1].angle
headNode.angle -= angle_difference(headNode.angle, goalheadDir) / 2; //at most 90 degree dif
