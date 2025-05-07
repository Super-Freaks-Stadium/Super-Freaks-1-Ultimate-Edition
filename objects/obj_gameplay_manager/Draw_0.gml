/// @description 

var _list, _list_pos, _list_thing;
var _draw_x, _draw_y;
var _player_list = global.player_list, _player_instance, _player_meter;
var _bubble_index = 0;
var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_width = camera_get_view_width(view_camera[view_current]);
var _view_height = camera_get_view_height(view_camera[view_current]);
var _view_x1 = camera_get_view_x(view_camera[view_current]);
var _view_y1 = camera_get_view_y(view_camera[view_current]);
var _view_x2 = _view_x1 + _view_width;
var _view_y2 = _view_y1 + _view_height;
var _offset = 0;
var _binding, _icon;
var _mirror = mirror_flip_get();
var _zoom = global.view.z;
var _heart_zoom = 32;
var _heart_meter_zoom = _heart_zoom / 100;
var _show_heart = (global.story_mode == story_modes.super_freaks || global.turbo.mode);
var _turbo_meter_lerp = 32 / TURBO_TIME_MAX;

#region Draw Water
	water_draw();
#endregion

//if (surface_get_target() != -1 && surface_exists(surface_get_target()))
//	surface_reset_target();


#region Draw Player Numbers
	draw_set_color(c_white);
	draw_set_alpha(1);
	_list = global.player_list;
	for (_list_pos = 0; _list_pos < array_length(_list); ++_list_pos)
	{
		_list_thing = _list[_list_pos];
			
		if (_list_thing[player_data.active] == true)
		{
			_player_instance = _list_thing[player_data.instance];
			_draw_x = lerp(_player_instance.x_start_frame, _player_instance.x, frame_delta_player_get());
			_draw_y = lerp(_player_instance.y_start_frame, _player_instance.y, frame_delta_player_get());
			draw_sprite_ext(spr_player_numbers_arrows, _player_instance.player_number, _draw_x, _draw_y - (abs(_player_instance.hitbox.shape_y1 - _player_instance.hitbox.shape_y2) * _zoom), _mirror * _zoom, _zoom, 0, c_white, 1);
			if (_player_instance.state == player_states.bubble)
				draw_verb(_player_instance.player_number, "bubble", _draw_x, _draw_y - (72 * _zoom), _zoom * _mirror, _zoom);
			
			if (_player_instance.water_meter < 100 || _player_instance.underwater)
			{
				_bubble_index = 0;
				if (_player_instance.water_meter < 40 && global.animate >= 4)
					_bubble_index = 1;
				_player_meter = _player_instance.water_meter;
		        draw_sprite_ext(spr_HUD_water_meter, 2, _draw_x - (16 * _zoom) + (32 * _zoom * -_mirror), _draw_y - (64 * _zoom), _zoom, _zoom, 0, c_white, 1);
		        draw_sprite_general(spr_HUD_water_meter, _bubble_index, 0, 32 - (_player_meter * 0.32), 32, (_player_meter * 0.32), _draw_x - (16 * _zoom) + (32 * _zoom * -_mirror), _draw_y - (32 * _zoom) - (_player_meter * 0.32 * _zoom), _zoom, _zoom, 0, c_white, c_white, c_white, c_white, 1);
			}
			
			switch (global.story_mode)
			{
				case story_modes.kranion:
					_player_meter = _player_instance.hp;
			        draw_sprite_ext(spr_ego_meter, 0, _draw_x - (16 * _zoom) + (32 * _zoom * _mirror), _draw_y - (64 * _zoom), _zoom, _zoom, 0, c_white, 1);
			        draw_sprite_general(spr_ego_meter, 1, 0, 32 - (_player_meter * 0.32), 32, (_player_meter * 0.32), _draw_x - (16 * _zoom) + (32 * _zoom * _mirror), _draw_y - (32 * _zoom) - (_player_meter * 0.32 * _zoom), _zoom, _zoom, 0, c_white, c_white, c_white, c_white, 1);
				
					_player_meter = _player_instance.ego_invincible;
					draw_sprite_general(spr_ego_meter_full, global.animate, 0, 32 - (_player_meter * 0.32), 32, (_player_meter * 0.32), _draw_x - (16 * _zoom) + (32 * _zoom * _mirror), _draw_y - (32 * _zoom) - (_player_meter * 0.32 * _zoom), _zoom, _zoom, 0, c_white, c_white, c_white, c_white, 1);
					break;
				case story_modes.anti_freaks:
					_player_meter = _player_instance.aura;
			        draw_sprite_ext(spr_rage_meter, 0, _draw_x - (16 * _zoom) + (32 * _zoom * _mirror), _draw_y - (64 * _zoom), _zoom, _zoom, 0, c_white, 0.25 + (_player_meter >= ANTI_FREAK_WEAK));
			        draw_sprite_general(spr_rage_meter, 1, 0, 32 - (_player_meter * 0.32), 32, (_player_meter * 0.32), _draw_x - (16 * _zoom) + (32 * _zoom * _mirror), _draw_y - (32 * _zoom) - (_player_meter * 0.32 * _zoom), _zoom, _zoom, 0, c_white, c_white, c_white, c_white, 1);
				
					//_player_meter = _player_instance.ego_invincible;
					//draw_sprite_general(spr_rage_meter_full, global.animate, 0, 32 - (_player_meter * 0.32), 32, (_player_meter * 0.32), _draw_x - (16 * _zoom) + (32 * _zoom * _mirror), _draw_y - (32 * _zoom) - (_player_meter * 0.32 * _zoom), _zoom, _zoom, 0, c_white, c_white, c_white, c_white, 1);
					break;
				default:
					break;
			}
		}
	}
#endregion

#region Draw HUD
	if (!surface_exists(global.surface_HUD))
		exit;
	
	surface_set_target(global.surface_HUD);
	draw_set_alpha(1);
	
	switch (global.game_state)
	{
		case game_states.NA:
			break;
		case game_states.gameplay:
			draw_set_projection_2D(_view_x1, _view_y1, _screen_width, _screen_height);
			#region Draw Boss Health
				draw_set_font(global.font_16);
				with (obj_boss)
				{
					draw_set_color(c_white);
					draw_set_halign(fa_center);
					draw_set_valign(fa_bottom);
					draw_text(_view_x1 + _screen_width / 2, _view_y1 + 64, string(boss_name));
					draw_set_color(c_white);
					draw_rectangle(_view_x1 + _screen_width / 2 - 129, _view_y1 + 71, (_view_x1 + _screen_width / 2) + 129, _view_y1 + 74, false);
					draw_set_color(c_black);
					draw_rectangle(_view_x1 + _screen_width / 2 - 128, _view_y1 + 72, (_view_x1 + _screen_width / 2) + 128, _view_y1 + 73, false);
					draw_set_color(c_red);
					draw_rectangle(_view_x1 + _screen_width / 2 - 128, _view_y1 + 72, (_view_x1 + _screen_width / 2) - 128 + lerp(0, 256, (hp / hp_start)), _view_y1 + 73, false);
				}
			#endregion
			#region Draw Player Info
				draw_set_font(global.font_12);
				draw_set_halign(fa_left);
				draw_set_valign(fa_middle);
				draw_set_color(c_white);
				for (_list_pos = 0; _list_pos < array_length(_player_list); ++_list_pos)
				{
					_offset = (_list_pos * (_screen_width / 4));
					_list_thing = _player_list[_list_pos];
					_player_instance = _list_thing[player_data.instance];
					draw_sprite(spr_player_numbers, _list_pos, _view_x1 + 16 + _offset, _view_y1 + 16);
				
					if (_list_thing[player_data.active] == true)
					{
						var HUDDoDead = (_player_instance.state == player_states.death || _player_instance.state == player_states.bubble);
						
						draw_sprite(player_animation_get(_player_instance.character_index, player_animations.hud_face), HUDDoDead, _view_x1 + 48 + _offset, _view_y1 + 16);
						if (_list_pos == global.player_lead)
							draw_sprite(spr_multiplayer_crown, 0, _view_x1 + 48 + _offset, _view_y1 + 40);
						if (_player_instance.rubber_band == true)
							draw_sprite_ext(spr_HUD_elastiband, _player_instance.rubber_band_color, _view_x1 + 80 + _offset, _view_y1 + 16, 1, 1, 0, c_white, 1);
						else
							draw_sprite_ext(spr_HUD_elastiband, _player_instance.rubber_band_color, _view_x1 + 80 + _offset, _view_y1 + 16, 1, 1, 0, c_white, 0.5);
					}
					else
					{
						if (_player_instance.state == player_states.drop_in)
						{
							draw_sprite_ext(spr_menu_arrow_16, 0, _view_x1 + 48 + _offset, _view_y1 + 16, 1, 1, 180, c_white, 1);
							draw_sprite_ext(spr_menu_arrow_16, 0, _view_x1 + 112 + _offset, _view_y1 + 16, 1, 1, 0, c_white, 1);
							draw_sprite(player_animation_get(_player_instance.character_index, player_animations.hud_face), 0, _view_x1 + 80 + _offset, _view_y1 + 16);
						}
						else
						{
							draw_text(_view_x1 + 48 + _offset, _view_y1 + 16, "Join!");
						}
					}
				}
			#endregion
			#region Draw Hearts
				if (_show_heart)
				{
                    if (global.turbo.mode)
                    { 
                        draw_set_font(global.font_12); 
                        draw_set_halign(fa_center);
    					draw_set_valign(fa_middle); 
                        draw_sprite(spr_HUD_clock, 0, _view_x1, _view_y1 + _screen_height - 32 + yorb_effect); 
                        draw_sprite_part(spr_HUD_clock, 1, 0, 32 - (global.turbo.time_visual * _turbo_meter_lerp), 32, (global.turbo.time_visual * _turbo_meter_lerp), _view_x1, _view_y1 + _screen_height - (global.turbo.time_visual * _turbo_meter_lerp) + yorb_effect); 
                        draw_text(_view_x1 + 16, _view_y1 + _screen_height - 16 + yorb_effect, floor(global.turbo.time_visual));
                    }
                    else
                    {
    					if (hearts_maximum_get() > 0)
    					{
    						draw_set_font(global.font_12);
    						draw_set_halign(fa_center);
    						draw_set_valign(fa_middle);
    					    draw_sprite(spr_HUD_heart, 0, _view_x1, _view_y1 + _screen_height - 32 + yorb_effect);
    					    draw_sprite_part(spr_HUD_heart, 1, 0, 32 - (global.heart_meter * 0.32), 32, (global.heart_meter * 0.32), _view_x1, _view_y1 + _screen_height - (global.heart_meter * 0.32) + yorb_effect);
    						draw_text(_view_x1 + 16, _view_y1 + _screen_height - 16 + yorb_effect, string(global.hearts));
    					}
                    }
				}
			#endregion
			#region Draw Trophies
				switch (global.game_mode)
				{
					case game_modes.randomizer:
					case game_modes.speedrun:
						break;
					default:
						for (_list_pos = 0; _list_pos < global.trophies_max; ++_list_pos)
						{
							draw_sprite(spr_HUD_trophy, bit_get(global.trophies, _list_pos), _view_x1 - lerp(trophy_offset_previous, trophy_offset, frame_delta_game_get()), _view_y1 + _screen_height - 48 - (global.trophies_max * 32) + (_list_pos * 32));
						}
						break;
				}
			#endregion
			#region Draw Score/Game Timer
				draw_set_halign(fa_left);
				draw_set_valign(fa_bottom);
				draw_set_font(global.font_12);
				switch (global.game_mode)
				{
					case game_modes.randomizer:
						draw_text(_view_x1 + (48 * _show_heart), _view_y1 + _screen_height, "Level " + string(global.score));
						break;
					default:
						game_timer_draw(_view_x1 + (48 * _show_heart), _view_y1 + _screen_height);
				}
			#endregion
			draw_set_projection_2D(_view_x1, _view_y1, _view_width, _view_height);
			break;
	}
#endregion

surface_reset_target();