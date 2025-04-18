/// @description 

instance_destroy();
turbo_time_add(5);
switch (global.story_mode)
{
	case story_modes.super_freaks:
		sfx_play_global(sfx_heart);
		global.hearts = min(global.hearts + 1, hearts_maximum_get());
		break;
	case story_modes.kranion:
		sfx_play_global(sfx_heart);
		player_meter_collect(15);
		break;
	case story_modes.swordsman:
	case story_modes.anti_freaks:
		sfx_play_global(sfx_heart);
		player_meter_collect(20);
		break;
}