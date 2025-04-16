/// @description 

if (!active)
{
	active = true;
	animate_speed = 0.125;
	sfx_play_global(sfx_tv_on);
	checkpoint_set(room, x, y, checkpoint_id);
	global.checkpoint_death_count = 0;
    turbo_time_add(15);
}
