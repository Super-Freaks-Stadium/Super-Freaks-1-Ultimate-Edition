/// @description 

var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _view_width = view_width_get();
var _view_height = view_height_get();
var _screen_width_half = _screen_width / 2;
var _screen_height_half = _screen_height / 2;
var _text = text;
var _dialog_width, _dialog_height;
var _circle_size = lerp(circle_size_previous, circle_size, global.delta);

if (!surface_exists(global.surface_HUD))
	exit;
	
surface_set_target(global.surface_HUD);

draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);

draw_set_color(color);
draw_rectangle(_view_x1, _view_y1, _view_x1 + _screen_width, _view_y1 + _screen_height, false);

if (circle_size > 0)
{
	gpu_set_blendmode(bm_subtract);
	draw_set_color(c_white);
	draw_circle(_view_x1 + _screen_width_half, _view_y1 + _screen_height_half, _screen_width_half * _circle_size, false);
	gpu_set_blendmode(bm_normal);
}

draw_set_alpha(1);
draw_set_font(global.font_16);
if (dialog_size > 0)
{
	_dialog_width = (string_width_ext(_text, -1, 424) + 32) * dialog_size;
	_dialog_height = (string_height_ext(_text, -1, 424) + 32) * dialog_size;
	draw_sprite_stretched(spr_menu, 0, _view_x1 + _screen_width_half - (_dialog_width / 2), _view_y1 + _screen_height_half - (_dialog_height / 2), _dialog_width, _dialog_height);
}

if (state == 3)
{
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_ext(_view_x1 + _screen_width_half, _view_y1 + _screen_height_half, text, -1, 424);
}

if (button_prompt)
{
	draw_verb(0, "confirm", _view_x1 + _screen_width - 8, _view_y1 + _screen_height - 8);
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_text(_view_x1 + _screen_width - 16, _view_y1 + _screen_height - 8, "Claim Prize");
}
draw_set_alpha(1);
draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);
surface_reset_target();