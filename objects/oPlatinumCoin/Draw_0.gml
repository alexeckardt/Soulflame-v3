/// @description 

var yy = y+yoffset + sin((current_time-bounceOffset) / bounceTime)*bounceAmplitude
draw_sprite_ext(sprite_index, image_index, x, yy, spinDir, 1, 0, c_white, 1);