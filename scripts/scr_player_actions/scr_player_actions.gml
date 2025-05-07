/// @function player_pause_game
function player_pause_game()
{
	//if (!room_transition_active_get() && button_pause == controls_action_states.press)
	if (!room_transition_active_get() && input_check_pressed("start", player_number))
		game_pause(player_number);
		
	gml_pragma("forceinline");
}

/// @function player_drop_out
function player_drop_out()
{
	var _player_num;
	
	if (players_exist() && input_check_pressed("drop_out", player_number))
	{
		if (global.player_lead == player_number)
		{
			global.player_lead = undefined;
			for (_player_num = 0; _player_num < INPUT_MAX_PLAYERS; ++_player_num)
			{
				if (_player_num != player_number && global.player_list[_player_num][player_data.active] == true)
					global.player_lead = _player_num;
			}
		}
		input_source_clear(player_number);
		state_next_set(player_states.inactive, 999999999999);
		global.player_list[player_number][player_data.active] = false;
	}
	
	gml_pragma("forceinline");
}

/// @function player_drop_out_force
/// @param _player_number = 0
function player_drop_out_force(_player_number = 0)
{
	var _player_instance = global.player_list[_player_number][player_data.instance];
	var _player_num;
	var _player_instance_p1;
	var _other_players = false;
	var _player_next = undefined;
	
	input_source_clear(_player_number);
	
	for (_player_num = 0; _player_num < INPUT_MAX_PLAYERS; ++_player_num)
	{
		if (_player_num != _player_number && global.player_list[_player_num][player_data.active] == true)
		{
			_other_players = true;
			_player_next = _player_num;
			break;
		}
	}
	
	if (global.player_list[_player_number][player_data.active] == true)
	{
		if (_other_players)
		{
			with (_player_instance)
			{
				state_next_set(player_states.inactive, 999999999999);
				state_machine_step();
				EVENT_STEP;
			}
			global.player_list[_player_number][player_data.active] = false;
			
			if (global.player_lead == _player_number)
				global.player_lead = _player_next;
		}
		else
		{
			if (_player_number != 0)
			{
				_player_instance_p1 = global.player_list[0][player_data.instance];
				global.player_list[_player_number][player_data.instance] = _player_instance_p1;
				global.player_list[0][player_data.instance] = _player_instance;
				_player_instance.player_number = 0;
				_player_instance_p1.player_number = _player_number;
			
				global.player_list[0][player_data.active] = true;
				global.player_list[_player_number][player_data.active] = false;
			}
			global.player_lead = undefined;
		}
	}
	
	gml_pragma("forceinline");
}

/// @function player_enter_bubble
function player_enter_bubble()
{
	//if (players_exist() && button_bubble == controls_action_states.press)
	if (players_exist() && input_check_pressed("bubble", player_number))
		state_next_set(player_states.bubble, 999999999999);
	
	gml_pragma("forceinline");
}

/// @function player_rubberband_activate
function player_rubberband_activate()
{
	//if (button_rubberband == controls_action_states.press)
	if (input_check_pressed("rubberband", player_number))
	{
		sfx_play_global(sfx_elastiband);
		rubber_band = !rubber_band;
	}
	if (input_check_pressed("rubberband_color", player_number))
	{
		sfx_play_global(sfx_elastiband);
		rubber_band_color = !rubber_band_color;
	}
	
	gml_pragma("forceinline");
}

/// @function player_ego_meter
function player_ego_meter()
{
	var _x1, _y1, _x2, _y2;
    var _turbo = (0.05 * global.turbo.mode);
	
	if (global.story_mode != story_modes.kranion)
		exit;
		
	if (ego_invincible > 0)
	{
		if (ego_refill_pause == 0)
		{
			ego_invincible = max(ego_invincible - 0.25 - _turbo, 0);
			if (ego_invincible == 0)
				hp = 80;
		}
		_x1 = x - sprite_get_xoffset(sprite_index);
		_y1 = y - sprite_get_yoffset(sprite_index);
		_x2 = random(sprite_width);
		_y2 = random(sprite_height);
		instance_create_layer(_x1 + _x2, _y1 + _y2, "layer_instances", obj_invincibility_stars);
	}
	else
	{
		if (ego_refill_pause == 0)
		{
			if (hp > 25)
				hp = max(hp - 0.125 - _turbo, 25);
			else
				hp = min(hp + 0.1, 25);
		}
	}
	
	ego_refill_pause = max(ego_refill_pause - 1, 0);
}

/// @function player_meter_collect
/// @param {Real} _ego = 2
function player_meter_collect(_ego = 2)
{
	var _aura_previous;
	with (obj_player)
	{
		switch (state)
		{
			case player_states.inactive:
			case player_states.NA:
			case player_states.debug:
			case player_states.death:
			case player_states.death_fall:
			case player_states.bubble:
				continue;
				break;
			default:
				break;
		}
		
		switch (global.story_mode)
		{
			case story_modes.kranion:
				ego_refill_pause = 16;
		
				if (ego_invincible > 0)
					ego_invincible = min(ego_invincible + _ego, 100);
				else
				{
					hp = min(hp + _ego, 100);
					if (hp == 100)
					{
						ego_invincible = 100;
						sfx_play_global(sfx_powerup);
					}
				}
				break;
			case story_modes.swordsman:
				if (aura < 100)
				{
					_aura_previous = aura;
					aura = min(aura + _ego, 100);
					if (aura == 100)
						sfx_play_global(sfx_powerup);
					else if (aura >= AURA_INVINCIBLE && _aura_previous < AURA_INVINCIBLE)
						sfx_play_global(sfx_powerup);
				}
				break;
			case story_modes.anti_freaks:
				if (aura < 100)
				{
					_aura_previous = aura;
					aura = min(aura + _ego, 100);
					if (aura == 100)
						sfx_play_global(sfx_powerup);
				}
				break;
		}
	}
}

/// @function player_hurt
function player_hurt()
{
	var _last_hit = false;
	
	if (room_transition_active_get())
		exit;
	
	if (ego_invincible == 0 && hurt_timer == 0 && state != player_states.hurt && state != player_states.bubble)
	{
		switch (global.story_mode)
		{
			case story_modes.super_freaks:
				if (global.hearts == 0)
					_last_hit = true;
				global.hearts = max(global.hearts - 1, 0);
				break;
			case story_modes.kranion:
				if (hp < 25)
					_last_hit = true;
				hp = max(hp - 25, 0);
				break;
			case story_modes.swordsman:
				if (aura < AURA_INVINCIBLE)
					_last_hit = true;
				else
					aura = 0;
				break;
			case story_modes.anti_freaks:
				if (aura < ANTI_FREAK_WEAK)
					_last_hit = true;
				else
					aura = 0;
				break;
		}
		hurt_timer_set(120);
        sprint = 0;
		ego_refill_pause = 32;
        
        if (global.turbo.mode)
        {
            _last_hit = false;
            turbo_time_hit();
        }
        
		if (!_last_hit)
		{
			if (underwater || jetpack)
			{
				speed_h = 1 * -face;
				speed_v = -4;
				sfx_play_global(sfx_hurt);
			}
			else
			{
				if (state != player_states.hang)
					state_next_set(player_states.hurt);
				else
					sfx_play_global(sfx_hurt);
			}
		}
		else
            state_next_set(player_states.death, 999);
	}
	
	gml_pragma("forceinline");
}

/// @function player_kill
function player_kill()
{
	if (hurt_timer == 0 && state != player_states.inactive && state != player_states.hurt && state != player_states.bubble)
	{
		switch (global.story_mode)
		{
			case story_modes.super_freaks:
				if (global.hearts > 0)
					global.hearts = max(global.hearts - 1, 0);
				break;
			case story_modes.kranion:
				ego_invincible = 0;
				if (hp > 0)
					hp = 0;
				break;
			case story_modes.swordsman:
			case story_modes.anti_freaks:
				aura = 0;
				break;
		}
		state_next_set(player_states.death, 999);
	}
	
	gml_pragma("forceinline");
}

/// @function player_crush
function player_crush()
{
	var _crush_left = bit_get(crush_flags, collision_flag_bits.left);
	var _crush_up = bit_get(crush_flags, collision_flag_bits.up);
	var _crush_right = bit_get(crush_flags, collision_flag_bits.right);
	var _crush_down = bit_get(crush_flags, collision_flag_bits.down);
	
	if (_crush_left && _crush_right) || (_crush_up && _crush_down)
	{
		state_next_set(player_states.death, 9999999);
		sfx_play_global(sfx_hurt);
		switch (global.story_mode)
		{
			case story_modes.super_freaks:
				global.hearts = max(global.hearts - 1, 0);
				break;
			case story_modes.kranion:
				hp = 0;
				ego_invincible = 0;
				break;
			case story_modes.swordsman:
			case story_modes.anti_freaks:
				aura = 0;
				break;
		}
	}
}

/// @function player_fall
function player_fall()
{
	if (y > view_y2_get() + 64)
		state_next_set(player_states.death_fall, 99999);
		
	gml_pragma("forceinline");
}

/// @function player_water_step
function player_water_step()
{
	var _last_hit = false;
	
	switch (global.story_mode)
	{
		case story_modes.super_freaks:
			if (global.hearts == 0)
				_last_hit = true;
			break;
		case story_modes.kranion:
			if (hp == 0)
				_last_hit = true;
			break;
		case story_modes.swordsman:
			if (aura == 0)
				_last_hit = true;
			break;
	}
	
	if (global.water_active == false)
		exit;
		
	switch (global.water_type)
	{
		case water_types.water:
			if (room_transition_active_get())
				exit;
			if (underwater)
			{
				water_meter = max(water_meter - 0.18, 0);
		
				x += global.water_current;
				if ((global.water_electric_timer > 0 || water_meter == 0) && ego_invincible == 0)
					player_hurt();
			}
			break;
		case water_types.lava:
		case water_types.lemonade:
			if (y + collider_detector_down[collider_detector_vertical_data.y] > global.water_height)
			{
				if (room_transition_active_get())
					exit;
				speed_v = -10;
                sprint = 0;
				if (!ground_on)
					speed_h = 0;
				if (hurt_timer == 0 && ego_invincible == 0)
				{
                    if (global.turbo.mode)
                    {
                        _last_hit = false;
                        turbo_time_hit();
                    }
					if (!_last_hit)
					{
						switch (global.story_mode)
						{
							case story_modes.super_freaks:
								global.hearts = max(global.hearts - 1, 0);
								break;
							case story_modes.kranion:
								hp = max(hp - 15, 0);
								break;
							case story_modes.swordsman:
								aura = 0;
								break;
						}
						sfx_play_global(sfx_hurt);
						hurt_timer_set(120);
						state_next_set(player_states.normal, 999);
					}
					else
						state_next_set(player_states.death, 999);
				}
				else
					state_next_set(player_states.normal, 999);
			}
			break;
	}
}