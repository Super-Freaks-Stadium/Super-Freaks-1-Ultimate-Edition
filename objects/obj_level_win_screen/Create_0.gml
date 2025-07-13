/// @description 

var _i = 0;
var _level_save = global.level_save_data_list[global.story_mode][global.level_id];
trophy_count = 0;
perfect_flag = true;
clear_text = "clear";

victory_quote = global.victory_quotes[irandom(array_length(global.victory_quotes) - 1)];

screen_shake(0, 0);
global.frame_machine_level.pause = true;
global.frame_machine_player.pause = true;

// Inherit the parent event
event_inherited();

animate_previous = 0;
animate = 0;

depth = -9998;
state_next_set(0);
game_timer_pause(true);
music_set(msc_victory);

_level_save.trophies = (_level_save.trophies | global.trophies);

for (_i = 0; _i < global.trophies_max; ++_i)
{
	if (!bit_get(global.trophies, _i))
		perfect_flag = false;
}
