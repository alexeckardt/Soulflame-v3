/// @desc

isEllipse = false;
creator = noone;

xoffset = 0;
yoffset = 0;
hitboxWidth = 16;
hitboxHeight = 16;

//
hitboxLocked = false;

//Sprite Collision
sprite_index = sHitboxArea;
mask_index = -1;
sprW = sprite_get_width(sprite_index);

damagesMeeting = ds_list_create();
damagingObjectId = noone;

isPlayerHitbox = false;