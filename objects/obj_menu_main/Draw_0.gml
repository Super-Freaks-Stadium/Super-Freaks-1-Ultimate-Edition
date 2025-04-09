/// @description 

var _frame = 0;
var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _text_x, _text_y;
var _arrow = string("->");
var _option_num;
var _option_current;
var _option_text;
var _font_width, _font_height;
var _unlocked;
var _binding, _icon;

var _index;
var _name_world, _name_level;

if (global.animate > 4)
	_frame = 1;

draw_set_font(global.font_16);
_font_width = sprite_get_width(spr_font_16);
_font_height = sprite_get_height(spr_font_16);

draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_verb(0, "confirm", _screen_width - 8, 12);
draw_text(_screen_width - 16, 12, "Confirm");
draw_verb(0, "deny", _screen_width - 8, 28);
draw_text(_screen_width - 16, 28, "Deny");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text(0, 0, string(main_text));
switch (page)
{
	case main_menu_pages.challenge_freeplay:
		_index = levels_get_all_completed()[global.level_demo];
		_name_world = level_name_world_get(_index);
		_name_level = level_name_get(_index);
		
		draw_sprite(level_sprite_get(_index), 0, _screen_width / 2, _screen_height / 2);
		draw_sprite_ext(spr_menu_arrow_32, _frame, _screen_width / 2 - 96, _screen_height / 2, 1, 1, 180, c_white, 1);
		draw_sprite_ext(spr_menu_arrow_32, _frame, _screen_width / 2 + 96, _screen_height / 2, 1, 1, 0, c_white, 1);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_text(_screen_width / 2, _screen_height / 2 + 112, string(_name_world) + "\n" + string(_name_level));
		break;
	case main_menu_pages.museum_characters:
		_index = museum_items[museum_data.characters][character_card_index];
		
		draw_sprite(spr_museum_characters, _index, _screen_width / 2, _screen_height / 2 - 64);
		draw_sprite_ext(spr_menu_arrow_32, _frame, _screen_width / 2 - 96, _screen_height / 2 - 64, 1, 1, 180, c_white, 1);
		draw_sprite_ext(spr_menu_arrow_32, _frame, _screen_width / 2 + 96, _screen_height / 2 - 64, 1, 1, 0, c_white, 1);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_text_ext(_screen_width / 2, _screen_height, string(global.museum_stuff[museum_data.characters][_index][museum_character_data.name]) + "\n" + string(global.museum_stuff[museum_data.characters][_index][museum_character_data.bio]), -1, SCREEN_WIDTH_MIN);
		break;
	case main_menu_pages.museum_theater:
		_index = museum_items[museum_data.cutscenes][cutscene_index];
		
		draw_sprite(spr_museum_cutscenes, global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.image_index], _screen_width / 2, _screen_height / 2);
		draw_sprite_ext(spr_menu_arrow_32, _frame, _screen_width / 2 - 96, _screen_height / 2, 1, 1, 180, c_white, 1);
		draw_sprite_ext(spr_menu_arrow_32, _frame, _screen_width / 2 + 96, _screen_height / 2, 1, 1, 0, c_white, 1);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_text(_screen_width / 2, _screen_height / 2 + 112, string(global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.name]));
		break;
	default:
		_text_x = 24;
		_text_y = 24;
		
		_option_num = option;
		draw_sprite(spr_menu_arrow_16, _frame, 8, _text_y + (_option_num * _font_height) + 8);
	
		for (_option_num = 0; _option_num < array_length(options[page]); ++_option_num)
		{
			_option_current = options[page][_option_num];
			_option_text = _option_current[menu_option_data.text];
			_unlocked = options[page][_option_num][menu_option_data.unlocked];
		
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
			
			draw_text(_text_x, _text_y + (_option_num * _font_height), _option_text);
		}
		break;
}

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
//draw_set_font(font_normal);
draw_set_color(c_white);
draw_text_ext(0, _screen_height, string(bottom_text), -1, _screen_width - 80);
