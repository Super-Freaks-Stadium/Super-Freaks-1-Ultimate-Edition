/// @description 

instance_destroy();

switch (global.story_mode)
{
	case story_modes.super_freaks:
		global.hearts = max(global.hearts, 10);
		sfx_play_local(sfx_unlock_level);
		break;
	default:
		player_meter_collect(100);
		break;
}