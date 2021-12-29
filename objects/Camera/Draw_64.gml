/// @desc

display_set_gui_size(view_width, view_height);
display_set_gui_size(display_get_gui_width(), display_get_gui_height());

draw_clear(0);

var vw = camera_get_view_width(vc);
var vh = camera_get_view_height(vc);

if (surface_exists(view_surf)) {
	var ax = camera_get_view_x(vc) - x;
	var ay = camera_get_view_y(vc) - y;
	draw_surface(view_surf, ax, ay);
}