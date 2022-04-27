/// @description 

var worldCamW = Camera.view_width + 1;
var worldCamH = Camera.view_height + 1;
var _vb = vb;

cX = Camera.x;
cY = Camera.y;
var _cx = cX;
var _cy = cY;

//Uniform Imports
var _u_pos = u_pos;
var _u_pos2 = u_pos2;
var _u_zz = u_zz;


if (!surface_exists(lightLayerSurf)) {
	lightLayerSurf = surface_create(worldCamW,worldCamH);	
}


surface_set_target(lightLayerSurf);
draw_clear_alpha(0,0);

matrix_set(matrix_world, matrix_build(-_cx, -_cy, 0, 0, 0, 0, 1, 1, 1));

//Turn on the Zbuffer (3D)
with(Light){

	//Draw the shadows (AKA light blockers)
	gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
	shader_set(shd_shadow);
	shader_set_uniform_f(_u_pos2,x,y);
	vertex_submit(_vb,pr_trianglelist,-1);
	
	//Draw the Light
	gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha, bm_one, bm_zero, bm_zero);
	shader_set(shd_light);
		shader_set_uniform_f(_u_pos,x,y);
		shader_set_uniform_f(_u_zz,size);
	
	draw_sprite_ext(sPixel,1,_cx, _cy,worldCamW,worldCamH,0, colour, 1); //canvas for drawing the light
	
}
shader_reset();
surface_reset_target();

matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));