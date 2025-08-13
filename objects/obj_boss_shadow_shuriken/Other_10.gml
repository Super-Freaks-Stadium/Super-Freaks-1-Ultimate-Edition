/// @description Step

event_inherited();

switch (state)
{
	case 0:
		if (state_begin)
		{
			timer = 16;
		}
		
		x += lengthdir_x(4, direction);
		y += lengthdir_y(4, direction);
		
		timer--;
		
		if (timer < 1)
			state_next_set(1);
		break;
	case 1:
		if (state_begin)
		{
			timer = 48;
		}
		
		timer--;
		
		if (timer < 1)
			state_next_set(2);
		break;
	case 2:
		if (state_begin)
		{
			if (is_undefined(target) || !instance_exists(target))
				exit;
				
			with (target)
			{
				if (!player_is_alive())
					exit;
			}
			
			direction = point_direction(x, y, target.x, target.y);
		}
		
		x += lengthdir_x(speed, direction);
		y += lengthdir_y(speed, direction);
		break;
}

image_angle = (image_angle + 7) mod 360;