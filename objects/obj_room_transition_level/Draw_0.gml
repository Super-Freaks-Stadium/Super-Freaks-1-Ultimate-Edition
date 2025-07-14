/// @description 

var _animate = lerp(animate_previous, animate, global.delta);

var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _view_width = view_width_get();
var _view_height = view_height_get();
var _screen_width_half = _screen_width / 2;
var _screen_width_fourth = _screen_width / 4;
var _name_level = level_name_get();
var _name_world = level_name_world_get();

var _rec_A_y1 = (_animate * _screen_height) - _screen_height;
var _rec_A_y2 = _rec_A_y1 + _screen_height;

var _rec_B_y1 = _screen_height - (_animate * _screen_height);
var _rec_B_y2 = _rec_B_y1 + _screen_height;

if (!surface_exists(global.surface_HUD))
	exit;
	
surface_set_target(global.surface_HUD);

draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);
draw_set_alpha(1);

draw_set_color(c_red);
draw_rectangle(_view_x1 + _screen_width_fourth * 0, _view_y1 +_rec_A_y1, _view_x1 + (_screen_width_fourth * 1), _view_y1 + _rec_A_y2, false);
draw_set_color(c_lime);
draw_rectangle(_view_x1 + _screen_width_fourth * 1, _view_y1 +_rec_B_y1, _view_x1 + (_screen_width_fourth * 2), _view_y1 + _rec_B_y2, false);
draw_set_color(#008AFF);
draw_rectangle(_view_x1 + _screen_width_fourth * 2, _view_y1 +_rec_A_y1, _view_x1 + (_screen_width_fourth * 3), _view_y1 + _rec_A_y2, false);
draw_set_color(c_yellow);
draw_rectangle(_view_x1 + _screen_width_fourth * 3, _view_y1 +_rec_B_y1, _view_x1 + (_screen_width_fourth * 4), _view_y1 + _rec_B_y2, false);

draw_set_color(c_white);
draw_set_font(global.font_title);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_view_x1 + (_screen_width_half * _animate), _view_y1 + _screen_height * 0.5, string_upper(_name_world) + "\n" + string_upper(_name_level));
draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);

surface_reset_target();