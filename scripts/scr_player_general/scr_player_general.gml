enum player_numbers
{
	player_1 = 0,
	player_2 = 1,
	player_3 = 2,
	player_4 = 3,
	
	count = 3,
}

enum player_data
{
	instance = 0,
	active,
	character_index,
}

enum player_states
{
	NA = 0,
	inactive,
	debug, 
	drop_in,
	normal,
	hurt,
	death,
	death_fall,
	bubble,
	level_start,
	level_win,
	door_enter,
	door_exit,
	wall_slide,
	hang,
	climb,
	pole_climb,
	pole_turn,
}

/// @function players_init
function players_init()
{
	var _player_number;
	
	global.player_lead = undefined;
	global.player_list = [];
	global.player_rubberband_average = [[0, 0], [0, 0]];
	global.player_rubberband_average_previous = [[0, 0], [0, 0]];
	characters_init();
		
	for (_player_number = 0; _player_number <= player_numbers.count; ++_player_number)
	{
		global.player_list[_player_number][player_data.instance] = undefined;
		global.player_list[_player_number][player_data.active] = false;
		global.player_list[_player_number][player_data.character_index] = 0;
	}
		
	//global.player_list[0][player_data.active] = true;
}

/// @function players_start
/// @param _x = 0
/// @param _y = 0
function players_start(_x, _y)
{
	var _list = global.player_list;
	var _player_instance;
	var _player_number;
	
	for (_player_number = 0; _player_number <= player_numbers.count; ++_player_number)
	{
		_player_instance = _list[_player_number][player_data.instance];
		
		if (is_undefined(_player_instance))
		{
			_player_instance = instance_create(obj_player, _x, _y);
			_player_instance.player_number = _player_number;
			_player_instance.character_index = _list[_player_number][player_data.character_index];
			
			_list[_player_number][player_data.instance] = _player_instance;
			with (_player_instance)
			{
				if (_list[_player_number][player_data.active] == true)
					state_next_set(player_states.normal);
				else
					state_next_set(player_states.inactive, 99999999);
			}
		}
		
		with (_player_instance)
		{
			x = _x;
			y = _y;
		}
	}
}

/// @function players_end
function players_end()
{
	var _list = global.player_list;
	var _player_instance;
	var _player_number;
	
	for (_player_number = 0; _player_number <= player_numbers.count; ++_player_number)
	{
		_player_instance = _list[_player_number][player_data.instance];
		if !is_undefined(_player_instance)
		{
			instance_destroy(_player_instance);
			_list[_player_number][player_data.instance] = undefined;
		}
	}
}

/// @function players_rubberband_step
/// @param _rubberband_id = 0
function players_rubberband_step(_rubberband_id = 0)
{
	var _average_x, _average_y, _count = 0;
	
	global.player_rubberband_average_previous[_rubberband_id][0] = global.player_rubberband_average[_rubberband_id][0];
	global.player_rubberband_average_previous[_rubberband_id][1] = global.player_rubberband_average[_rubberband_id][1];
	
	with (obj_player)
	{
		if (player_is_alive() && rubber_band == true && rubber_band_color == _rubberband_id)
		{
			if (_count == 0)
			{
				_average_x = x;
				_average_y = y;
			}
			else
			{
				_average_x += x;
				_average_y += y;
			}
			_count++;
		}
	}
	
	if (_count < 2)
	{
		global.player_rubberband_average[_rubberband_id][0] = undefined;
		global.player_rubberband_average[_rubberband_id][1] = undefined;
		exit;
	}
		
	_average_x /= _count;
	_average_y /= _count;
	
	if (is_undefined(global.player_rubberband_average_previous[_rubberband_id, 0]))
	{
		global.player_rubberband_average[_rubberband_id][0] = _average_x;
		global.player_rubberband_average[_rubberband_id][1] = _average_y;
	}
	global.player_rubberband_average[_rubberband_id][0] = _average_x;
	global.player_rubberband_average[_rubberband_id][1] = _average_y;
}

/// @function player_is_alive
function player_is_alive()
{
	switch (state)
	{
		case player_states.debug:
		case player_states.inactive:
		case player_states.drop_in:
		case player_states.death:
		case player_states.bubble:
			return false;
			break;
		default:
			return true;
			break;
	}
}

/// @function players_alive
function players_alive()
{
	var _my_id = id;
	
	with (obj_player)
	{
		if (id == _my_id)
			continue;
			
		switch (state)
		{
			case player_states.debug:
			case player_states.inactive:
			case player_states.drop_in:
			case player_states.death:
			case player_states.bubble:
				continue;
				break;
			default:
				return true;
				break;
		}
	}
	
	return false;
}

/// @function player_nearest_alive
function player_nearest_alive()
{
	var _my_id = id;
	var _player = undefined;
	var _distance = undefined, _distance_temp = undefined;
	
	with (obj_player)
	{
		if (id == _my_id)
			continue;
			
		switch (state)
		{
			case player_states.debug:
			case player_states.inactive:
			case player_states.drop_in:
			case player_states.death:
			case player_states.bubble:
				continue;
				break;
			default:
				break;
		}
			
		_distance_temp = point_distance(_my_id.x, _my_id.y, x, y);
		if (is_undefined(_distance) || _distance_temp < _distance)
		{
			_player = id;
			_distance = _distance_temp;
		}
	}
	
	return _player;
}

/// @function player_nearest_to_point_alive
/// @param _x = x
/// @param _y = y
function player_nearest_to_point_alive(_x = x, _y = y)
{
	var _my_id = id;
	var _player = undefined;
	var _distance = undefined, _distance_temp = undefined;
	
	with (obj_player)
	{
		if (id == _my_id)
			continue;
			
		switch (state)
		{
			case player_states.debug:
			case player_states.inactive:
			case player_states.drop_in:
			case player_states.death:
			case player_states.bubble:
				continue;
				break;
			default:
				break;
		}
			
		_distance_temp = point_distance(_my_id.x, _my_id.y, _x, _y);
		if (is_undefined(_distance) || _distance_temp < _distance)
		{
			_player = id;
			_distance = _distance_temp;
		}
	}
	
	return _player;
}

/// @function players_exist
function players_exist()
{
	var _my_id = id;
	
	with (obj_player)
	{
		if (id == _my_id)
			continue;
			
		switch (state)
		{
			case player_states.debug:
			case player_states.inactive:
			case player_states.drop_in:
				continue;
				break;
			default:
				return true;
				break;
		}
	}
	
	return false;
}

/// @function player_death_reset
function player_death_reset()
{
	var _transition_effect;
	
	if (!players_alive())
	{
		if (global.turbo.mode || global.hearts == 0 && (global.modifiers[modifiers.game_over] || global.game_mode == game_modes.randomizer || global.game_mode == game_modes.boss_rush))
		{
			if (!room_transition_active_get())
				instance_create(obj_gameover);
		}
		else
		{
			if (!room_transition_active_get())
			{
				_transition_effect = instance_create(obj_room_transition_death);
				_transition_effect.color = c_red;
			}
		}
	}
	else
	{
		state_next_set(player_states.bubble);
		water_meter = 100;
	}
}