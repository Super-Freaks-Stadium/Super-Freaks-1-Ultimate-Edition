/// @description Step

var _options_length = array_length(options[page]);

animation_previous = animation;

switch (state)
{
	case pause_menu_states.opening:
		if (state_begin)
		{
			animation = 0;
			animation_previous = 0;
			audio_pause_all();
			sfx_play_global(sfx_ding);
			music_pause();
			visible = true;
			input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
		}
		if (room_transition_active_get())
			exit;
		animation = min(animation + 0.1, 1);
		if (animation == 1)
			state_next_set(pause_menu_states.active);
		break;
	case pause_menu_states.closing:
		if (state_begin)
		{
			animation = 1;
			animation_previous = 1;
			visible = true;
		}
		animation = max(animation - 0.1, 0);
		if (animation == 0)
		{
			state_next_set(pause_menu_states.inactive);
			visible = false;
			game_pause_set(false);
			audio_resume_all();
			music_resume();
			input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
		}
		break;
	case pause_menu_states.active:
		if (state_begin)
		{
			visible = true;
			options_reset();
			page = 0;
			option = 0;
			switch (global.game_mode)
			{
				case game_modes.speedrun:
				case game_modes.randomizer:
				case game_modes.boss_rush:
					options[0][1][menu_option_data.unlocked] = false;
					options[0][2][menu_option_data.unlocked] = false;
					break;
				default:
					options[0][1][menu_option_data.unlocked] = true;
					options[0][2][menu_option_data.unlocked] = true;
					break;
			}
            
            if (global.turbo.mode)
                options[0][2][menu_option_data.unlocked] = false;
		}
		
		if (room_transition_active_get() || instance_exists(obj_remapping_screen))
			exit;
		menu_step(player_number);
		if (input_check_pressed("up", player_number))
		{
			option -= 1;
			if (option < 0)
				option = _options_length - 1;
		}
		else if (input_check_pressed("down", player_number))
		{
			option = (option + 1) mod _options_length;
		}
		if (input_check_pressed("start", player_number) || global.player_list[player_number][player_data.active] == false)
			state_next_set(pause_menu_states.closing);
		break;
	default:
		if (state_begin)
		{
			animation = 0;
			visible = false;
			option = 0;
			music_resume();
			audio_resume_all();
		}
		break;
}
