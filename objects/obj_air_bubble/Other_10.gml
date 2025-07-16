/// @description Step

size = min(size + 0.025, 1);

x += speed_h;
y += speed_v;

if (size == 1)
{
	if (!global.water_active || (y < global.water_height))
		instance_destroy();
	else
	{
		collision_left_simple();
		collision_right_simple();
		collision_up_simple();
		collision_down_simple();
	
		if (collision_flags != 0)
			instance_destroy();
	}
}