/// @description 

draw_sprite(sprite_index, 0, x, y)

gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, 1, x, y, 1, 1, 0, c_white, 0.5*litPercent*flameFrequencyStrength)
gpu_set_blendmode(bm_normal);

//shader_set(shdEssenceMagic);
draw_sprite_magic(sFire, fireIndex, x, y-11, litPercent, litPercent, 0, flameColour, 1 + flameFrequencyStrength, 0.4);
//shader_reset();
