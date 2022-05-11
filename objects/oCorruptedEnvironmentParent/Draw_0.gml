/// @description 

//Shaking
var drawX = x + random_range(-1, 1)*shakeIntensity* Game.delta;
var drawY = y + random_range(-1, 1)*shakeIntensity* Game.delta;
var drawAng = image_angle + sin(current_time/10) * shakeIntensity * shakeAngleToo * Game.delta;

draw_sprite_ext(sprite_index, image_index, drawX, drawY, image_xscale, image_yscale, drawAng, image_blend, image_alpha);

//Draw Overlay
var b = merge_colour(c_black, essence_get_colour_bright(essenceType), sin(current_time / 1200)*0.1 + 0.3 + 0.3*shakeIntensity);
gpu_set_blendmode(bm_add);
shader_set(shdEssenceMagic);
	draw_sprite_ext(overlaySprite, image_index, drawX, drawY, image_xscale, image_yscale, drawAng, b, 1);
shader_reset();
gpu_set_blendmode(bm_normal);
