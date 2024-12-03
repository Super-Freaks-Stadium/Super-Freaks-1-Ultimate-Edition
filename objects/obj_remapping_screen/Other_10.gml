/// @description Step

y_offset_previous = y_offset;

if (pause)
{
	pause = false;
	exit;
}

switch (state)
{
	case 0: //Raise
		if (state_begin)
		{
			sfx_play_global(sfx_slide_whistle_up);
			y_offset = 1;
		}
		
		y_offset = max(y_offset - 0.05, 0);
		
		if (y_offset == 0)
			state_next_set(2);
		break;
	case 1: //Lower
		if (state_begin)
		{
			input_binding_scan_abort();
			sfx_play_global(sfx_slide_whistle_down);
			y_offset = 0;
		}
		
		y_offset = min(y_offset + 0.05, 1);
		
		if (y_offset == 1)
		{
			instance_destroy();
		}
		break;
	case 2: //Main
		if (!input_player_connected(player_number))
			state_next_set(1);
		switch (page)
		{
			case menu_remapping_screen_pages.main:
				if (!input_binding_scan_in_progress(player_number))
				{
					if (input_check_pressed("deny", player_number))
						state_next_set(1);
					else
					{
						if (input_check_pressed("up", player_number) || input_check_long("up", player_number))
						{
							option--;
				
							if (option < 0)
								option = array_length(options[menu_remapping_screen_pages.main]) - 1;
						}
						else if (input_check_pressed("down", player_number) || input_check_long("down", player_number))
						{
							option++;
				
							if (option >= array_length(options[menu_remapping_screen_pages.main]))
								option = 0;
						}
					}
					menu_step();
				}
				break;
			case menu_remapping_screen_pages.remap:
				if (!input_binding_scan_in_progress(player_number))
				{
				    input_binding_scan_start(function(_binding)
				    {
						sfx_play_global(sfx_ding);
				        input_binding_set_safe(verb_list[verb_index][1], _binding, player_number);
						if (set_all)
						{
							if (verb_index + 1 < array_length(verb_list))
								verb_index++;
							else
							{
								page = menu_remapping_screen_pages.main;
								option = array_length(verb_list) + 1;
								string_save(input_system_export(), "input.settings");
							}
						}
						else
						{
							page = menu_remapping_screen_pages.main;
							option = verb_index;
							string_save(input_system_export(), "input.settings");
						}
						pause = true;
				    }, function()
					{
						page = menu_remapping_screen_pages.main;
						option = array_length(verb_list) + 1;
						pause = true;
					},, player_number);
				}
				break;
		}
		break;
}