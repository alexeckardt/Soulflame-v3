/// @desc

display_set_gui_size(view_width, view_height);
//display_set_gui_size(display_get_gui_width(), display_get_gui_height());

draw_clear(0);

if (surface_exists(view_surf)) {
	draw_surface(view_surf, 0, 0);
}