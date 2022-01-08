// @desc
//
//
//
function enemy_piece_create(spr, xoffDF1, yoff, dirFacing, bounceToStart, weight, bounceEnergyRetain) {

	//Create Piece
	var piece = instance_create_depth(x + xoffDF1*dirFacing, y+ yoff, depth, oEnemyPiece);
	
	piece.sprite_index =  spr
	piece.image_index = 0;
	piece.image_xscale = dirFacing;
	
	piece.bounce = bounceToStart;
	piece.resetBounceWhenInAir = bounceToStart;
	piece.bounceEnergyRetain = bounceEnergyRetain; //def 0.5
	piece.weight = weight; //def 1;
	
	var fromCenterAng = point_direction(0, 0, piece.x-x+lengthdir_x(1, deathHeadingDirection), piece.y-x+lengthdir_x(1, deathHeadingDirection));
	var dFromCenter = point_distance(x, y, piece.x, piece.y);
	
	piece.hSpeed = hSpeed + lengthdir_x(power(2, -dFromCenter), fromCenterAng);
	piece.vSpeed = vSpeed + lengthdir_y(power(2, -dFromCenter), fromCenterAng);

}