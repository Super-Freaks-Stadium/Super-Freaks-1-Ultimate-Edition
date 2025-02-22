enum level_data
{
	status = 0,
	trophies,
	trophy_count,
	room,
	name_world,
	name_level,
	unlock_function,
	next_level,
	cutscene_room_begin,
	cutscene_room_end,
}

enum level_cutscene_data
{
	before = 0,
	after = 1,
}

enum level_status
{
	locked = 0,
	open,
	clear_normal,
	clear_perfect,
}

enum level_ids
{
	test = 0,
	
	level_stadium,
	level_supersecret,
	level_supersecret_boss,
	
	level_normal_fruit,
	level_normal_sky,
	level_normal_fruit_secret,
	level_normal_boss,
	
	level_crazy_toy,
	level_crazy_park,
	level_crazy_toy_secret,
	level_crazy_boss,
	
	level_ludicrous_barrel,
	level_ludicrous_water,
	level_ludicrous_barrel_secret,
	level_ludicrous_boss,
	
	level_insane_hippie,
	level_insane_lightning,
	level_insane_hippie_secret,
	level_insane_boss,
	
	level_freaky_ice,
	level_freaky_star,
	level_freaky_ice_secret,
	level_freaky_boss,
	
	level_kranion_conveyor,
	level_kranion_moon,
	level_kranion_conveyor_secret,
	level_kranion_moon_secret,
	level_kranion_boss_secret,
	level_kranion_boss,
	level_kranion_final_boss,
	
	level_apex,
	
	level_special_2006,
	level_special_sticky,
	
	count,
}

enum level_lists
{
	normal = 0,
	completed,
	speedrun_normal,
	speedrun_crazy,
	speedrun_ludicrous,
	speedrun_insane,
	speedrun_freaky,
	speedrun_kranion,
	speedrun_stadium,
	speedrun_adventure,
	speedrun_secret,
	speedrun_ultimate,
	boss,
	demo,
	
	count,
}

/// @function level
/// @param {String} _name_level = ""
/// @param {String} _name_world = ""
/// @param {Real} _room = rm_level_parent
/// @param {Real} _trophies_max = 3
/// @param {Function} _unlock_method = function(){return false;}
function level(_name_level = "", _name_world = "", _room = rm_level_parent, _trophies_max = 3, _unlock_method = function(){return false;}) constructor
{
	name_level = _name_level;
	name_world = _name_world;
	room_starting = _room;
	trophies_max = _trophies_max;
	unlock_method = _unlock_method;
}

/// @function level_save_data
function level_save_data() constructor
{
	status = level_status.locked;
	trophies = 0;
}

/// @function levels_init
function levels_init()
{
	var _level_list, _i, _j;
	
	global.levels = [];
	global.level_save_data_list = [];
	global.level_list = [];
	global.level_cutscene_list = [];
	global.current_level_list = [];
	global.level_id = 1;
	global.level_demo = 0;
	
	for (_i = 0; _i < level_lists.count; ++_i)
	{
		array_push(global.level_list, []);
	}
	for (_i = 0; _i < level_ids.count; ++_i)
	{
		global.levels[_i] = new level();
		array_push(global.level_list[level_lists.normal], _i);
	}
	for (_i = 0; _i < story_modes.count; ++_i)
	{
		global.level_cutscene_list[_i] = array_create(level_ids.count);
		for (_j = 0; _j < level_ids.count; ++_j)
		{
			global.level_save_data_list[_i][_j] = new level_save_data();
			global.level_cutscene_list[_i][_j][level_cutscene_data.before] = undefined;
			global.level_cutscene_list[_i][_j][level_cutscene_data.after] = undefined;
		}
		global.level_save_data_list[_i][level_ids.level_stadium].status = level_status.open;
	}
	
	level_create(level_ids.test, rm_test_1, "Test World", "Test Level");
	
	level_create(level_ids.level_stadium, rm_stadium_1, "Mystic Island", "Super Freaks Stadium",,, spr_worldmap_pic_stadium);
	level_create(level_ids.level_supersecret, rm_supersecret_1, "Mystic Island", "Exciting Encore", function()
	{
		var _i;
		
		if (!level_perfect_get(level_ids.level_stadium))
			return false;
		
		for (_i = level_ids.level_normal_fruit; _i <= level_ids.level_kranion_final_boss; ++_i)
		{
			if (!level_perfect_get(_i))
				return false;
		}
		
		return true;
	}, 0, spr_worldmap_pic_encore);
	level_create(level_ids.level_supersecret_boss, rm_boss_antifreaks, "Mystic Island", "Vs Anti Freaks", function()
	{
		return level_complete_get(level_ids.level_supersecret);
	}, 0, spr_worldmap_pic_antifreaks);
	with (global.levels[level_ids.level_supersecret_boss])
	{
		sprite_index = [spr_worldmap_pic_antifreaks, spr_worldmap_pic_antifreaks, spr_worldmap_pic_shadow, spr_worldmap_pic_antifreaks];
		name_level = ["Vs Anti Freaks", "Vs Anti Freaks", "Vs The Shadow", "Vs Anti Freaks"];
	}
	
	//Normal World
	level_create(level_ids.level_normal_fruit, rm_fruit_1, "Normal World", "Fruit Juice Factory", function()
	{
		return level_complete_get(level_ids.level_stadium);
	},, spr_worldmap_pic_fruit);
	level_create(level_ids.level_normal_sky, rm_skyway_1, "Normal World", "Skyway Highway", function()
	{
		return level_complete_get(level_ids.level_stadium);
	},, spr_worldmap_pic_skyway);
	level_create(level_ids.level_normal_fruit_secret, rm_secretfruit_1, "Normal World", "Fruit Juice Secret", function()
	{
		return level_perfect_get(level_ids.level_normal_fruit) && level_perfect_get(level_ids.level_normal_sky);
	},, spr_worldmap_pic_fruit_secret);
	level_create(level_ids.level_normal_boss, rm_boss_cinge, "Normal World", "Vs Cinge", function()
	{
		return (level_complete_get(level_ids.level_normal_fruit) && level_complete_get(level_ids.level_normal_sky));
	}, 0, spr_worldmap_pic_cinge);
	
	//Crazy World
	level_create(level_ids.level_crazy_toy, rm_toy_1, "Crazy World", "Toy Block Bridge", function()
	{
		return level_complete_get(level_ids.level_normal_boss);
	},, spr_worldmap_pic_toyblock);
	level_create(level_ids.level_crazy_park, rm_park_1, "Crazy World", "Playful Park", function()
	{
		return level_complete_get(level_ids.level_normal_boss);
	},, spr_worldmap_pic_park);
	level_create(level_ids.level_crazy_toy_secret, rm_secrettoy_1, "Crazy World", "Toy Block Secret", function()
	{
		return level_perfect_get(level_ids.level_crazy_toy) && level_perfect_get(level_ids.level_crazy_park);
	},, spr_worldmap_pic_toyblock_secret);
	level_create(level_ids.level_crazy_boss, rm_boss_milkman, "Crazy World", "Vs Milk Man", function()
	{
		return (level_complete_get(level_ids.level_crazy_toy) && level_complete_get(level_ids.level_crazy_park));
	}, 0, spr_worldmap_pic_milkman);
	
	//Ludicrous World
	level_create(level_ids.level_ludicrous_barrel, rm_canyon_1, "Ludicrous World", "Barrel Canyon Cliffs", function()
	{
		return level_complete_get(level_ids.level_crazy_boss);
	},, spr_worldmap_pic_barrel);
	level_create(level_ids.level_ludicrous_water, rm_ship_1, "Ludicrous World", "Shipwreck Poopdeck", function()
	{
		return level_complete_get(level_ids.level_crazy_boss);
	},, spr_worldmap_pic_shipwreck);
	level_create(level_ids.level_ludicrous_barrel_secret, rm_secretcanyon_1, "Ludicrous World", "Barrel Secret", function()
	{
		return (level_perfect_get(level_ids.level_ludicrous_barrel) && level_perfect_get(level_ids.level_ludicrous_water));
	},, spr_worldmap_pic_barrel_secret);
	level_create(level_ids.level_ludicrous_boss, rm_boss_megaklaw, "Ludicrous World", "Vs Mega Klaw", function()
	{
		return (level_complete_get(level_ids.level_ludicrous_barrel) && level_complete_get(level_ids.level_ludicrous_water));
	}, 0, spr_worldmap_pic_megaklaw);
	with (global.levels[level_ids.level_ludicrous_boss])
	{
		sprite_index = [spr_worldmap_pic_megaklaw, spr_worldmap_pic_megaklaw, spr_worldmap_pic_spike, spr_worldmap_pic_spike];
		room_starting = [rm_boss_megaklaw, rm_boss_megaklaw, rm_boss_spike, rm_boss_spike];
		name_level = ["Vs Mega Klaw", "Vs Mega Klaw", "Vs Spike", "Vs Spike"];
	}
	
	//Insane World
	level_create(level_ids.level_insane_hippie, rm_hippie_1, "Insane World", "Forever Flowery Fields", function()
	{
		return level_complete_get(level_ids.level_ludicrous_boss);
	},, spr_worldmap_pic_flower);
	level_create(level_ids.level_insane_lightning, rm_lightning_1, "Insane World", "Lightning Rod Lake", function()
	{
		return level_complete_get(level_ids.level_ludicrous_boss);
	},, spr_worldmap_pic_lightning);
	level_create(level_ids.level_insane_hippie_secret, rm_secrethippie_1, "Insane World", "Flowery Secret", function()
	{
		return (level_perfect_get(level_ids.level_insane_hippie) && level_perfect_get(level_ids.level_insane_lightning));
	},, spr_worldmap_pic_flower_secret);
	level_create(level_ids.level_insane_boss, rm_boss_larry, "Insane World", "Vs Larry McPeel", function()
	{
		return (level_complete_get(level_ids.level_insane_hippie) && level_complete_get(level_ids.level_insane_lightning));
	}, 0, spr_worldmap_pic_larry);
	
	//Freaky World
	level_create(level_ids.level_freaky_ice, rm_ice_1, "Freaky World", "Cool n Chill Caverns", function()
	{
		return level_complete_get(level_ids.level_insane_boss);
	},, spr_worldmap_pic_cool);
	level_create(level_ids.level_freaky_star, rm_star_1, "Freaky World", "Starscraper", function()
	{
		return level_complete_get(level_ids.level_insane_boss);
	},, spr_worldmap_pic_starscraper);
	level_create(level_ids.level_freaky_ice_secret, rm_secretice_1, "Freaky World", "Cool n Chill Secret", function()
	{
		return (level_perfect_get(level_ids.level_freaky_ice) && level_perfect_get(level_ids.level_freaky_star));
	},, spr_worldmap_pic_cool_secret);
	level_create(level_ids.level_freaky_boss, rm_boss_francis, "Freaky World", "Vs Francis", function()
	{
		return (level_complete_get(level_ids.level_freaky_ice) && level_complete_get(level_ids.level_freaky_star));
	}, 0, spr_worldmap_pic_francis);
	with (global.levels[level_ids.level_freaky_boss])
	{
		sprite_index = [spr_worldmap_pic_francis, spr_worldmap_pic_wartnose, spr_worldmap_pic_wartnose, spr_worldmap_pic_francis];
		room_starting = [rm_boss_francis, rm_boss_wartnose, rm_boss_wartnose, rm_boss_francis];
		name_level = ["Vs Francis", "Vs Wartnose", "Vs Wartnose", "Vs Francis"];
	}
	
	//Castle Kranion
	level_create(level_ids.level_kranion_conveyor, rm_castle_1, "Castle Kranion", "Conveyor Castle", function()
	{
		return level_complete_get(level_ids.level_freaky_boss);
	},, spr_worldmap_pic_conveyor);
	level_create(level_ids.level_kranion_moon, rm_moon_1, "Castle Kranion", "Mecha Moon", function()
	{
		return level_complete_get(level_ids.level_freaky_boss);
	},, spr_worldmap_pic_moon);
	level_create(level_ids.level_kranion_conveyor_secret, rm_secretcastle_1, "Castle Kranion", "Conveyor Secret", function()
	{
		return (level_perfect_get(level_ids.level_kranion_conveyor) && level_perfect_get(level_ids.level_kranion_moon));
	},, spr_worldmap_pic_conveyor_secret);
	level_create(level_ids.level_kranion_moon_secret, rm_secretmoon_1, "Castle Kranion", "Moon Secret", function()
	{
		return level_complete_get(level_ids.level_normal_fruit_secret)
		&& level_complete_get(level_ids.level_crazy_toy_secret)
		&& level_complete_get(level_ids.level_ludicrous_barrel_secret)
		&& level_complete_get(level_ids.level_insane_hippie_secret)
		&& level_complete_get(level_ids.level_freaky_ice_secret)
		&& level_complete_get(level_ids.level_kranion_conveyor_secret);
	},, spr_worldmap_pic_moon_secret);
	level_create(level_ids.level_kranion_boss_secret, rm_boss_secretkranion, "Castle Kranion", "Kranion's Secret Weapon", function()
	{
		return level_complete_get(level_ids.level_kranion_moon_secret);
	}, 0, spr_worldmap_pic_kranion_secret);
	level_create(level_ids.level_kranion_boss, rm_boss_dino, "Castle Kranion", "Vs Dino", function()
	{
		return (level_complete_get(level_ids.level_kranion_conveyor) && level_complete_get(level_ids.level_kranion_moon));
	}, 0, spr_worldmap_pic_dino);
	level_create(level_ids.level_kranion_final_boss, rm_boss_kranion, "Castle Kranion", "Vs Kranion", function()
	{
		return level_complete_get(level_ids.level_kranion_boss);
	}, 0, spr_worldmap_pic_kranion);
	with (global.levels[level_ids.level_kranion_final_boss])
	{
		sprite_index = [spr_worldmap_pic_kranion, spr_worldmap_pic_cranion, spr_worldmap_pic_marrowprime, spr_worldmap_pic_kranion];
		name_level = ["Vs Kranion", "Vs ???", "Vs Marrow Prime", "Vs Kranion Minus"];
	}
	
	//Final Battle
	level_create(level_ids.level_apex, rm_boss_apex, "Final Battle", "Vs Apex", function()
	{
		return false;
	}, 0);
	
	//Special Stages
	level_create(level_ids.level_special_2006, rm_comingsoon, "Special Stage", "2006 Medley", function()
	{
		return false;
	}, 0);
	level_create(level_ids.level_special_sticky, rm_comingsoon, "Special Stage", "Vs Sticky", function()
	{
		return false;
	}, 0);
	
	#region Level Lists
		#region Normal Run
			_level_list = global.level_list[level_lists.speedrun_normal];
			
			array_push(_level_list, level_ids.level_normal_fruit);
			array_push(_level_list, level_ids.level_normal_sky);
			array_push(_level_list, level_ids.level_normal_fruit_secret);
			array_push(_level_list, level_ids.level_normal_boss);
		#endregion
		
		#region Crazy Run
			_level_list = global.level_list[level_lists.speedrun_crazy];
			
			array_push(_level_list, level_ids.level_crazy_toy);
			array_push(_level_list, level_ids.level_crazy_park);
			array_push(_level_list, level_ids.level_crazy_toy_secret);
			array_push(_level_list, level_ids.level_crazy_boss);
		#endregion
		
		#region Ludicrous Run
			_level_list = global.level_list[level_lists.speedrun_ludicrous];
			
			array_push(_level_list, level_ids.level_ludicrous_barrel);
			array_push(_level_list, level_ids.level_ludicrous_water);
			array_push(_level_list, level_ids.level_ludicrous_barrel_secret);
			array_push(_level_list, level_ids.level_ludicrous_boss);
		#endregion
		
		#region Insane Run
			_level_list = global.level_list[level_lists.speedrun_insane];
			
			array_push(_level_list, level_ids.level_insane_hippie);
			array_push(_level_list, level_ids.level_insane_lightning);
			array_push(_level_list, level_ids.level_insane_hippie_secret);
			array_push(_level_list, level_ids.level_insane_boss);
		#endregion
		
		#region Freaky Run
			_level_list = global.level_list[level_lists.speedrun_freaky];
			
			array_push(_level_list, level_ids.level_freaky_ice);
			array_push(_level_list, level_ids.level_freaky_star);
			array_push(_level_list, level_ids.level_freaky_ice_secret);
			array_push(_level_list, level_ids.level_freaky_boss);
		#endregion
		
		#region Kranion Run
			_level_list = global.level_list[level_lists.speedrun_kranion];
			
			array_push(_level_list, level_ids.level_kranion_conveyor);
			array_push(_level_list, level_ids.level_kranion_moon);
			array_push(_level_list, level_ids.level_kranion_conveyor_secret);
			array_push(_level_list, level_ids.level_kranion_moon_secret);
			array_push(_level_list, level_ids.level_kranion_boss_secret);
			array_push(_level_list, level_ids.level_kranion_boss);
			array_push(_level_list, level_ids.level_kranion_final_boss);
		#endregion
		
		#region Stadium Run
			_level_list = global.level_list[level_lists.speedrun_stadium];
			
			array_push(_level_list, level_ids.level_stadium);
			array_push(_level_list, level_ids.level_supersecret);
			array_push(_level_list, level_ids.level_supersecret_boss);
		#endregion
	
		#region Adventure Run
			_level_list = global.level_list[level_lists.speedrun_adventure];
			
			array_push(_level_list, level_ids.level_stadium);
			array_push(_level_list, level_ids.level_normal_fruit);
			array_push(_level_list, level_ids.level_normal_sky);
			array_push(_level_list, level_ids.level_normal_boss);
			array_push(_level_list, level_ids.level_crazy_toy);
			array_push(_level_list, level_ids.level_crazy_park);
			array_push(_level_list, level_ids.level_crazy_boss);
			array_push(_level_list, level_ids.level_ludicrous_barrel);
			array_push(_level_list, level_ids.level_ludicrous_water);
			array_push(_level_list, level_ids.level_ludicrous_boss);
			array_push(_level_list, level_ids.level_insane_hippie);
			array_push(_level_list, level_ids.level_insane_lightning);
			array_push(_level_list, level_ids.level_insane_boss);
			array_push(_level_list, level_ids.level_freaky_ice);
			array_push(_level_list, level_ids.level_freaky_star);
			array_push(_level_list, level_ids.level_freaky_boss);
			array_push(_level_list, level_ids.level_kranion_conveyor);
			array_push(_level_list, level_ids.level_kranion_moon);
			array_push(_level_list, level_ids.level_kranion_boss);
			array_push(_level_list, level_ids.level_kranion_final_boss);
		#endregion
		
		#region Secret Run
			_level_list = global.level_list[level_lists.speedrun_secret];
			
			array_push(_level_list, level_ids.level_normal_fruit_secret);
			array_push(_level_list, level_ids.level_crazy_toy_secret);
			array_push(_level_list, level_ids.level_ludicrous_barrel_secret);
			array_push(_level_list, level_ids.level_insane_hippie_secret);
			array_push(_level_list, level_ids.level_freaky_ice_secret);
			array_push(_level_list, level_ids.level_kranion_conveyor_secret);
			array_push(_level_list, level_ids.level_kranion_moon_secret);
			array_push(_level_list, level_ids.level_kranion_boss_secret);
		#endregion
		
		#region Ultimate Run
			_level_list = global.level_list[level_lists.speedrun_ultimate];
		
			array_push(_level_list, level_ids.level_stadium);
			array_push(_level_list, level_ids.level_normal_fruit);
			array_push(_level_list, level_ids.level_normal_sky);
			array_push(_level_list, level_ids.level_normal_fruit_secret);
			array_push(_level_list, level_ids.level_normal_boss);
			array_push(_level_list, level_ids.level_crazy_toy);
			array_push(_level_list, level_ids.level_crazy_park);
			array_push(_level_list, level_ids.level_crazy_toy_secret);
			array_push(_level_list, level_ids.level_crazy_boss);
			array_push(_level_list, level_ids.level_ludicrous_barrel);
			array_push(_level_list, level_ids.level_ludicrous_water);
			array_push(_level_list, level_ids.level_ludicrous_barrel_secret);
			array_push(_level_list, level_ids.level_ludicrous_boss);
			array_push(_level_list, level_ids.level_insane_hippie);
			array_push(_level_list, level_ids.level_insane_lightning);
			array_push(_level_list, level_ids.level_insane_hippie_secret);
			array_push(_level_list, level_ids.level_insane_boss);
			array_push(_level_list, level_ids.level_freaky_ice);
			array_push(_level_list, level_ids.level_freaky_star);
			array_push(_level_list, level_ids.level_freaky_ice_secret);
			array_push(_level_list, level_ids.level_freaky_boss);
			array_push(_level_list, level_ids.level_kranion_conveyor);
			array_push(_level_list, level_ids.level_kranion_moon);
			array_push(_level_list, level_ids.level_kranion_conveyor_secret);
			array_push(_level_list, level_ids.level_kranion_moon_secret);
			array_push(_level_list, level_ids.level_kranion_boss_secret);
			array_push(_level_list, level_ids.level_kranion_boss);
			array_push(_level_list, level_ids.level_kranion_final_boss);
			array_push(_level_list, level_ids.level_supersecret);
			array_push(_level_list, level_ids.level_supersecret_boss);
		#endregion
		
		#region Boss Rush
			_level_list = global.level_list[level_lists.boss];
		
			array_push(_level_list, level_ids.level_normal_boss);
			array_push(_level_list, level_ids.level_crazy_boss);
			array_push(_level_list, level_ids.level_ludicrous_boss);
			array_push(_level_list, level_ids.level_insane_boss);
			array_push(_level_list, level_ids.level_freaky_boss);
			array_push(_level_list, level_ids.level_kranion_boss_secret);
			array_push(_level_list, level_ids.level_kranion_boss);
			array_push(_level_list, level_ids.level_kranion_final_boss);
			array_push(_level_list, level_ids.level_supersecret_boss);
		#endregion
		
		#region Demo
			_level_list = global.level_list[level_lists.demo];
			
			array_push(_level_list, level_ids.level_stadium);
			array_push(_level_list, level_ids.level_normal_fruit);
			array_push(_level_list, level_ids.level_normal_sky);
			array_push(_level_list, level_ids.level_normal_fruit_secret);
			array_push(_level_list, level_ids.level_normal_boss);
			array_push(_level_list, level_ids.level_crazy_toy);
			array_push(_level_list, level_ids.level_crazy_park);
			array_push(_level_list, level_ids.level_crazy_toy_secret);
			array_push(_level_list, level_ids.level_crazy_boss);
			array_push(_level_list, level_ids.level_ludicrous_barrel);
			array_push(_level_list, level_ids.level_ludicrous_barrel_secret);
		#endregion
	#endregion
	
	levels_load();
	
	worldmap_init();
	
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_stadium][level_cutscene_data.before] = rm_cutscene_intro_superfreaks;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_stadium][level_cutscene_data.after] = rm_cutscene_antifreaks_intro;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_ludicrous_barrel][level_cutscene_data.before] = rm_cutscene_xfreaks;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_freaky_ice][level_cutscene_data.before] = rm_cutscene_freak_fathers;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_kranion_conveyor][level_cutscene_data.before] = rm_cutscene_castle;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_kranion_boss_secret][level_cutscene_data.before] = rm_cutscene_skullmobile;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_kranion_boss][level_cutscene_data.before] = rm_cutscene_dino;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_kranion_final_boss][level_cutscene_data.before] = rm_cutscene_kranion;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_kranion_final_boss][level_cutscene_data.after] = rm_cutscene_ending_normal;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_supersecret][level_cutscene_data.before] = rm_cutscene_encore;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_supersecret_boss][level_cutscene_data.before] = rm_cutscene_antifreaks_battle;
	global.level_cutscene_list[story_modes.super_freaks][level_ids.level_supersecret_boss][level_cutscene_data.after] = rm_cutscene_ending_secret;
	
	global.level_cutscene_list[story_modes.kranion][level_ids.level_stadium][level_cutscene_data.before] = rm_cutscene_intro_kranion;
	global.level_cutscene_list[story_modes.kranion][level_ids.level_stadium][level_cutscene_data.after] = rm_cutscene_antifreaks_intro_villains;
	global.level_cutscene_list[story_modes.kranion][level_ids.level_freaky_ice][level_cutscene_data.before] = rm_cutscene_freak_fathers_villains;
	global.level_cutscene_list[story_modes.kranion][level_ids.level_kranion_final_boss][level_cutscene_data.before] = rm_cutscene_cranion;
	global.level_cutscene_list[story_modes.kranion][level_ids.level_kranion_final_boss][level_cutscene_data.after] = rm_cutscene_ending_normal_villains;
	global.level_cutscene_list[story_modes.kranion][level_ids.level_supersecret_boss][level_cutscene_data.after] = rm_cutscene_ending_secret_villains;
	
	global.level_cutscene_list[story_modes.swordsman][level_ids.level_stadium][level_cutscene_data.before] = rm_cutscene_intro_swordsman;
	global.level_cutscene_list[story_modes.swordsman][level_ids.level_stadium][level_cutscene_data.after] = rm_cutscene_after_stadium_swordsman;
	global.level_cutscene_list[story_modes.swordsman][level_ids.level_ludicrous_barrel][level_cutscene_data.before] = rm_cutscene_training_swordsman;
	global.level_cutscene_list[story_modes.swordsman][level_ids.level_freaky_ice][level_cutscene_data.before] = rm_cutscene_freak_fathers_swordsman;
	global.level_cutscene_list[story_modes.swordsman][level_ids.level_kranion_final_boss][level_cutscene_data.before] = rm_cutscene_prime_swordsman;
	global.level_cutscene_list[story_modes.swordsman][level_ids.level_kranion_final_boss][level_cutscene_data.after] = rm_cutscene_ending_normal_swordsman;
	global.level_cutscene_list[story_modes.swordsman][level_ids.level_supersecret_boss][level_cutscene_data.after] = rm_cutscene_ending_secret_swordsman;
}

/// @function levels_save
function levels_save()
{
	var _json = json_stringify(global.level_save_data_list);
	string_save(_json, "Save1/progress_0.save");
}

/// @function levels_load
function levels_load()
{
	var _json;
	var _array;
	var _level, _story;
	
	if (file_exists("Save1/progress_0.save"))
	{
		_json = string_load("Save1/progress_0.save");
		_array = json_parse(_json);
		
		//for (_story = 0; _story < story_modes.count; ++_story)
		for (_story = 0; _story < array_length(_array); ++_story)
		{
			for (_level = 0; _level < array_length(_array[_story]); ++_level)
			{
				global.level_save_data_list[_story][_level] = _array[_story][_level];
			}
		}
		level_complete_list_reset();
	}
}

/// @function level_complete_list_reset
function level_complete_list_reset()
{
	var _i;
	var _level_list = global.level_list[level_lists.completed];
	var _level_status;
	
	array_resize(_level_list, 0);
	
	for (_i = 0; _i < array_length(global.levels); ++_i)
	{
		_level_status = global.level_save_data_list[global.story_mode][_i].status;
		
		if (_level_status == level_status.clear_normal || _level_status == level_status.clear_perfect)
			array_push(_level_list, _i);
	}
}

/// @function level_create_new
/// @param {int} _level_id
/// @param {room} _room = rm_level_parent
/// @param {string} _name_world = ""
/// @param {string} _name_level = ""
/// @param {function} _unlock_method = function(){return false;}
/// @param {int} _trophies_max = 3
/// @param _sprite_index = spr_worldmap_pic_blank
function level_create(_level_id, _room = rm_level_parent, _name_world = "", _name_level = "", _unlock_method = function(){return false;}, _trophies_max = 3, _sprite_index = spr_worldmap_pic_blank)
{
	var _level = global.levels[_level_id];
	
	with (_level)
	{
		name_level = [_name_level, _name_level, _name_level, _name_level];
		name_world = _name_world;
		room_starting = [_room, _room, _room, _room];
		unlock_method = _unlock_method;
		trophies_max = _trophies_max;
		sprite_index = [_sprite_index, _sprite_index, _sprite_index, _sprite_index];
	}
	
	return _level;
}

/// @function levels_unlock
function levels_unlock()
{
	var _i;
	var _status;
	var _func;
	var _level, _level_save;
	
	for (_i = 0; _i < array_length(global.levels); ++_i)
	{
		_level = global.levels[_i];
		_level_save = global.level_save_data_list[global.story_mode][_i];
		_status = level_status_get(_i);
		
		if (_status != level_status.locked)
			continue;
			
		_func = _level.unlock_method;
		
		if (_func() == true)
			_level_save.status = level_status.open;
	}
}

/// @function level_status_get
/// @param {Int} _level_id = global.level_id
/// @param {Int} _story_mode = global.story_mode
function level_status_get(_level_id = global.level_id, _story_mode = global.story_mode)
{
	var _level = global.level_save_data_list[_story_mode][_level_id];
	return _level.status;
	
	gml_pragma("forceinline");
}

/// @function levels_get_all_completed
/// @param {Int} _story_mode = global.story_mode
function levels_get_all_completed(_story_mode = global.story_mode)
{
	var _arr = [];

	for (var i = 0; i < array_length(global.level_save_data_list[_story_mode]); i++)
	{
		if (global.level_save_data_list[_story_mode][i].status > 1) 
			array_push(_arr, i);
	}
	//show_debug_message(_arr);
	return _arr;

	gml_pragma("forceinline");
}

/// @function level_complete_get
/// @param {Int} _level_id = global.level_id
/// @param {Int} _story_mode = global.story_mode
function level_complete_get(_level_id = global.level_id, _story_mode = global.story_mode)
{
	var _level = global.level_save_data_list[_story_mode][_level_id];
	switch (_level.status)
	{
		case level_status.clear_normal:
		case level_status.clear_perfect:
			return true;
			break;
		default:
			return false;
			break;
	}
	
	gml_pragma("forceinline");
}

/// @function level_perfect_get
/// @param {int} _level_id = global.level_id
/// @param {Int} _story_mode = global.story_mode
function level_perfect_get(_level_id = global.level_id, _story_mode = global.story_mode)
{
	var _level = global.level_save_data_list[_story_mode][_level_id];
	switch (_level.status)
	{
		case level_status.clear_perfect:
			return true;
			break;
		default:
			return false;
			break;
	}
	
	gml_pragma("forceinline");
}

/// @function level_room_get
/// @param {Int} _level_id = global.level_id
function level_room_get(_level_id = global.level_id)
{
	var _level = global.levels[_level_id];
	return _level.room_starting[global.story_mode];
	
	gml_pragma("forceinline");
}

/// @function level_name_world_get
/// @param {Int} _level_id = global.level_id
function level_name_world_get(_level_id = global.level_id)
{
	var _level = global.levels[_level_id];
	return _level.name_world;
	
	gml_pragma("forceinline");
}

/// @function level_name_get
/// @param {int} _level_id = global.level_id
/// @param {int} _story_mode = global.story_mode
function level_name_get(_level_id = global.level_id, _story_mode = global.story_mode)
{
	var _level = global.levels[_level_id],
		_name  = _level.name_level[_story_mode];
	
	return _name;
	
	gml_pragma("forceinline");
}

/// @function level_sprite_get
/// @param {int} _level_id = global.level_id
/// @param {int} _story_mode = global.story_mode
function level_sprite_get(_level_id = global.level_id, _story_mode = global.story_mode)
{
	var _level  = global.levels[_level_id],
		_sprite = _level.sprite_index[_story_mode];
	
	return _sprite;
	
	gml_pragma("forceinline");
}

/// @function level_trophies_get
/// @param {Int} _level_id = global.level_id
/// @param {Int} _story_mode = global.story_mode
function level_trophies_get(_level_id = global.level_id, _story_mode = global.story_mode)
{
	var _level = global.level_save_data_list[_story_mode][_level_id];
	return _level.trophies;
	
	gml_pragma("forceinline");
}

/// @function level_trophy_count_max_get
/// @param {int} _level_id = global.level_id
function level_trophy_count_max_get(_level_id = global.level_id)
{
	var _level = global.levels[_level_id];
	return _level.trophies_max;
	
	gml_pragma("forceinline");
}

/// @function level_beat
function level_beat()
{
	switch (global.game_mode)
	{
		case game_modes.randomizer:
			global.level_demo++;
				
			if (global.level_demo >= array_length(global.current_level_list))
			{
				global.level_demo = 0;
				global.current_level_list = array_shuffle(global.current_level_list);
			}
			global.level_id = global.current_level_list[global.level_demo];
			spawn_point_set(level_room_get(global.level_id));
			instance_create_layer(0, 0, "layer_instances", obj_room_transition_level);
			break;
		case game_modes.speedrun:
		case game_modes.boss_rush:
			global.level_demo++;
				
			if (global.level_demo >= array_length(global.current_level_list))
				instance_create_layer(0, 0, "layer_instances", obj_level_win_screen);
			else
			{
				global.level_id = global.current_level_list[global.level_demo];
				spawn_point_set(level_room_get(global.level_id));
				instance_create_layer(0, 0, "layer_instances", obj_room_transition_level);
			}
			break;
		default:
			instance_create_layer(0, 0, "layer_instances", obj_level_win_screen);
			break;
	}
}