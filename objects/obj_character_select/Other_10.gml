/// @description Step

var _player_num;
var _cutscene_room;
var _level_list;

y_offset_previous = y_offset;

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
			sfx_play_global(sfx_slide_whistle_down);
			y_offset = 0;
		}
		
		y_offset = min(y_offset + 0.05, 1);
		
		if (y_offset == 1)
		{
			instance_destroy();
			input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
		}
		break;
	case 2: //Main
		switch (page)
		{
			case menu_character_select_pages.main:
				input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
				
				if (is_undefined(global.player_lead))
					exit;
					
				if (input_check_pressed("up", global.player_lead))
				{
					option--;
					if (option < 0)
						option = 2;
				} 
				else if (input_check_pressed("down", global.player_lead))
				{
					option++;
					if (option > 2)
						option = 0;
				}
				
				if (input_check_pressed("confirm", global.player_lead))
				{
					switch (option)
					{
						case 0:
							page = menu_character_select_pages.character_select;
							break;
						case 1:
							page = menu_character_select_pages.difficulty_select;
							option = 0;
							break;
						case 2:
							page = menu_character_select_pages.modifiers;
							option = 0;
							break;
					}
					sfx_play_global(sfx_ding);
				}
				else if (input_check_pressed("deny", global.player_lead))
					state_next_set(1);
				break;
			case menu_character_select_pages.modifiers:
				input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
				
				if (is_undefined(global.player_lead))
					exit;
					
				if (input_check_pressed("up", global.player_lead))
				{
					option--;
					if (option < 0)
						option = 2;
				} 
				else if (input_check_pressed("down", global.player_lead))
				{
					option++;
					if (option > 2)
						option = 0;
				}
				
				if (input_check_pressed("confirm", global.player_lead) || input_check_pressed("deny", global.player_lead))
				{
					page = menu_character_select_pages.main;
					option = 2;
					sfx_play_global(sfx_ding);
				}
				else
				{
					if (input_check_pressed("left", global.player_lead) || input_check_pressed("right", global.player_lead))
						global.modifiers[option] = !global.modifiers[option];
				}
				break;
			case menu_character_select_pages.difficulty_select:
				input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
				
				if (is_undefined(global.player_lead))
					exit;
				
				if (global.story_mode == story_modes.super_freaks)
				{
					if (input_check_pressed("left", global.player_lead))
					{
						option--;
						if (option < 0)
							option = 2;
					} 
					else if (input_check_pressed("right", global.player_lead))
					{
						option++;
						if (option > 2)
							option = 0;
					}
				}
				
				switch (option)
				{
					case 0: //Difficulty Select
						if (input_check_pressed("up", global.player_lead))
						{
							global.difficulty = max(global.difficulty - 1, 0);
						}
						else if (input_check_pressed("down", global.player_lead))
						{
							global.difficulty = min(global.difficulty + 1, difficulty_levels.hard);
						}
						break;
					case 1: //Heart Min
						if (input_check_pressed("up", global.player_lead) || input_check_long("up", global.player_lead))
						{
							if (hearts_minimum_get() < hearts_maximum_get())
								hearts_minimum_set(hearts_minimum_get() + 1);
						}
						else if (input_check_pressed("down", global.player_lead) || input_check_long("down", global.player_lead))
						{
							hearts_minimum_set(hearts_minimum_get() - 1);
						}
						break;
					case 2: //Heart Max
						if (input_check_pressed("up", global.player_lead) || input_check_long("up", global.player_lead))
						{
							hearts_maximum_set(hearts_maximum_get() + 1);
							if (hearts_maximum_get() > HEART_MAX)
								hearts_maximum_set(0);
						}
						else if (input_check_pressed("down", global.player_lead) || input_check_long("down", global.player_lead))
						{
							hearts_maximum_set(hearts_maximum_get() - 1);
							if (hearts_maximum_get() < 0)
								hearts_maximum_set(HEART_MAX);
							hearts_minimum_set(min(hearts_minimum_get(), hearts_maximum_get()));
						}
						break;
				}
				
				if (input_check_pressed("confirm", global.player_lead) || input_check_pressed("deny", global.player_lead))
				{
					page = menu_character_select_pages.main;
					option = 1;
					sfx_play_global(sfx_ding);
				}
				
				break;
			case menu_character_select_pages.character_select:
				input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
				#region Character Select
					if (input_check_pressed("confirm", global.player_lead))
						state_next_set(3);
					else if (input_check_pressed("deny", global.player_lead))
					{
						page = menu_character_select_pages.main;
						option = 0;
					}
				
					for (_player_num = 0; _player_num <= player_numbers.count; ++_player_num)
					{
						if (global.player_list[_player_num][player_data.active])
						{
							if (input_check_pressed("up", _player_num) || input_check_long("up", _player_num))
							{
								global.player_list[_player_num][player_data.character_index]++;
					
								if (global.player_list[_player_num][player_data.character_index] > unlockedChars[array_length(unlockedChars) - 1])
									global.player_list[_player_num][player_data.character_index] = unlockedChars[0];
					
								while (global.characters_unlocked[global.player_list[_player_num][player_data.character_index]][global.story_mode] == false)
								{
									global.player_list[_player_num][player_data.character_index]++;
					
									if (global.player_list[_player_num][player_data.character_index] > unlockedChars[array_length(unlockedChars) - 1])
										global.player_list[_player_num][player_data.character_index] = unlockedChars[0];
								}
							}
							else if (input_check_pressed("down", _player_num) || input_check_long("down", _player_num))
							{
								global.player_list[_player_num][player_data.character_index]--;
					
								if (global.player_list[_player_num][player_data.character_index] < 0)
									global.player_list[_player_num][player_data.character_index] = unlockedChars[array_length(unlockedChars) - 1];
						
								while (global.characters_unlocked[global.player_list[_player_num][player_data.character_index]][global.story_mode] == false)
								{
									global.player_list[_player_num][player_data.character_index]--;
									if (global.player_list[_player_num][player_data.character_index] < 0)
										global.player_list[_player_num][player_data.character_index] = unlockedChars[array_length(unlockedChars) - 1];
								}
							}
						}
						else
						{
							if (input_player_connected(_player_num))
								global.player_list[_player_num][player_data.active] = true;
						}
					}
				#endregion
				break;
		}
		break;
	case 3: //Go To Level
		if (state_begin)
		{
			game_timer_pause(true);
			game_timer_reset();
			switch (global.game_mode)
			{
				case game_modes.randomizer:
					_level_list = global.level_list[level_lists.completed];
					array_resize(global.current_level_list, 0);
					array_copy(global.current_level_list, 0, _level_list, 0, array_length(_level_list));
					global.current_level_list = array_shuffle(global.current_level_list);
					global.score = 0;
					global.level_demo = 0;
					global.level_id = global.current_level_list[global.level_demo];
					spawn_point_set(level_room_get(global.level_id));
					instance_create_layer(0, 0, "layer_instances", obj_room_transition_level);
					randomize();
					break;
				case game_modes.boss_rush:
					_level_list = global.level_list[level_lists.boss];
					array_resize(global.current_level_list, 0);
					array_copy(global.current_level_list, 0, _level_list, 0, array_length(_level_list));
					global.level_demo = 0;
					global.level_id = global.current_level_list[global.level_demo];
					spawn_point_set(level_room_get(global.level_id));
					instance_create_layer(0, 0, "layer_instances", obj_room_transition_level);
					random_set_seed(694201337);
					break;
				case game_modes.speedrun:
					switch (global.game_mode_subtype)
					{
						case speedrun_modes.normal:
							_level_list = global.level_list[level_lists.speedrun_normal];
							break;
						case speedrun_modes.crazy:
							_level_list = global.level_list[level_lists.speedrun_crazy];
							break;
						case speedrun_modes.ludicrous:
							_level_list = global.level_list[level_lists.speedrun_ludicrous];
							break;
						case speedrun_modes.insane:
							_level_list = global.level_list[level_lists.speedrun_insane];
							break;
						case speedrun_modes.freaky:
							_level_list = global.level_list[level_lists.speedrun_freaky];
							break;
						case speedrun_modes.kranion:
							_level_list = global.level_list[level_lists.speedrun_kranion];
							break;
						case speedrun_modes.mystic:
							_level_list = global.level_list[level_lists.speedrun_stadium];
							break;
						case speedrun_modes.adventure:
							_level_list = global.level_list[level_lists.speedrun_adventure];
							break;
						case speedrun_modes.secret:
							_level_list = global.level_list[level_lists.speedrun_secret];
							break;
						case speedrun_modes.ultimate:
							_level_list = global.level_list[level_lists.speedrun_ultimate];
							break;
					}
					array_resize(global.current_level_list, 0);
					array_copy(global.current_level_list, 0, _level_list, 0, array_length(_level_list));
					global.level_demo = 0;
					global.level_id = global.current_level_list[global.level_demo];
					spawn_point_set(level_room_get(global.level_id));
					instance_create_layer(0, 0, "layer_instances", obj_room_transition_level);
					random_set_seed(694201337);
					break;
				default:
					_cutscene_room = global.level_cutscene_list[global.story_mode][global.level_id][level_cutscene_data.before];
					randomize();
					if (!level_complete_get(global.level_id) && _cutscene_room != undefined)
					{
						spawn_point_set(_cutscene_room);
						instance_create_layer(0, 0, "layer_instances", obj_room_transition_fade);
					}
					else
						instance_create_layer(0, 0, "layer_instances", obj_room_transition_level);
					break;
			}
			music_stop();
		}
		break;
}