/// @description 

instance_destroy();

switch (global.story_mode)
{
	case story_modes.super_freaks:
		global.hearts = max(global.hearts, 10);
		sfx_play_global(sfx_unlock_level);
		break;
	case story_modes.kranion:
	case story_modes.swordsman:
		player_meter_collect(100);
		break;
}