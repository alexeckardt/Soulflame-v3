//
//DESC:
//
//
//

enum state {
	base,
	climb,
	wall_cling,
	hurt,
	hurt_spikes,
	dead,
	deadexplode, //for enemies after staggering
	
	//Change With Weapons
	
	combat_neutral,			//Quick Jabs and Round House Kicks
	
	//Held, Normal
	combat_running,			//Running Attack with small recovery
	combat_air_neutral,		//
	combat_air_horizontal,	//Front House Kick
	combat_air_up,			//Sky Upper Cut (To Hit Things Above)
	combat_air_down,			//Kick Jump (If Hits enemy it will jump again)
	combat_up,				//Punch Upwards
	combat_down,			//Punch Downwards
	
	//As Tilt
	combat_htilt,			//Heavy Punch / Kicks
	combat_up_tilt,			//Punch Upwards
	combat_down_tilt,		//Punch Downwards
	combat_air_htilt,			//Heavy Punch / Kicks
	combat_air_up_tilt,			//Punch Upwards
	combat_air_down_tilt,		//Punch Downwards
	
	combat_slide,			//Slide
	combat_slide_recover,	//Recover
	

	
	//Constant
	
	//Magic Moves, Require Mana and Skill Unlock
	special_neutral,		//
	special_horizontal,		// 
	special_up,				// Flaming Sky Uppercut
	special_down,			// Wild Fire
	
	special_air_neutral,	//
	special_air_horizontal,	// 
	special_air_up,			// Rocket Boost Upwards (A Second Double Jump Option)
	special_air_down,		// Ground Pound
	
	dash,
	
	blocking, // Hold, Blocks Incoming Attacks if correct type vs weapon
	
	combat_recovery, //For Heavy Sprites + Enemies; Generic State
	
	sitdown, //visual state
	sit, //visual state
	situp,	 //visual state
	
	
		//ENEMY STATES
		chase,
		run,
		breaking,
	
	height, //states count, used for idle in enemies
}