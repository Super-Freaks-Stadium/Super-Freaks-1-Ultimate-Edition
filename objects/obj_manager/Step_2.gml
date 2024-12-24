/// @description Game Step

var _i = 0;
var _pause;
var _frames_game, _frames_player, _frames_level, _frames_level_fast_forward;
var _despawn = false;
var _new_source = input_source_detect_new();
var _disconnect = false;
var _player_instance;

if (is_struct(_new_source))
{
	_i = 0;
	repeat(INPUT_MAX_PLAYERS)
	{
		if (!input_player_connected(_i))
		{
		    input_source_set(_new_source, _i, true);
		    input_verb_consume(all, _i);
			switch (global.game_mode)
			{
				case game_modes.normal:
					_player_instance = global.player_list[_i][player_data.instance];
						
					if (instance_exists(_player_instance) && _player_instance.state == player_states.inactive)
					{
						with (_player_instance)
							state_next_set(player_states.drop_in, 999999999999999);
					}
					break;
				default:
					break;
			}
		    break;
		}
        
		++_i;
	}
}

//If a player presses a pause button, disconnect them
if (input_player_connected_count() == 0)
	_disconnect = true;
else
{
	_i = 0;
	repeat(INPUT_MAX_PLAYERS)
	{
		if (!input_player_connected(_i))
		{
			player_drop_out_force(_i);
				
			if (global.player_list[_i][player_data.active] == true)
				_disconnect = true;
		}
    
		++_i;
	}
}
if (_disconnect)
{
	if (!instance_exists(obj_players_connected_screen))
		instance_create_layer(0, 0, "layer_instances", obj_players_connected_screen);
}

framerate_game_step();

_frames_game = frame_amount;
frame_amount = 0;

global.game_frame_new = true;

if (_frames_game == 0)
	__input_system_tick_touch();
while (_frames_game > 0)
{
	__input_system_tick();
	__input_system_tick_touch();
    virtual_buttons_step();
    audio_step();
    
	_pause = game_pause_get();

	global.animate = (global.animate + 0.25) mod 8;
	
	//Step 1
	with (obj_master)
	{
		EVENT_FRAMEBEGIN;
		run_frame = false;
		hitbox_check_done = false;
	}
	
	if (instance_exists(obj_players_connected_screen))
	{
		with (obj_players_connected_screen)
			instance_step();
		_frames_player = 0;
		_frames_level = 0;
		_frames_level_fast_forward = 0;
		_frames_game--;
		continue;
	}
	
	frame_machine_step();
	_frames_player = global.frame_machine_player.frame_amount;
	_frames_level = global.frame_machine_level.frame_amount;
	_frames_level_fast_forward = global.frame_machine_level.frame_amount_fast_forward;
	
	with (obj_system)
		instance_step();
		
	with (obj_gameplay_manager)
	{
        trophy_offset_previous = trophy_offset;
		if (the_trophy_appears > 0 || _pause)
		{
			trophy_offset = max(trophy_offset - 3, 0);
			the_trophy_appears--;
		}
		else
			trophy_offset = min(trophy_offset + 3, 32);
	}
		
	if (!_pause)
	{
		with (obj_gameplay_manager)
			instance_step();
		with (obj_gameplay_obj)
			instance_step();
	}
	
	while (_frames_player > 0 || _frames_level_fast_forward > 0)
	{
		global.frame++;
		//Step 1
		if (_frames_player > 0)
		{
			players_rubberband_step(0);
			players_rubberband_step(1);
			with (obj_player_parent)
				instance_step();
		}

		if (_frames_level_fast_forward > 0)
		{
			with (obj_level_obj)
			{
				if (fast_forward || _frames_level > 0)
					instance_step();
			}
		}
		
		//Collision
		with (obj_master)
		{
			comp_list_collider_step();
			comp_list_hitbox_update();
		}
		with (obj_master)
		{
			collisions_check();
			collisions_resolve();
			x_previous = x;
			y_previous = y;
		}

		//Step 2
		if (_frames_level_fast_forward > 0)
		{
			global.instance_despawn_timer = max(global.instance_despawn_timer - 1, 0);
			if (global.instance_despawn_timer == 0)
			{
				global.instance_despawn_timer = 16;
				zones_despawn_check();
				_despawn = true;
			}
				
			with (obj_level_obj)
			{
				if (fast_forward || _frames_level > 0)
				{
					instance_step_2();
					if (_despawn)
						instance_despawn_check();
				}
			}
		
			_frames_level--;
			_frames_level_fast_forward--;
		}
		
		if (_frames_player > 0)
		{
			with (obj_player_parent)
				instance_step_2();
		
			_frames_player--;
		}
		
		global.game_frame_new = false;
	}
	global.frame_machine_player.frame_amount = 0;
	global.frame_machine_level.frame_amount = 0;

	//Step 2
	with (obj_system)
		instance_step_2();
	
	if (!_pause)
	{
		with (obj_gameplay_obj)
		{
			instance_step_2();
		}
		
		with (obj_player)
		{
			//Camera
			event_user(5);
		}
			
		game_timer_step();
		water_step();
		room_transition_step();
		global.lightbulb_timer = max(global.lightbulb_timer - 1, 0);
	}
	
	comp_list_camera_step();
	view_prestep();
	if (!_pause)
		view_step();
		
	//Step Camera and Zones
	zones_step();
	zone_main_step();
	
	//show_debug_message("Spawn Area: " + string(global.view.zone_main_spawn_area));
		
	global.game_frame_new = false;
	gc_timer++;
	if (gc_timer >= GC_TIMER_MAX)
	{
		gc_timer = 0;
		gc_collect();
	}
	_frames_game--;
}

view_step_delta();

room_destination_step();

