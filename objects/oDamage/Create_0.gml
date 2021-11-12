/// @desc

//On Creation Through Script
destroyed = false

xoffset			= 0;
yoffset			= 0;
followCreator	= false;
creator			= noone;
damage = 10;
damageType		= 0;

//status effects


//Edit After Fact
canDamageEnemies = true;
sprite_index = sDamageHitbox;
image_xscale = 1;
image_yscale = 1;
life = 3;
allowLifeDecay = true;

knockbackAmount = 1;
knockbackFromX = x;
knockbackFromY = y;
addToHSpeed = 0;
addToVSpeed = -2;

//Constants
mask_index = -1;

//Info
enemyHitCount = 0;
enemiesHit = ds_list_create();
hasHitEnemy = false;
hasHitEnemyAllowUpdate = false; //Updates along with above, but is seperate.
								//This one is to be reset by player object if needed
								//example, if this is true, slide speed is cut, and then this
								//is reset; so if I hit another enemy, slide speed is reduced again.
								//
								//However, if i don't hit another enemy, Damage still reccognizes
								//that it HAS hit something.