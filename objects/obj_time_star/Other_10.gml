/// @description Step

animate_previous = animate;
animate = animate + animate_speed mod 360;

if (countdown)
{
	timer = max(timer - 1, 0);
	if (timer == 0)
	{
		instance_destroy();
		sfx_play_global(sfx_record_scratch);
	}
}