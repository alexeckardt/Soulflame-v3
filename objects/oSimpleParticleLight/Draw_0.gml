 /// @description 
 
gpu_set_blendmode(bm_add);
gpu_set_colorwriteenable(1, 1, 1, 0);
if (Game.showDebugOverlay || drawSprite) { draw_sprite_ext(sprite, image_index, x, y, 1, 1, 0, colour, life/startingLife); }
gpu_set_colorwriteenable(1, 1, 1, 1);
gpu_set_blendmode(bm_normal);