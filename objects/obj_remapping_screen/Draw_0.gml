/// @description 

var _i, _j;
var _source = undefined;
var _frame = 0;
var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _view_width = view_width_get();
var _view_height = view_height_get();
var _x = _view_x1 + (_screen_width / 2);
var _y = _view_y1 + (_screen_height / 2) + (_screen_height * (2 * lerp(y_offset_previous, y_offset, frame_delta_game_get())));
var _color_cyan_light = make_color_rgb(191, 254, 255);
var _color_cyan_dark = make_color_rgb(0, 107, 191);
var _binding, _icon;

var _option, _option_list, _option_list_height;
var _option_first, _option_y_offset;
var _option_count;

if (!surface_exists(global.surface_HUD))
	exit;
	
surface_set_target(global.surface_HUD);

if (input_player_connected(player_number))
{
	_source = input_source_get_array(player_number);
	_source = _source[0];
}

if (global.animate > 4)
	_frame = 1;

draw_set_font(global.font_16);

draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);
draw_sprite_stretched(spr_menu, 0, _x - 304, _y - 148, 608, 296);

draw_set_color(c_white);
draw_set_font(global.font_16);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(_x, _y - 136, "Controls - Player " + string(player_number + 1));

switch (page)
{
	case menu_remapping_screen_pages.main:
		_option_list = options[menu_remapping_screen_pages.main];
		_option_list_height = array_length(_option_list);
		
		if (_option_list_height > options_max_on_screen)
		{
			_option_first = clamp(option - floor(options_max_on_screen / 2), 0, _option_list_height - options_max_on_screen);
			_option_list_height = options_max_on_screen;
		}
		else
			_option_first = 0;

		draw_set_color(c_white);
		draw_set_font(global.font_12);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		
		if (input_source_using(INPUT_KEYBOARD, player_number))
		{
			draw_set_color(c_white);
			draw_text(_x, _y - 116, "Keyboard/Mouse");
		}
		else
		{
			draw_set_color(_color_cyan_dark);
			draw_rectangle(_x - 96, _y - 96, _x + 96, _y + 96, false);
			draw_set_color(c_gray);
			draw_text(_x, _y - 116, "Keyboard/Mouse");
		}
		if (input_source_using(INPUT_GAMEPAD, player_number))
		{
			draw_set_color(c_white);
			draw_text(_x + 192, _y - 116, "Gamepad");
		}
		else
		{
			draw_set_color(_color_cyan_dark);
			draw_rectangle(_x + 96, _y - 96, _x + 288, _y + 96, false);
			draw_set_color(c_gray);
			draw_text(_x + 192, _y - 116, "Gamepad");
		}
		
		draw_sprite_ext(spr_menu_arrow_16, _frame, _x - 190, _y - 116, 1, 1, 90, c_white, 1);
		draw_sprite_ext(spr_menu_arrow_16, _frame, _x - 190, _y + 116, 1, 1, 270, c_white, 1);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_center);
		draw_set_color(c_white);
		_option_count = _option_first;
		for (_i = 0; _i < _option_list_height; ++_i)
		{
			_option = options[menu_remapping_screen_pages.main][_option_count];
			_option_y_offset = -((_option_list_height / 2) * 20) + (20 * _i) + 10;
			
			if (_option_count == option)
			{
				draw_set_color(_color_cyan_light);
				draw_rectangle(_x - 288, _y + _option_y_offset - 10, _x + 288, _y + _option_y_offset + 10, false);
				draw_set_color(c_white);
				draw_sprite_ext(spr_menu_arrow_16, _frame, _x - 288, _y + _option_y_offset, 1, 1, 0, c_white, 1);
			}
				
			draw_text(_x - 272, _y + _option_y_offset, string(_option[menu_option_data.text]));
			
			if (_option_count < array_length(verb_list))
			{
				for (_j = 0; _j < INPUT_MAX_ALTERNATE_BINDINGS; ++_j)
				{
					_binding = input_binding_get(verb_list[_option_count][1], player_number, _j, "keyboard_and_mouse");
					_icon = input_binding_get_icon(_binding, player_number);
					if (_icon == spr_control_icon_empty)
						break;
				
					if (is_string(_icon))
						draw_text(_x - 80 + (_j * 18), _y + _option_y_offset, _icon);
					else
						draw_sprite(_icon, _frame, _x - 80 + (_j * 18), _y + _option_y_offset);
				}
				
				for (_j = 0; _j < INPUT_MAX_ALTERNATE_BINDINGS; ++_j)
				{
					_binding = input_binding_get(verb_list[_option_count][1], player_number, _j, "gamepad");
					_icon = input_binding_get_icon(_binding, player_number);
					if (_icon == spr_control_icon_empty)
						break;
				
					if (is_string(_icon))
						draw_text(_x + 112 + (_j * 18), _y + _option_y_offset, _icon);
					else
						draw_sprite(_icon, _frame, _x + 112 + (_j * 18), _y + _option_y_offset);
				}
			}
				
			_option_count++;
		}
		
		draw_set_color(c_orange);
		draw_line_width(_x - 96, _y - 96, _x - 96, _y + 96, 2);
		draw_line_width(_x + 96, _y - 96, _x + 96, _y + 96, 2);
		
		draw_set_color(c_white);
		break;
	case menu_remapping_screen_pages.remap:
		draw_set_color(c_white);
		draw_set_font(global.font_16);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		if (verb_index < array_length(verb_list))
			draw_text(_x, _y - 96, string(verb_list[verb_index][0]));
			
		switch (_source)
		{
			case INPUT_KEYBOARD:
				draw_text(_x, _y, "Press any key to map it to this action");
				break;
			case INPUT_GAMEPAD:
				draw_text(_x, _y, "Press any button to map it to this action");
				break;
			default:
				break;
		}
		break;
	default:
		break;
}
draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);
surface_reset_target();