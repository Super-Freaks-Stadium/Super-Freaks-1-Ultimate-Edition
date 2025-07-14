/// @description Draw Background

var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _scroll = lerp(scroll_previous, scroll, global.delta);

draw_set_color(make_colour_rgb(24, 0, 35));
draw_rectangle(0, 0, surface_get_width(surface), surface_get_height(surface), false);
draw_set_color(c_white);
draw_sprite_parallax(spr_encore_background, index, _view_x1 + _scroll, _view_y1, 3, 1,,,, 256);
draw_sprite_parallax(spr_encore_background_2, index, _view_x1 - _scroll, _view_y1 + 256, 3, 1,,,, 256);