/// @description 

var _frame_delta = global.delta;
var _x = lerp(x_start_frame, x, _frame_delta);
var _y = lerp(y_start_frame, y, _frame_delta);
var _height = collider_detector_down[collider_detector_vertical_data.y];
var _aura_sprite;

var _average_x, _average_y, _average_x_previous, _average_y_previous;
var _rubber_band_distance, _rubber_band_direction, _rubber_band_draw = true;
_average_x = global.player_rubberband_average[rubber_band_color][0];
_average_y = global.player_rubberband_average[rubber_band_color][1];
_average_x_previous = global.player_rubberband_average_previous[rubber_band_color][0];
_average_y_previous = global.player_rubberband_average_previous[rubber_band_color][1];

switch (state)
{
	case player_states.normal:
		if (physics == player_physics_modifiers.rail && ground_on)
		{
			draw_sprite_ext(sprite_index, image_index, _x + lengthdir_x(_height, angle_ground + 90), _y + _height + lengthdir_y(_height, angle_ground + 90), 1, 1, angle_ground, c_white, 1);
		}
		else
		{
			if (jetpack)
				draw_sprite_ext(spr_jetpack, jetpack_index, _x - (18 * face), _y, 1, 1, 0, c_white, 1);
			draw_sprite_ext(sprite_index, image_index, _x, _y, face, 1, 0, c_white, 1);
		}
		break;
	case player_states.bubble:
		draw_sprite_ext(sprite_index, image_index, _x, _y, face, 1, 0, c_white, 1);
		//var bubbleXScale = min(1, sprite_get_width(spr_player_bubble) div sprite_get_width(sprite_index)) + (sprite_get_width(sprite_index) > 64);
		//	  bubbleYScale = min(1, sprite_get_height(spr_player_bubble) div sprite_get_height(sprite_index)) + (sprite_get_height(sprite_index) > 64);
		draw_sprite_ext(spr_player_bubble, image_index, _x, _y, 1, 1, 0, c_white, 0.5);
		_rubber_band_draw = false;
		break;
	case player_states.death:
	case player_states.death_fall:
		draw_sprite_ext(sprite_index, image_index, _x, _y, face, 1, 0, c_white, 1);
		_rubber_band_draw = false;
		break;
	case player_states.hang:
		draw_sprite_ext(sprite_index, image_index, _x, _y, face, 1, 0, c_white, 1);
		if (input_check("down", player_number) && !game_pause_get())
			draw_sprite_ext(spr_menu_arrow_32, 0, _x, _y + 48, 1, 1, 270, c_white, 0.5);
		break;
	default:
		if (jetpack)
			draw_sprite_ext(spr_jetpack, jetpack_index, _x - (24 * face), _y, 1, 1, 0, c_white, 1);
		draw_sprite_ext(sprite_index, image_index, _x, _y, face, 1, 0, c_white, 1);
		break;
}

if (global.story_mode == story_modes.swordsman)
{
	if (aura > 0)
	{
		if (aura >= 100)
		{
			_aura_sprite = spr_aura_3;
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(_aura_sprite, jetpack_index, _x, _y + _height, 0.5 + ((aura / 100) / 2), 0.5 + ((aura / 100) / 2), 0, c_white, 0.5);
			gpu_set_blendmode(bm_normal);
		}
		else if (aura >= AURA_INVINCIBLE)
		{
			_aura_sprite = spr_aura_2;
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(_aura_sprite, jetpack_index, _x, _y + _height, 0.5 + ((aura / 100) / 2), 0.5 + ((aura / 100) / 2), 0, c_white, 0.5);
			gpu_set_blendmode(bm_normal);
		}
		else
		{
			_aura_sprite = spr_aura_1;
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(_aura_sprite, jetpack_index, _x, _y + _height, 1, 1, 0, c_white, 0.5);
			gpu_set_blendmode(bm_normal);
		}
	}
}

if (_rubber_band_draw == true && rubber_band && !is_undefined(_average_x) && !is_undefined(_average_x_previous))
{
	_average_x = lerp(_average_x_previous, _average_x, global.delta);
	_average_y = lerp(_average_y_previous, _average_y, global.delta);
	_rubber_band_distance = point_distance(x, y, _average_x, _average_y);
	_rubber_band_direction = point_direction(x, y, _average_x, _average_y);
	draw_sprite_ext(spr_elastiband, rubber_band_color, x, y, _rubber_band_distance / 32, clamp(32 / _rubber_band_distance, 0.5, 1), _rubber_band_direction, c_white, 1);
}