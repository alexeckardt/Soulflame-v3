/// @desc

var vw = camera_get_view_width(vc);
var vh = camera_get_view_height(vc);

if (surface_exists(view_surf)) {
	var ax = camera_get_view_x(vc) - x;
	var ay = camera_get_view_y(vc) - y;
	draw_surface(view_surf, ax, ay);
}