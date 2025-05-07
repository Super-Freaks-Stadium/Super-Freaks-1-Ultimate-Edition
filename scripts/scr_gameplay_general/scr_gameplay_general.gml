enum game_states
{
	NA = 0,
	gameplay,
	worldmap,
	cutscene,
}

enum game_modes
{
	normal = 0,
	title,
	museum,
	free_play,
	randomizer,
	speedrun,
	boss_rush,
}

enum story_modes
{
	super_freaks = 0,
	kranion,
	swordsman,
	anti_freaks,
	
	count,
	
	final,
}

enum speedrun_modes
{
	normal = 0,
	crazy,
	ludicrous,
	insane,
	freaky,
	kranion,
	mystic,
	adventure,
	secret,
	ultimate,
}

/// @function gameplay_init
function gameplay_init()
{
	global.story_mode = story_modes.super_freaks;
    global.turbo = 
    {
        mode: false,
        time: 30,
        time_visual: 30,
        pause: false,
        punish: 1,
    };
	
	collider_collision_global_init();
	difficulty_init();
	hashmap_collision_init();
	hitbox_collision_stored_init();
	game_mode_set();
	game_pause_set(false);
	game_state_set();
	scoring_init();
	levels_init();
	museum_init();
	players_init();
	spawn_point_init();
	tile_data_arrays_init();
	tile_data_array_level_default();
	triggers_init();
	trophies_init();
	unlocks_init();
	water_init();
	zones_init();
	
	global.fast_forward_multiplier = 0;
	
	global.boss_phase = 0;
	
	global.redblueplatformswap = false;
	global.redblueplatformtimer = 0;
	
	global.lightbulb_timer = 0;
}

/// @function game_state_set
/// @param {int} _game_state = game_states.NA
function game_state_set(_game_state = game_states.NA)
{
	global.game_state = _game_state;
	
	gml_pragma("forceinline");
}

/// @function game_state_name_get
function game_state_name_get()
{
	var _string = "";
	
	switch (global.game_state)
	{
		case game_states.gameplay:
			_string = "Gameplay";
			break;
		case game_states.cutscene:
			_string = "Cutscene";
			break;
		case game_states.worldmap:
			_string = "World Map";
			break;
		default:
			_string = "N/A";
			break;
	}
	
	return _string;
	
	gml_pragma("forceinline");
}

/// @function game_mode_set
/// @param {int} _game_mode = game_modes.normal
function game_mode_set(_game_mode = game_modes.normal)
{
	global.game_mode = _game_mode;
	global.game_mode_subtype = 0;
	
	gml_pragma("forceinline");
}

/// @function game_mode_name_get
function game_mode_name_get()
{
	var _string = "";
	
	switch (global.game_mode)
	{
		case game_modes.normal:
			_string = "Normal";
			break;
		case game_modes.free_play:
			_string = "Free Play";
			break;
		case game_modes.randomizer:
			_string = "Randomizer";
			break;
		case game_modes.speedrun:
			_string = "Speedrun";
			break;
		case game_modes.boss_rush:
			_string = "Boss Rush";
			break;
		default:
			_string = "N/A";
			break;
	}
	
	return _string;
	
	gml_pragma("forceinline");
}

/// @function story_mode_name_get
function story_mode_name_get()
{
	var _string = "";
	
	switch (global.story_mode)
	{
		case story_modes.super_freaks:
			_string = "Super Freaks";
			break;
		case story_modes.kranion:
			_string = "Bad Guys";
			break;
		case story_modes.swordsman:
			_string = "Uncle Swordsman";
			break;
		case story_modes.anti_freaks:
			_string = "Anti Freaks";
			break;
		default:
			_string = "N/A";
			break;
	}
	
	return _string;
	
	gml_pragma("forceinline");
}