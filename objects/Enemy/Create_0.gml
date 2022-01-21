/// @desc

gameObj = Game.id;
mask_index = sprite_index;

//Attributes
//
//
	//Enemy Types
	lesser = false;

	//Health
	hp = 2;

	//Movement
	weight = 1;
	doCollision = true;
	
	//Damage
	hitboxes = ds_list_create();
	hitboxTakingDamage = noone;
	effectiveDamageTypes = [];
	resistedDamageTypes = [];
	
	//Essence
	essenceDropPerDamage = 6; //A Full Token is 100
	
	
	platinumDrop = 100; //
	platinumDropRange = 0.1; // +- this percent of the drop rate
							 // bosses should have 0
	
	
//Other Variables that *Should* be used by each enemy
//
//
	hitReactionTimeLeft = -1;
	invulnerableTicks = 0;
	myGrav = 0.2; //PLayer is 0.35?
	STATE = state.base;

	//Moveing
		controlHSpeed = 0; //Vector the Object itself should control for movement
		controlVSpeed = 0;
		knockbackHSpeed = 0; //Hspd Added To Knockback
		knockbackVSpeed = 0;
		hSpeed = 0; //Comboination
		vSpeed = 0;

	onGround = 0;
	groundBelow = noone
	timeSinceOnGround = 0;

	//Alignment
	randomize();
	alignment = choose(-1, 1);
	healthyPercent = 0;
	justDamaged = false;
		
	//Sprites
	updatedAlignmentSprites = false; //Updates any sprites on alginment switch or creation
	
	//Targetting
		target = oKeira;
		seesTarget = false;
		sightRange = 320; //20 tiles
		lastSawTargetX = 0;
		lastSawTargetY = 0;
		timeToNoticeTarget = room_speed;
		timeLeftBeforeNoticeTarget = 0;
		sinceSeenTarget = 0;
		
	//Health
		dead = false;
		deadTicks = 0;
		deadStaggerForTime = room_speed/2;
		autoSwitchToDeadState = true;
		
	//Visuals
		squishX = 1;
		squishY = 1;
		sqiushElasticity = 0.2;
		
		directionFacing = choose(1, -1);
		directionFacingSmooth = directionFacing; //For Animations and such
		turnSpeed = 0.2; //rate of change of above
		
		blend = c_white;
		alpha = 1;
		
		image_speed = 0;
		index_speed = 0;
		
	//Damage
	createdDamage = false;
	damageObj = noone;
	damageKnockbackAddVSpeed = -2;
	damageKnockbackAddHSpeed = 3;
	damageKnockbackAddHspeedRelative = true;
	deathHeadingDirection = 0;
	
	orgX = x;
	orgY = y;