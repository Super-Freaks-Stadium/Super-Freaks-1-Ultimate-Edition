/// @description Draw Background

var _view_x1 = view_x1_get();
var _view_height = view_height_get();
var _scroll_delta = lerp(scroll_previous, scroll, global.delta);

if (alternate)
	draw_set_color(make_colour_rgb(191, 44, 0));
else
	draw_set_color(make_colour_rgb(0, 152, 255));
draw_rectangle(0, 0, surface_get_width(surface), surface_get_height(surface), false);
draw_set_color(c_white);

draw_sprite_parallax_x(spr_background_toy_clouds, alternate, _view_x1, _view_height, 2, -_scroll_delta);
draw_sprite_parallax_x(spr_background_toy_bridge,, _view_x1, _view_height, 2);