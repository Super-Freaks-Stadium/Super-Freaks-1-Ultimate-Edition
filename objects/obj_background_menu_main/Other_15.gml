/// @description Draw Background

var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _static_menu_bg = motion_sickness_get();

draw_set_alpha(1);
draw_set_color(c_white);
if (_static_menu_bg == false)
{
	var _scroll_delta = lerp(scroll_previous, scroll, global.frame_delta);
	draw_sprite_tiled(spr_menu_main_background, 0, _scroll_delta, _scroll_delta);
}
else
{
	draw_sprite_tiled(spr_menu_main_background, 0, 0, 0);
}
draw_set_alpha(0.5);
draw_rectangle(_view_x1, _view_y1, view_x2_get(), view_y2_get(), false);