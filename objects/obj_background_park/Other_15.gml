/// @description Draw Background

var _view_x1 = view_x1_get();
var _view_height = view_height_get();
var _scroll_delta = lerp(scroll_previous, scroll, global.delta);
var _triangle_x1, _triangle_y1, _triangle_x2, _triangle_y2, _triangle_x3, _triangle_y3, _length, _width, _angle;
    _length = 800;
    _width = 8;

draw_set_color(make_colour_rgb(24, 0, 35));
draw_rectangle(0, 0, surface_get_width(surface), surface_get_height(surface), false);

draw_set_color(c_white);
draw_sprite_tiled(spr_background_park_stars, index, (_view_x1 / 1.5) - _view_x1 + _scroll_delta, _view_height);

draw_set_color(c_purple);
draw_set_alpha(light_alpha);

_angle = lengthdir_x(22.5, rotate_left) + 90;
_triangle_x1 = 128;
_triangle_y1 = _view_height;
_triangle_x2 = _triangle_x1 + lengthdir_x(_length, _angle - _width);
_triangle_y2 = _triangle_y1 + lengthdir_y(_length, _angle - _width);
_triangle_x3 = _triangle_x1 + lengthdir_x(_length, _angle + _width);
_triangle_y3 = _triangle_y1 + lengthdir_y(_length, _angle + _width);
draw_triangle(_triangle_x1, _triangle_y1, _triangle_x2, _triangle_y2, _triangle_x3, _triangle_y3, false);

_angle = lengthdir_x(-22.5, rotate_right) + 90;
_triangle_x1 = surface_get_width(surface) - 128;
_triangle_y1 = _view_height;
_triangle_x2 = _triangle_x1 + lengthdir_x(_length, _angle - _width);
_triangle_y2 = _triangle_y1 + lengthdir_y(_length, _angle - _width);
_triangle_x3 = _triangle_x1 + lengthdir_x(_length, _angle + _width);
_triangle_y3 = _triangle_y1 + lengthdir_y(_length, _angle + _width);
draw_triangle(_triangle_x1, _triangle_y1, _triangle_x2, _triangle_y2, _triangle_x3, _triangle_y3, false);

draw_set_alpha(1);
draw_set_color(c_white);

draw_sprite_parallax_x(spr_background_park_roller_coaster, index, _view_x1, _view_height, 2);