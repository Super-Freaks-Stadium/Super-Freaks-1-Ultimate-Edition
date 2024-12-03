/// @description Step

y_previous = y;

switch (state)
{
	case 0:
		if (state_begin)
		{
			timer = 0;
		}
		timer = min(timer + 1, 64);
		if (timer == 64)
		{
			state_next_set(1);
		}
		break;
	case 1:
		image_index = 1;
		y -= 16;
		
		if (y <= 256)
		{
			y = 256;
			global.boss_phase++;
			instance_create_layer(x, y, "layer_instances", obj_boss_larry);
			instance_destroy();
		}
		break;
}