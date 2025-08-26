function player_state_dropin()
{
	var unlockedChars = [];

	for (var i = 0; i < array_length(struct_get_names(global.character_indexes)); i++)
	{
		if (global.characters_unlocked[i][global.story_mode])
			array_push(unlockedChars, i);
	}

	if (!array_contains(unlockedChars, global.player_list[player_number][player_data.character_index]))
	{
		global.player_list[player_number][player_data.character_index] = unlockedChars[0];
	}
	
	//show_debug_message(unlockedChars);
	
	if (state_begin)
	{
		visible = false;
		camera.active = false;
		physics = player_physics_modifiers.normal;
		ball = false;
		hitbox.active = hitbox_active.inactive;
		rubber_band_can_slingshot = false;
		aura = 0;
        star_arrow = 0;
		sfx_play_global(sfx_ding);
	}
	
	if (!input_player_connected(player_number) || input_check_pressed("drop_out", player_number))
	{
		state_next_set(player_states.inactive, 999999999);
	}
	else
	{
		//if (button_left == controls_action_states.press)
		if (input_check_pressed("left", player_number))
		{
			global.player_list[player_number][player_data.character_index]++;
					
			if (global.player_list[player_number][player_data.character_index] > unlockedChars[array_length(unlockedChars) - 1])
				global.player_list[player_number][player_data.character_index] = unlockedChars[0];
					
			while (global.characters_unlocked[global.player_list[player_number][player_data.character_index]][global.story_mode] == false)
			{
				global.player_list[player_number][player_data.character_index]++;
					
				if (global.player_list[player_number][player_data.character_index] > unlockedChars[array_length(unlockedChars) - 1])
					global.player_list[player_number][player_data.character_index] = unlockedChars[0];
			}
		
			character_index = global.player_list[player_number][player_data.character_index];
		}
		//else if (button_right == controls_action_states.press)
		else if (input_check_pressed("right", player_number))
		{
			global.player_list[player_number][player_data.character_index]--;
					
			if (global.player_list[player_number][player_data.character_index] < 0)
				global.player_list[player_number][player_data.character_index] = unlockedChars[array_length(unlockedChars) - 1];
						
			while (global.characters_unlocked[global.player_list[player_number][player_data.character_index]][global.story_mode] == false)
			{
				global.player_list[player_number][player_data.character_index]--;
				if (global.player_list[player_number][player_data.character_index] < 0)
					global.player_list[player_number][player_data.character_index] = unlockedChars[array_length(unlockedChars) - 1];
			}
		
			character_index = global.player_list[player_number][player_data.character_index];
		}
		//else if (button_jump == controls_action_states.press)
		else if (input_check_pressed("jump", player_number))
		{
			state_next_set(player_states.bubble, 999999999);
			global.player_list[player_number][player_data.active] = true;
			global.player_list[player_number][player_data.character_index] = character_index;
			
			var hbSize = player_hitbox_get(character_index);
			with (hitbox)
			{
				shape_x1 = hbSize.x1;
				shape_y1 = hbSize.y1;
				shape_x2 = hbSize.x2;
				shape_y2 = hbSize.y2;
			}
			
			x = view_x1_get();
			y = view_y1_get();
			x_start_frame = x;
			y_start_frame = y;
		}
	}
}
