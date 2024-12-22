/// @description Init

enum main_menu_pages
{
	main = 0,
	story,
	demo,
	challenge,
	challenge_freeplay,
	challenge_speedrun,
	museum,
	museum_characters,
	museum_theater,
	options,
	options_controls,
	options_audio,
	options_visual,
	options_other,
	options_debug,
	options_debug_levelselect,
}

var _page;
var _i;

// Inherit the parent event
event_inherited();

option_selected = false;
main_text = "";
bottom_text = "";
index = 0;
player_number = 0;
museum_items = [[], []];
character_card_index = 0;
cutscene_index = 0;
timer = 0;

#region Main
	_page = main_menu_pages.main;
	menu_option_add(_page, 0, "Super Freaks Story", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 0;
			global.story_mode = story_modes.super_freaks;
		}
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	});
	menu_option_add(_page, 1, "Bad Guys Story", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 0;
			global.story_mode = story_modes.kranion;
		}
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	});
	menu_option_add(_page, 2, "Uncle Swordsman Story", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 0;
			global.story_mode = story_modes.swordsman;
		}
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	}, true);
	menu_option_add(_page, 3, "Anti Freaks Story (Coming Soon!)", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 0;
			global.story_mode = story_modes.anti_freaks;
		}
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	}, true);
	menu_option_add(_page, 4, "Final Battle (Coming Soon!)", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			global.game_mode = game_modes.normal;
			global.story_mode = story_modes.super_freaks;
			global.level_id = level_ids.level_apex;
			instance_create(obj_character_select);
		}
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	}, false);
	menu_option_add(_page, 5, "Museum", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			if (options[main_menu_pages.main][5][menu_option_data.unlocked])
			{
				page = main_menu_pages.museum;
				option = 0;
			}
			else
				sfx_play_global(sfx_honk);
		}
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	}, global.unlocks[unlocks.museum][unlock_data.unlocked]);
	menu_option_add(_page, 6, "Options", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.options;
			option = 0;
		}
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	});
	menu_option_add(_page, 7, "More Super Freaks Games", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
			url_open("https://superfreaks.neocities.org/");
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	});
	menu_option_add(_page, 8, "Exit", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
			game_end();
        if (input_check_pressed("deny", global.player_lead))
        {
            spawn_point_set(rm_title);
            instance_create(obj_room_transition_fade);
        }
	});
#endregion

#region Story
	_page = main_menu_pages.story;
	menu_option_add(_page, 0, "Adventure", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			if (!level_complete_get(level_ids.level_stadium, global.story_mode))
			{
				global.game_mode = game_modes.normal;
				global.level_id = level_ids.level_stadium;
				instance_create(obj_character_select);
			}
			else
			{
				spawn_point_set(rm_worldmap);
				instance_create(obj_room_transition_fade);
			}
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			option = global.story_mode;
		}
	});
	menu_option_add(_page, 1, "Challenge", function()
	{
		main_text = "Super Freaks 1 Ultimate Edition";
		if (input_check_pressed("confirm", global.player_lead))
		{
			var _level_list = levels_get_all_completed();
			show_debug_message(_level_list);
			
			options[main_menu_pages.challenge][0][menu_option_data.unlocked] = (array_length(_level_list) > 0);
			show_debug_message($"Unlocked: {options[main_menu_pages.challenge][0][menu_option_data.unlocked]}")
			
			page = main_menu_pages.challenge;
			option = 0;
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			switch (global.story_mode)
			{
				case story_modes.super_freaks:
					option = 0;
					break;
				case story_modes.kranion:
					option = 1;
					break;
				case story_modes.swordsman:
					option = 2;
					break;
				case story_modes.anti_freaks:
					option = 3;
					break;
				case story_modes.final:
					option = 4;
					break;
			}
		}
	});
#endregion

#region Demo
	_page = main_menu_pages.demo;
	
	menu_option_add(_page, 0, "Free Play", function()
	{
		var _index;
		var _name_world, _name_level, _room;
		var _level_max = array_length(global.level_list[level_lists.demo]);
		
		main_text = "Demo Levels";
		
		if (input_check_pressed("left", global.player_lead))
		{
			global.level_demo--;
			if (global.level_demo < 0)
				global.level_demo = _level_max - 1;
		}
		else if (input_check_pressed("right", global.player_lead))
		{
			global.level_demo = (global.level_demo + 1) mod _level_max;
		}
		
		_index = global.level_list[level_lists.demo][global.level_demo];
		_name_world = level_name_world_get(_index);
		_name_level = level_name_get(_index);
		_room = level_room_get(_index);
		
		options[main_menu_pages.demo][0][menu_option_data.text] = "<-- Level " + string(_index) + " -->"
		+ "\n" + string(_name_world) + "\n" + string(_name_level);
		
		if (input_check_pressed("confirm", global.player_lead))
		{
			global.game_mode = game_modes.free_play;
			global.level_id = _index;
			spawn_point_set(_room);
			instance_create(obj_character_select);
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			option = 0;
		}
	});
#endregion

#region Challenge
	_page = main_menu_pages.challenge;
	menu_option_add(_page, 0, "Free Play", function()
	{
		main_text = "Challenge Mode";
		bottom_text = "Replay any level you've already beaten";
		if (input_check_pressed("confirm", global.player_lead))
		{
			if (options[main_menu_pages.challenge][0][menu_option_data.unlocked])
			{
				page = main_menu_pages.challenge_freeplay;
				global.level_id = level_ids.level_stadium;
				global.level_demo = 0;
				index = global.level_id;
				option = 0;
			}
			else
				sfx_play_global(sfx_honk);
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 1;
		}
	}, global.unlocks[unlocks.free_play][unlock_data.unlocked]);
	menu_option_add(_page, 1, "Randomizer", function()
	{
		main_text = "Challenge Mode";
		if (input_check_pressed("confirm", global.player_lead))
		{
			if (options[main_menu_pages.challenge][1][menu_option_data.unlocked])
			{
				global.game_mode = game_modes.randomizer;
				instance_create(obj_character_select);
			}
			else
				sfx_play_global(sfx_honk);
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 1;
		}
	}, global.unlocks[unlocks.randomizer][unlock_data.unlocked]);
	menu_option_add(_page, 2, "Speedrun", function()
	{
		main_text = "Challenge Mode";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.challenge_speedrun;
			option = 0;
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 1;
		}
	});
	menu_option_add(_page, 3, "Boss Rush", function()
	{
		main_text = "Challenge Mode";
		if (input_check_pressed("confirm", global.player_lead))
		{
			if (options[main_menu_pages.challenge][3][menu_option_data.unlocked])
			{
				global.game_mode = game_modes.boss_rush;
				instance_create_layer(0, 0, "layer_instances", obj_character_select);
			}
			else
				sfx_play_global(sfx_honk);
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.story;
			option = 1;
		}
	}, global.unlocks[unlocks.boss_rush][unlock_data.unlocked]);
	
	#region Free Play
		_page = main_menu_pages.challenge_freeplay;
		menu_option_add(_page, 0, "Free Play", function()
		{
			var _index;
			var _name_world, _name_level, _room;
			var _level_list = levels_get_all_completed();
			var _level_max = array_length(_level_list);
		
			main_text = "Challenge Mode - Free Play";
			
			if (array_length(_level_list) == 0)
			{
				options[main_menu_pages.challenge_freeplay][0][menu_option_data.text] = "Hey, we're under construction.\nWhy don't you come back after\nbeating a level or two?";
				if (input_check_pressed("deny", global.player_lead))
				{
					page = main_menu_pages.challenge;
					option = 0;
				}
			}
			else
			{
				if (input_check_pressed("left", global.player_lead))
				{
					global.level_demo--;
					if (global.level_demo < 0)
						global.level_demo = _level_max - 1;
				}
				else if (input_check_pressed("right", global.player_lead))
				{
					global.level_demo = (global.level_demo + 1) mod _level_max;
				}
		
				_index = _level_list[global.level_demo];
				_name_world = level_name_world_get(_index);
				_name_level = level_name_get(_index);
				_room = level_room_get(_index);
		
				options[main_menu_pages.challenge_freeplay][0][menu_option_data.text] = "<-- " + string(_name_world) + ": " + string(_name_level) + " -->";
		
				if (input_check_pressed("confirm", global.player_lead))
				{
					global.game_mode = game_modes.free_play;
					global.level_id = _index;
					spawn_point_set(_room);
					instance_create(obj_character_select);
				}
				else if (input_check_pressed("deny", global.player_lead))
				{
					page = main_menu_pages.challenge;
					option = 0;
				}
			}
		});
	#endregion

	#region Speedrun
		_page = main_menu_pages.challenge_speedrun;
		
		menu_option_add(_page, 0, "Normal Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][0][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.normal;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the Normal World levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_normal][unlock_data.unlocked]);
		
		menu_option_add(_page, 1, "Crazy Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][1][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.crazy;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the Crazy World levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_crazy][unlock_data.unlocked]);
		
		menu_option_add(_page, 2, "Ludicrous Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][2][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.ludicrous;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the Ludicrous World levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_ludicrous][unlock_data.unlocked]);
		
		menu_option_add(_page, 3, "Insane Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][3][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.insane;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the Insane World levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_insane][unlock_data.unlocked]);
		
		menu_option_add(_page, 4, "Freaky Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][4][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.freaky;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the Freaky World levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_freaky][unlock_data.unlocked]);
		
		menu_option_add(_page, 5, "Kranion Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][5][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.kranion;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the Castle Kranion levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_kranion][unlock_data.unlocked]);
		
		menu_option_add(_page, 6, "Stadium Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][6][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.mystic;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the Mystic Island levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_stadium][unlock_data.unlocked]);
		
		menu_option_add(_page, 7, "Adventure Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][7][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.adventure;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete all of the main levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_story][unlock_data.unlocked]);
		
		menu_option_add(_page, 8, "Secret Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][8][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.secret;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete the secret levels as fast as you can!";
		}, global.unlocks[unlocks.speedrun_secret][unlock_data.unlocked]);
		
		menu_option_add(_page, 9, "Ultimate Run", function()
		{
			main_text = "Challenge Mode - Speedrun";
			if (input_check_pressed("confirm", global.player_lead))
			{
				if (options[main_menu_pages.challenge_speedrun][9][menu_option_data.unlocked])
				{
					global.game_mode = game_modes.speedrun;
					global.game_mode_subtype = speedrun_modes.ultimate;
					instance_create_layer(0, 0, "layer_instances", obj_character_select);
				}
				else
					sfx_play_global(sfx_honk);
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.challenge;
				option = 2;
			}
			bottom_text = "Complete every level in the game as fast as you can!";
		}, global.unlocks[unlocks.speedrun_100][unlock_data.unlocked]);
	#endregion
#endregion

#region Museum
	_page = main_menu_pages.museum;
	menu_option_add(_page, 0, "Character Cards", function()
	{
		main_text = "Museum";
		bottom_text = "Read bios on this game's nutty cast of characters!";
		if (input_check_pressed("confirm", global.player_lead))
		{
			if (input_check_pressed("confirm", global.player_lead))
			{
				page = main_menu_pages.museum_characters;
				option = 0;
			}
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			option = 5;
		}
	});
	menu_option_add(_page, 1, "Movie Theater", function()
	{
		main_text = "Museum";
		bottom_text = "Grab some popcorn and watch this game's dumb story!";
		if (input_check_pressed("confirm", global.player_lead))
		{
			if (input_check_pressed("confirm", global.player_lead))
			{
				page = main_menu_pages.museum_theater;
				option = 0;
			}
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			option = 5;
		}
	});
	
	#region Character Cards
		_page = main_menu_pages.museum_characters;
	
		menu_option_add(_page, 0, "Character Card", function()
		{
			var _max = array_length(museum_items[museum_data.characters]);
		
			main_text = "Museum - Character Cards";
		
			if (input_check_pressed("left", global.player_lead))
			{
				character_card_index--;
				if (character_card_index < 0)
					character_card_index = _max - 1;
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				character_card_index = (character_card_index + 1) mod _max;
			}
		
			if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.museum;
				option = 0;
			}
		});
	#endregion
	
	#region Movie Theater
		_page = main_menu_pages.museum_theater;
	
		menu_option_add(_page, 0, "Theater", function()
		{
			var _max = array_length(museum_items[museum_data.cutscenes]);
			var _index, _room;
		
			main_text = "Museum - Movie Theater";
		
			if (input_check_pressed("left", global.player_lead))
			{
				cutscene_index--;
				if (cutscene_index < 0)
					cutscene_index = _max - 1;
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				cutscene_index = (cutscene_index + 1) mod _max;
			}
		
			if (input_check_pressed("confirm", global.player_lead))
			{
				_index = museum_items[museum_data.cutscenes][cutscene_index];
				_room = global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.room];
				
				spawn_point_set(_room);
				instance_create_layer(0, 0, "layer_instances", obj_room_transition_fade);
				game_mode_set(game_modes.museum);
				global.game_mode_subtype = cutscene_index;
				music_stop();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.museum;
				option = 1;
			}
		});
	#endregion
#endregion

#region Options
	_page = main_menu_pages.options;
	menu_option_add(_page, 0, "Controls", function()
	{
		main_text = "Options";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.options_controls;
			option = 0;
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			option = 6;
		}
	});
	menu_option_add(_page, 1, "Visual", function()
	{
		main_text = "Options";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.options_visual;
			option = 0;
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			option = 6;
		}
	});
	menu_option_add(_page, 2, "Audio", function()
	{
		main_text = "Options";
		if (input_check_pressed("confirm", global.player_lead))
		{
			page = main_menu_pages.options_audio;
			option = 0;
		}
		else if (input_check_pressed("deny", global.player_lead))
		{
			page = main_menu_pages.main;
			option = 6;
		}
	});
	//menu_option_add(_page, 3, "Other", function()
	//{
	//  main_text = "Options";
	//	if (input_check_pressed("confirm", global.player_lead))
	//	{
	//	//	page = main_menu_pages.challenge_freeplay;
	//	//	index = global.level_id;
	//	//	option = 0;
	//	}
	//	else if (input_check_pressed("deny", global.player_lead))
	//	{
	//		page = main_menu_pages.main;
	//		option = 3;
	//	}
	//});
	
	if (global.debug)
	{
		menu_option_add(_page, 3, "Debug", function()
		{
			main_text = "Options";
			if (input_check_pressed("confirm", global.player_lead))
			{
				page = main_menu_pages.options_debug;
				option = 0;
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.main;
				option = 6;
			}
		});
	}
	
	#region Controls
		_page = main_menu_pages.options_controls;
		
		for (_i = 0; _i < INPUT_MAX_PLAYERS; ++_i)
		{
			menu_option_add(_page, _i, "Player " + string(_i + 1), function()
			{
				var _player_number = option;
				var _screen;
				
				if (input_check_pressed("confirm", global.player_lead))
				{
					_screen = instance_create_layer(0, 0, "layer_instances", obj_remapping_screen);
					with (_screen)
						player_number = _player_number;
				}
				else if (input_check_pressed("deny", global.player_lead))
				{
					page = main_menu_pages.options;
					option = 0;
				}
			});
		}
		
		#region Old Control Remapping Menu
			//for (_i = 0; _i <= controls_actions.count; ++_i)
			//{
			//	menu_option_add(_page, _i, "", function()
			//	{
			//		var _last;
			//		var _button;
			//		var _action = option;
				
			//		main_text = "Options - Controls";
				
			//		if (option_selected)
			//		{
			//			bottom_text = "Press any key/gamepad button to map it to this action, or remove it if already assigned. Wait a few seconds to cancel.";
			//			_button = key_stored_get();
			//			if (_button != -1)
			//			{
			//				controls_action_button_key_add(_action, player_number, _button);
			//				option_selected = false;
			//				pause_inputs = true;
			//				controls_save();
			//				sfx_play_global(sfx_ding);
			//				exit;
			//			}
					
			//			_button = global.gamepad_key[player_number];
			//			_last = global.gamepad_keylast[player_number];
			//			if (_button != -1) && (_button != _last)
			//			{
			//				controls_action_button_gamepad_add(_action, player_number, _button);
			//				option_selected = false;
			//				pause_inputs = true;
			//				controls_save();
			//				sfx_play_global(sfx_ding);
			//				exit;
			//			}
			//			//_button = mouse_button_stored_get();
			//			//if (_button != mb_none)
			//			//{
			//			//	controls_action_button_mouse_add(_action, player_number, _button);
			//			//	option_selected = false;
			//			//	pause_inputs = true;
			//			//	controls_save();
			//			//	sfx_play_global(sfx_ding);
			//			//}
					
			//			if (option_selected)
			//			{
			//				timer = max(timer - 1, 0);
			//				if (timer == 0)
			//				{
			//					option_selected = false;
			//					pause_inputs = true;
			//					sfx_play_global(sfx_honk);
			//					exit;
			//				}
			//			}
			//		}
			//		else
			//		{
			//			if (input_check_pressed("left", global.player_lead))
			//			{
			//				player_number--;
			//				if (player_number < 0)
			//					player_number = player_numbers.count;
			//			}
			//			else if (input_check_pressed("right", global.player_lead))
			//			{
			//				player_number++;
			//				if (player_number > player_numbers.count)
			//					player_number = 0;
			//			}
			//			else if (input_check_pressed("confirm", global.player_lead))
			//			{
			//				option_selected = true;
			//				timer = 128;
			//			}
			//			else if (input_check_pressed("deny", global.player_lead))
			//			{
			//				page = main_menu_pages.options;
			//				option = 0;
			//			}
			//		}
			//	});
			//}
		#endregion
	#endregion
	
	#region Visuals
		_page = main_menu_pages.options_visual;
		/// @function visual_options_set
		visual_options_set = function()
		{
			global.visuals_settings.aspect_ratio = option_aspectratio;
			global.visuals_settings.upscale_window = option_upscale;
			global.visuals_settings.upscale_internal = option_upscale_internal;
			global.visuals_settings.fullscreen = option_fullscreen;
			global.visuals_settings.frame_rate = option_framerate;
			vsync_set(option_vsync);
			global.visuals_settings.screen_shake = option_screenshake;
			global.visuals_settings.background_blur = option_background;
			global.visuals_settings.shader = option_shader;
			global.visuals_settings.motion_sickness = option_motion_sickness;
			sfx_play_global(sfx_ding);
			screen_set();
			visuals_save();
		}
		
		/// @function visual_options_reset
		visual_options_reset = function()
		{
			option_aspectratio = aspect_ratio_current_get();
			option_upscale = screen_upscale_get();
			option_upscale_internal = global.visuals_settings.upscale_internal;
			option_fullscreen = global.visuals_settings.fullscreen;
			option_framerate = framerate_current_get();
			option_vsync = vsync_get();
			option_screenshake = global.visuals_settings.screen_shake;
			option_background = global.visuals_settings.background_blur;
			option_shader = global.visuals_settings.shader;
			option_motion_sickness = global.visuals_settings.motion_sickness;
		}
		
		visual_options_reset();
		
		menu_option_add(_page, 0, "Aspect Ratio: " + string(global.aspect_ratio_list[option_aspectratio][2]), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead))
			{
				option_aspectratio--;
				if (option_aspectratio < 0)
					option_aspectratio = array_length(global.aspect_ratio_list) - 1;
				options[main_menu_pages.options_visual][0][menu_option_data.text] = "Aspect Ratio: " + string(global.aspect_ratio_list[option_aspectratio][2]);
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				option_aspectratio++;
				if (option_aspectratio >= array_length(global.aspect_ratio_list))
					option_aspectratio = 0;
				options[main_menu_pages.options_visual][0][menu_option_data.text] = "Aspect Ratio: " + string(global.aspect_ratio_list[option_aspectratio][2]);
			}
		});
		
		menu_option_add(_page, 1, "Window Upscale Size: " + string(option_upscale) + "x", function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead))
			{
				option_upscale--;
				if (option_upscale < 1)
					option_upscale = SCREEN_UPSCALE_MAX;
				options[main_menu_pages.options_visual][1][menu_option_data.text] = "Window Upscale Size: " + string(option_upscale) + "x";
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				option_upscale++;
				if (option_upscale > SCREEN_UPSCALE_MAX)
					option_upscale = 1;
				options[main_menu_pages.options_visual][1][menu_option_data.text] = "Window Upscale Size: " + string(option_upscale) + "x";
			}
		});
		
		menu_option_add(_page, 2, "Internal Upscale Size: " + string(option_upscale_internal) + "x", function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead))
			{
				option_upscale_internal--;
				if (option_upscale_internal < 1)
					option_upscale_internal = SCREEN_UPSCALE_MAX;
				options[main_menu_pages.options_visual][2][menu_option_data.text] = "Internal Upscale Size: " + string(option_upscale_internal) + "x";
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				option_upscale_internal++;
				if (option_upscale_internal > SCREEN_UPSCALE_MAX)
					option_upscale_internal = 1;
				options[main_menu_pages.options_visual][2][menu_option_data.text] = "Internal Upscale Size: " + string(option_upscale_internal) + "x";
			}
		});
		
		menu_option_add(_page, 3, "Fullscreen: " + string(boolean_string_onoff(option_fullscreen)), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead) || input_check_pressed("right", global.player_lead))
			{
				option_fullscreen = !option_fullscreen;
				options[main_menu_pages.options_visual][3][menu_option_data.text] = "Fullscreen: " + string(boolean_string_onoff(option_fullscreen));
			}
		});
		
		menu_option_add(_page, 4, "Framerate: " + string(global.framerate_list[option_framerate]), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead))
			{
				option_framerate--;
				if (option_framerate < 0)
					option_framerate = array_length(global.framerate_list) - 1;
				options[main_menu_pages.options_visual][4][menu_option_data.text] = "Framerate: " + string(global.framerate_list[option_framerate]);
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				option_framerate++;
				if (option_framerate >= array_length(global.framerate_list))
					option_framerate = 0;
				options[main_menu_pages.options_visual][4][menu_option_data.text] = "Framerate: " + string(global.framerate_list[option_framerate]);
			}
		});
		
		menu_option_add(_page, 5, "Vsync: " + string(boolean_string_onoff(option_vsync)), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead) || input_check_pressed("right", global.player_lead))
			{
				option_vsync = !option_vsync;
				options[main_menu_pages.options_visual][5][menu_option_data.text] = "Vsync: " + string(boolean_string_onoff(option_vsync));
			}
		});
		
		menu_option_add(_page, 6, "Screen Shake: " + string(boolean_string_onoff(option_screenshake)), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead) || input_check_pressed("right", global.player_lead))
			{
				option_screenshake = !option_screenshake;
				options[main_menu_pages.options_visual][6][menu_option_data.text] = "Screen Shake: " + string(boolean_string_onoff(option_screenshake));
			}
		});
		
		menu_option_add(_page, 7, "Background Blur: " + string(boolean_string_onoff(option_background)), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead) || input_check_pressed("right", global.player_lead))
			{
				option_background = !option_background;
				options[main_menu_pages.options_visual][7][menu_option_data.text] = "Background Blur: " + string(boolean_string_onoff(option_background));
			}
		});
		
		menu_option_add(_page, 8, "Screen Shader: " + string(global.shaders_list[option_shader][1]), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead))
			{
				option_shader--;
				if (option_shader < 0)
					option_shader = array_length(global.shaders_list) - 1;
				options[main_menu_pages.options_visual][8][menu_option_data.text] = "Screen Shader: " + string(global.shaders_list[option_shader][1]);
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				option_shader++;
				if (option_shader >= array_length(global.shaders_list))
					option_shader = 0;
				options[main_menu_pages.options_visual][8][menu_option_data.text] = "Screen Shader: " + string(global.shaders_list[option_shader][1]);
			}
		});
		
		menu_option_add(_page, 9, "Motion sickness prevention: " + string(boolean_string_onoff(option_motion_sickness)), function()
		{
			main_text = "Options - Visual";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				visual_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 1;
				visual_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead) || input_check_pressed("right", global.player_lead))
			{
				option_motion_sickness = !option_motion_sickness;
				options[main_menu_pages.options_visual][9][menu_option_data.text] = "Motion sickness prevention: " + string(boolean_string_onoff(option_motion_sickness));
			}
		})
	#endregion
	
	#region Audio
		_page = main_menu_pages.options_audio;
		/// @function audio_options_set
		audio_options_set = function()
		{
            volume_master_set(option_volume_master);
			volume_music_set(option_volume_music);
			volume_sfx_set(option_volume_sfx);
			sfx_play_global(sfx_ding);
			audio_save();
		}
		
		/// @function audio_options_reset
		audio_options_reset = function()
		{
            option_volume_master = volume_master_get();
			option_volume_music = volume_music_get();
			option_volume_sfx = volume_sfx_get();
		}
		
		audio_options_reset();
		
        menu_option_add(_page, 0, "Master Volume: " + string(round(option_volume_master * 100)) + "%", function() 
        {
            main_text = "Options - Audio";
            bottom_text = "Confirm to save changes";
            if (input_check_pressed("confirm", global.player_lead))
            {
                audio_options_set();
            }
            else if (input_check_pressed("deny", global.player_lead))
            {
                page = main_menu_pages.options;
                option = 2;
                audio_options_reset();
            }
            else if (input_check_pressed("left", global.player_lead))
            {
                option_volume_master = max(option_volume_master - 0.05, 0);
                options[main_menu_pages.options_audio][0][menu_option_data.text] = "Master Volume: " + string(round(option_volume_master * 100)) + "%";
            }
            else if (input_check_pressed("right", global.player_lead))
            {
                option_volume_master = min(option_volume_master + 0.05, 1);
                options[main_menu_pages.options_audio][0][menu_option_data.text] = "Master Volume: " + string(round(option_volume_master * 100)) + "%";
            }
        });
        
        menu_option_add(_page, 1, "Music Volume: " + string(round(option_volume_music * 100)) + "%", function()
		{
			main_text = "Options - Audio";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				audio_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 2;
				audio_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead))
			{
				option_volume_music = max(option_volume_music - 0.05, 0);
                options[main_menu_pages.options_audio][1][menu_option_data.text] = "Music Volume: " + string(round(option_volume_music * 100)) + "%";
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				option_volume_music = min(option_volume_music + 0.05, 1);
                options[main_menu_pages.options_audio][1][menu_option_data.text] = "Music Volume: " + string(round(option_volume_music * 100)) + "%";
			}
		});
		
        menu_option_add(_page, 2, "SFX Volume: " + string(round(option_volume_sfx * 100)) + "%", function()
		{
			main_text = "Options - Audio";
			bottom_text = "Confirm to save changes";
			if (input_check_pressed("confirm", global.player_lead))
			{
				audio_options_set();
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 2;
				audio_options_reset();
			}
			else if (input_check_pressed("left", global.player_lead))
			{
				option_volume_sfx = max(option_volume_sfx - 0.05, 0);
                options[main_menu_pages.options_audio][2][menu_option_data.text] = "SFX Volume: " + string(round(option_volume_sfx * 100)) + "%";
			}
			else if (input_check_pressed("right", global.player_lead))
			{
				option_volume_sfx = min(option_volume_sfx + 0.05, 1);
                options[main_menu_pages.options_audio][2][menu_option_data.text] = "SFX Volume: " + string(round(option_volume_sfx * 100)) + "%";
			}
		});
	#endregion
	
	#region Debug
		_page = main_menu_pages.options_debug;
		menu_option_add(_page, 0, "Level Select", function()
		{
			main_text = "Options - Debug";
			if (input_check_pressed("confirm", global.player_lead))
			{
				page = main_menu_pages.options_debug_levelselect;
				index = 0;
				option = 0;
			}
			else if (input_check_pressed("deny", global.player_lead))
			{
				page = main_menu_pages.options;
				option = 3;
			}
		});
		
		#region Debug Level Select
			_page = main_menu_pages.options_debug_levelselect;
	
			menu_option_add(_page, 0, "Level Select", function()
			{
				var _index;
				var _name_world, _name_level, _room;
				var _level_max = array_length(global.level_list[level_lists.normal]);
		
				main_text = "All Levels";
		
				if (input_check_pressed("left", global.player_lead))
				{
					global.level_demo--;
					if (global.level_demo < 0)
						global.level_demo = _level_max - 1;
				}
				else if (input_check_pressed("right", global.player_lead))
				{
					global.level_demo = (global.level_demo + 1) mod _level_max;
				}
		
				_index = global.level_list[level_lists.normal][global.level_demo];
				_name_world = level_name_world_get(_index);
				_name_level = level_name_get(_index);
				_room = level_room_get(_index);
		
				options[main_menu_pages.options_debug_levelselect][0][menu_option_data.text] = "<-- Level " + string(_index) + " -->"
				+ "\n" + string(_name_world) + "\n" + string(_name_level);
		
				if (input_check_pressed("confirm", global.player_lead))
				{
					global.game_mode = game_modes.free_play;
					global.level_id = _index;
					spawn_point_set(_room);
					instance_create(obj_character_select);
				}
				else if (input_check_pressed("deny", global.player_lead))
				{
					page = main_menu_pages.main;
					option = 0;
				}
			});
		#endregion
	#endregion
#endregion
