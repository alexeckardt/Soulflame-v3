/// @description Camera Other


//Switch To Full Screen
if (window_get_fullscreen() != Game.fullscreen) {
	window_set_fullscreen(Game.fullscreen);
	display_reset(0, false);
}

//photo Mode
if (keyboard_check_pressed(vk_f8)) {
	photoMode = !photoMode;
	x = viewX;
	y = viewY;
}


//
//
// LIGHTING
//
//

//Creates Quad with two triangles. Used to make the shadows. 
//Z coordinate is used as a flag to determine if the vertex will be repositioned in the shader
function Quad(_vb,_x1,_y1,_x2,_y2){

	//Upper triangle
	vertex_position_3d(_vb,_x1,_y1,0);
	vertex_position_3d(_vb,_x1,_y1,2); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,1);
	
	//Lower Triangle
	vertex_position_3d(_vb,_x1,_y1,2); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,1);
	vertex_position_3d(_vb,_x2,_y2,3); //repositioned vertex
}

//Construct the vertex buffer with every wall
//Instead of using the four edges as the walls, we use the diagonals instead (Optimization)
vertex_begin(vb,vf);
var _vb = vb;
with(Solid){
	
	if (isTriangle) {
		var mid_x = (2*x + sprite_width)/2;
		var mid_y = (2*y + sprite_height)/2;
		
		Quad(_vb,x,y+sprite_height,x+sprite_width,y);
		Quad(_vb,x+sprite_width,y+sprite_height,mid_x,mid_y);
	}
	else 
	{
		Quad(_vb,x,y,x+sprite_width,y+sprite_height); //Negative Slope Diagonal Wall
		Quad(_vb,x+sprite_width,y,x,y+sprite_height); //Positive Slope Diagonal Wall
	}
}
vertex_end(vb);


if (mouse_check_button_pressed(mb_left)) {
	instance_create_depth(mouse_x, mouse_y, lightDepthLayer, Light);	
}