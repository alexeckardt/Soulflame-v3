// @desc
//
//
//
function PointLight(_x, _y) constructor {

	//Light Vars
	active = true;
	colour = c_white;
	size = 8;
	str = 0.3;
	fov = 360;
	dir = 0;
	falloff = 1;
	
	//Particle Vars
	//movement
	collide = false;
	
	//pos
	xx = _x;
	yy = _y;
	
	dir = 0;
	dirWiggle = 0;
	dirIncrease = 0;
	
	spd = 0;
	spdWiggle = 0;
	spdAbsolute = true;
	spdIncrease = 0;
	
	doGravity = false;
	gravStr = 0; //mutator
	gravDir = 0;
	gravPull = gravStr; //the actual force
	
	life = 0;
	startingLife = 0;
	fadeThroughLife = true;

	//Colours
	startCol = 0;
	endCol = 0;
	
	//Visuals
	drawSprite = true;
	sprite = sPixel;
	index = 0;
	index_speed = 0;
	
	toDelete = false;

	static update = function() {
	
		var t = Game.delta;
		//Time
		life -= t;

		//Mutate Movement
		spd += (random_range(-spdWiggle, spdWiggle) + spdIncrease)*t;
		dir += (random_range(-dirWiggle, dirWiggle) + dirIncrease)*t;

		//Save For Use
		var spdUsing = spd;
		var dirUsing = dir;

		if (spdAbsolute && spd < 0) {spdUsing = 0;}
		
		//
		//Gravity (Compounds and is unaffected by dir wiggle)
		if (doGravity) {
	
			//Increase Grav Strength
			gravPull += gravStr*t*t;
	
			//Combine Vectors
			var hcomponent = lengthdir_x(spdUsing, dirUsing) + lengthdir_x(gravPull, gravDir);
			var vcomponent = lengthdir_y(spdUsing, dirUsing) + lengthdir_y(gravPull, gravDir);
	
			//Solve Vector
			spdUsing = point_distance(0, 0, hcomponent, vcomponent);
			dirUsing = point_direction(0, 0, hcomponent, vcomponent);
	
		}

		//Move
		xx += lengthdir_x(spdUsing, dirUsing) * t;
		yy += lengthdir_y(spdUsing, dirUsing) * t;

		//
		//
		//

		//Change Colour
		if (fadeThroughLife) {
	
			//Life Percent (1 = full life left >>> 0 = dead)
			var lifep = 1 - life/startingLife;
			colour = merge_colour(startCol, endCol, lifep);
	
		}

		//End
		if (life <= 0) {
			toDelete = true;
		}

		//
		//
		//
		index += index_speed*t;
	
	};
	
	static draw = function() {
		
		if (!toDelete) {
		
			gpu_set_blendmode(bm_add);
				gpu_set_colorwriteenable(1, 1, 1, 0);
				if (Game.showDebugOverlay || drawSprite) {
					draw_sprite_ext(sprite, index, xx, yy, 1, 1, 0, colour, life/startingLife); }
				gpu_set_colorwriteenable(1, 1, 1, 1);
			gpu_set_blendmode(bm_normal);
		
		}
		
	};

}