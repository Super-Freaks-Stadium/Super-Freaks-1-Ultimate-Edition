/// @description 

var _i;

var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _view_width = view_width_get();
var _view_height = view_height_get();
var _x = _view_x1 + (_screen_width / 2);
var _y = _view_y1 + (_screen_height / 2);

var _option, _option_count = 0;
var _arrow_x, _arrow_y;
var _text = "";
var _font_size;
var _animate = lerp(animation_previous, animation, global.delta);
var _unlocked;
var _text_y, _text_width = 0, _text_height = 0;

var _window_width, _window_height;

if (!surface_exists(global.surface_HUD))
	exit;
	
surface_set_target(global.surface_HUD);

draw_set_font(global.font_16);
_font_size = sprite_get_height(spr_font_16);
_option_count = array_length(options[page]);
for (_i = 0; _i < _option_count; ++_i)
{
	_text = options[page][_i][menu_option_data.text];
	_text_width = max(_text_width, string_width(_text));
	_text_height += _font_size;
}

_text_y = _y - (_text_height / 2);
_window_width = _text_width + 64;
_window_height = _text_height + 32;

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);
draw_sprite_stretched(spr_menu, 0, _x - (_window_width / 2 * _animate), _y - (_window_height / 2 * _animate), _window_width * _animate, _window_height * _animate);
	
draw_set_halign(fa_center);
	
if (_animate == 1)
{
	draw_set_valign(fa_bottom);
	draw_text(_x, _y - (_window_height / 2), "PLAYER " + string(player_number + 1));
	draw_sprite(spr_pause, 0, _x, _y - (_window_height / 2) - _font_size);
	
	draw_set_valign(fa_top);
			
	for (_i = 0; _i < _option_count; ++_i)
	{
		_option = options[page][_i];
		_unlocked = options[page][_i][menu_option_data.unlocked];
		
		if (_unlocked)
		{
			if (draw_get_color() != c_white)
				draw_set_color(c_white);
		}
		else
		{
			if (draw_get_color() != c_black)
				draw_set_color(c_black);
		}
		
		_text = options[page][_i][menu_option_data.text];
		draw_text(_x, _text_y + (_i * _font_size), _text);
	}
	
	_arrow_x = (_text_width + 32) / 2;
	_arrow_y = _text_y + (_font_size * option) + 8;
	draw_sprite_ext(spr_menu_arrow_16, 0, _x - _arrow_x, _arrow_y, 1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_menu_arrow_16, 0, _x + _arrow_x, _arrow_y, 1, 1, 180, c_white, 1);
}
draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);
surface_reset_target();