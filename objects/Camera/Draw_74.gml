/// @desc

display_set_gui_size(view_width, view_height);
display_set_gui_size(display_get_gui_width(), display_get_gui_height());

draw_clear(0);

var vw = camera_get_view_width(vc);
var vh = camera_get_view_height(vc);

if (surface_exists(view_surf)) {
	var ax = 0//camera_get_view_x(vc)
	var ay = 0//camera_get_view_y(vc);
	draw_surface(view_surf, frac(ax), frac(ay));
}