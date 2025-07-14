/// @description 

var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _view_width = view_width_get();
var _view_height = view_height_get();
var _x = _view_x1 + (_screen_width / 2);
var _y = _view_y1 + (_screen_height / 2);
var _dialog_width, _dialog_height;
var _animate = lerp(animation_previous, animation, global.delta);

if (!surface_exists(global.surface_HUD))
	exit;
	
surface_set_target(global.surface_HUD);

draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.font_12);
if (_animate > 0)
{
	_dialog_width = (string_width_ext(hint, -1, 320) + 32) * _animate;
	_dialog_height = (string_height_ext(hint, -1, 320) + 32) * _animate;
	draw_sprite_stretched(spr_textbox_uncle_swordsman, image_index, _x - (_dialog_width / 2), _y - (_dialog_height / 2), _dialog_width, _dialog_height);
}
	
if (_animate == 1)	
	draw_text_ext(_x, _y, hint, -1, 320);

draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);
surface_reset_target();