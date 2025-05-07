/// @description 

instance_destroy();

if (global.turbo.mode)
{
    turbo_time_add(5);
    sfx_play_global(sfx_clock_collect);
}
else
    sfx_play_global(sfx_heart);

switch (global.story_mode)
{
	case story_modes.super_freaks:
		global.hearts = min(global.hearts + 1, hearts_maximum_get());
		break;
	case story_modes.kranion:
		player_meter_collect(15);
		break;
	case story_modes.swordsman:
	case story_modes.anti_freaks:
		player_meter_collect(20);
		break;
}