/// @description 

global.trophies = bit_set(global.trophies, trophy_id);
sfx_play_local(sfx_unlock_level);
switch (global.story_mode)
{
	case story_modes.super_freaks:
		if (hearts_maximum_get() > 0)
		{
			sfx_play_local(sfx_heart);
			global.hearts = min(global.hearts + 1, hearts_maximum_get());
		}
		break;
	default:
		player_meter_collect(100);
		break;
}
if (instance_exists(obj_gameplay_manager))
{
	with (obj_gameplay_manager)
		the_trophy_appears = 100;
}
instance_destroy();