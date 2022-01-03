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
	dead,
	
	//Change With Weapons
	
	combat_neutral,			//Quick Jabs and Round House Kicks
	combat_htilt,			//Heavy Punch / Kicks
	combat_running,			//Running Attack with small recovery
	combat_up,				//Punch Upwards
	combat_down,			//Punch Downwards
	
	combat_slide,			//Slide
	combat_slide_recover,	//Recover
	
	combat_air_neutral,		//
	combat_air_horizontal,	//Front House Kick
	combat_air_up,			//Sky Upper Cut (To Hit Things Above)
	combat_air_down,			//Kick Jump (If Hits enemy it will jump again)
	
	
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
	
	height, //states count, used for idle in enemies
}