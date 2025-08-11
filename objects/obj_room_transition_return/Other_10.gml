/// @description Step

var _func;

switch (state)
{
	case 0: //Fade In
		if (state_begin)
		{
			frame = 0;
			circle_size = 1;
		}
			
		frame = min(frame + 1, 10);
		circle_size = 1 - (min(frame, 10) / 10);
		if (frame == 10)
			state_next_set(1);
		break;
	case 1: //Count Through Unlocks
		if (state_begin)
		{
			circle_size = 0;
		}
			
		music_stop();
		if (unlock_id >= array_length(global.unlocks))
			state_next_set(5);
		else
		{
			if (global.unlocks[unlock_id][unlock_data.unlocked] == true)
				unlock_id++;
			else
			{
				_func = global.unlocks[unlock_id][unlock_data.func_condition];
		
				if (_func() == true)
				{
					global.unlocks[unlock_id][unlock_data.unlocked] = true;
					_func = global.unlocks[unlock_id][unlock_data.func_unlock];
					_func();
					state_next_set(2);
				}
				else
					unlock_id++;
			}
		}
		break;
	case 2: //Unlock Text Open
		if (state_begin)
		{
			text = global.unlocks[unlock_id][unlock_data.text];
			dialog_size = 0;
			frame = 0;
		}
		
		frame = min(frame + 1, 10);
		dialog_size = lerp(dialog_size, 1, frame / 10);
		
		if (frame == 10)
			state_next_set(3);
		break;
	case 3: //Unlock Text
		if (state_begin)
		{
			dialog_size = 1;
			frame = 0;
			button_prompt = true;
			audio_stop_all();
			sfx_play_global(sfx_fanfare);
		}
		
		frame = min(frame + 1, 120);
		
		if (input_check("confirm", 0))
			state_next_set(4);
		break;
	case 4: //Unlock Text Close
		if (state_begin)
		{
			frame = 0;
			button_prompt = false;
		}
		
		frame = min(frame + 1, 10);
		dialog_size = lerp(dialog_size, 0, frame / 10);
		
		if (frame == 10)
			state_next_set(1);
		break;
	case 5:
		if (state_begin)
		{
			audio_stop_all();
			levels_save();
			unlocks_save();
			museum_unlocks();
			museum_save();
			draw_texture_flush();
			switch (global.game_mode)
			{
				case game_modes.normal:
					spawn_point_set(rm_worldmap);
					break;
				default:
					spawn_point_set(rm_menu_main);
					break;
			}
			game_timer_reset();
			room_destination_set(spawn_point_room_get());
			global.hearts = 0;
			global.heart_meter = 0;
		}
		break;
	case 6:
		if (state_begin)
		{
			frame = 0;
			circle_size = 0;
		}
		
		frame = min(frame + 1, 10);
		circle_size = (frame / 10);
		
		if (frame == 10)
			instance_destroy();
		break;
}
