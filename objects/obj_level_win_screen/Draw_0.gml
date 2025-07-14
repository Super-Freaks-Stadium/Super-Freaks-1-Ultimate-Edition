/// @description 

var _i;

var _animate = lerp(animate_previous, animate, global.delta);

var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _view_width = view_width_get();
var _view_height = view_height_get();
var _screen_width_half = _screen_width / 2;
var _screen_height_half = _screen_height / 2;
var _screen_width_fourth = _screen_width / 4;
var _name_level = level_name_get();
var _name_world = level_name_world_get();

var _rec_A_y1 = (_animate * _screen_height) - _screen_height;
var _rec_A_y2 = _rec_A_y1 + _screen_height;

var _rec_B_y1 = _screen_height - (_animate * _screen_height);
var _rec_B_y2 = _rec_B_y1 + _screen_height;

var _trophy_separate = 72;
var _trophy_rec_width = (global.trophies_max - 1) * _trophy_separate;
var _trophy_rec_x1 = (_screen_width - (_screen_width_half * _animate)) - (_trophy_rec_width * 0.5);

if (!surface_exists(global.surface_HUD))
	exit;
	
surface_set_target(global.surface_HUD);

draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);
draw_set_alpha(1);

draw_set_color(c_yellow);
draw_rectangle(_view_x1 + _screen_width_fourth * 0, _view_y1 +_rec_A_y1, _view_x1 + (_screen_width_fourth * 1), _view_y1 + _rec_A_y2, false);
draw_rectangle(_view_x1 + _screen_width_fourth * 1, _view_y1 +_rec_B_y1, _view_x1 + (_screen_width_fourth * 2), _view_y1 + _rec_B_y2, false);
draw_rectangle(_view_x1 + _screen_width_fourth * 2, _view_y1 +_rec_A_y1, _view_x1 + (_screen_width_fourth * 3), _view_y1 + _rec_A_y2, false);
draw_rectangle(_view_x1 + _screen_width_fourth * 3, _view_y1 +_rec_B_y1, _view_x1 + (_screen_width_fourth * 4), _view_y1 + _rec_B_y2, false);

draw_set_color(c_white);
draw_set_font(global.font_title);

switch (global.game_mode)
{
	case game_modes.speedrun:
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_text(_view_x1 + (_screen_width_half * _animate), _view_y1, "SPEEDRUN COMPLETE");
		
		draw_set_valign(fa_middle);
		game_timer_draw(_view_x1 + _screen_width - (_screen_width_half * _animate), _view_y1 + _screen_height_half);
		
		draw_set_valign(fa_bottom);
        draw_set_font(global.font_16);
		draw_text_ext(_view_x1 + (_screen_width_half * _animate), _view_y1 + _screen_height, victory_quote, -1, _screen_width);
		break;
	case game_modes.boss_rush:
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_text(_view_x1 + (_screen_width_half * _animate), _view_y1, "BOSS RUSH COMPLETE");
		
		draw_set_valign(fa_middle);
		game_timer_draw(_view_x1 + _screen_width - (_screen_width_half * _animate), _view_y1 + _screen_height_half);
		
		draw_set_valign(fa_bottom);
        draw_set_font(global.font_16);
		draw_text_ext(_view_x1 + (_screen_width_half * _animate), _view_y1 + _screen_height, victory_quote, -1, _screen_width);
		break;
	default:
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_text(_view_x1 + (_screen_width_half * _animate), _view_y1, string_upper(_name_world) + "\n" + string_upper(_name_level) + "\n" + string_upper(clear_text));

		draw_set_valign(fa_bottom);
        draw_set_font(global.font_16);
		draw_text_ext(_view_x1 + (_screen_width_half * _animate), _view_y1 + _screen_height, victory_quote, -1, _screen_width);

		for (_i = 0; _i < global.trophies_max; ++_i)
		{
			if (_i < trophy_count)
			{
				if (bit_get(global.trophies, _i))
					draw_set_alpha(1);
				else
					draw_set_alpha(0.5);
		
				draw_sprite(spr_trophy, 0, _view_x1 + _trophy_rec_x1 + (_i * _trophy_separate), _view_y1 + _screen_height_half);
			}
		}
		draw_set_alpha(1);
		break;
}

draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);

surface_reset_target();
