/// @description Draw Background

var _view_x1 = view_x1_get();
var _scroll_delta = lerp(scroll_previous, scroll, global.delta);
var _sky_color_top, _sky_color_bottom;

if (alternate)
{
	_sky_color_top = make_color_rgb(255, 191, 236);
	_sky_color_bottom = make_color_rgb(255, 127, 217);
}
else
{
	_sky_color_top = make_color_rgb(255, 173, 0);
	_sky_color_bottom = c_orange;
}
draw_rectangle_color(0, 0, surface_get_width(surface), surface_get_height(surface), _sky_color_top, _sky_color_top, _sky_color_bottom, _sky_color_bottom, false);
draw_set_color(c_white);

//draw
draw_sprite_parallax_x(spr_background_hippie_clouds,, _view_x1, view_height_get() - 64, 2, -_scroll_delta);
draw_sprite_parallax_x(spr_background_hippie_flowers,, _view_x1, view_height_get(), 1.75, 0);
draw_sprite_parallax_x(spr_background_hippie_clouds,, _view_x1, view_height_get() - 32, 1.5, -_scroll_delta * 3);
draw_sprite_parallax_x(spr_background_hippie_clouds,, _view_x1, view_height_get(), 1, -_scroll_delta * 5);