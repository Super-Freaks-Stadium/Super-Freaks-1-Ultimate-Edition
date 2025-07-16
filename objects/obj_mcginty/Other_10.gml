/// @description Step

var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;

hurt_timer_step();
collision_flags = 0;

if (!ground_on)
{
	if (speed_v < speed_fall)
		speed_v += min(speed_grv, speed_fall - speed_v);
			
	angle = 0;
}

if (ground_on)
{
	speed_x = lengthdir_x(speed_h, angle_ground);
	speed_y = lengthdir_y(speed_h, angle_ground);
}
else
{
	speed_x = speed_h;
	speed_y = speed_v;
}
		
x += speed_x;
y += speed_y;
		
enemy_collisions_ground(false);

_collision_left = collision_flag_get_left();
_collision_up = collision_flag_get_up();
_collision_right = collision_flag_get_right();
_collision_down = collision_flag_get_down();
		
if (_collision_left)
{
	if (speed_h < 0)
	{
		speed_h = -speed_h;
		sfx_play_global(sfx_bonk_coconut_2);
	}
}
if (_collision_right)
{
	if (speed_h > 0)
	{
		speed_h = -speed_h;
		sfx_play_global(sfx_bonk_coconut_2);
	}
}
if (_collision_up)
{
	if (speed_v < 0)
	{
		speed_v = 0;
		sfx_play_global(sfx_bonk_coconut_2);
	}
}
if (_collision_down)
{
	if (speed_v > 0)
	{
		if (speed_v > 3)
		{
			screen_shake(0, 6);
			sfx_play_global(sfx_crash_1);
		}
		speed_v = 0;
		ground_on = true;
	}
	switch (sign(x - x_previous))
	{
		case -1:
			switch (sign(dsin(angle_ground)))
			{
				case -1: //Uphill
					if (speed_h != 0)
						speed_h -= min(abs(speed_h), speed_frc) * sign(speed_h);
					speed_h -= 0.05;
					break;
				case 0:
					speed_h -= min(abs(speed_h), speed_frc) * sign(speed_h);
					break;
				case 1: //Downhill
					speed_h += 0.05;
					break;
			}
			break;
		case 0:
			//if (angle_ground != 0)
			//{
			//	if (angle_ground < 90)
			//	{
			//		face = -1;
			//		speed_h += 0.05;
			//	}
			//	else
			//	{
			//		face = 1;
			//		speed_h += 0.05;
			//	}
			//}
			break;
		case 1:
			switch (sign(dsin(angle_ground)))
			{
				case -1: //Downhill
					speed_h += 0.05;
					break;
				case 0:
					speed_h -= min(abs(speed_h), speed_frc) * sign(speed_h);
					break;
				case 1: //Uphill
					if (speed_h != 0)
						speed_h -= min(abs(speed_h), speed_frc) * sign(speed_h);
					speed_h -= 0.05;
					break;
			}
			break;
	}
}
else
{
	ground_on = false;
	collider_attach_clear();
}

if ((x - x_previous) == 0 && (y - y_previous) == 0)
	visual_face = 0;
else
	visual_face = 1;



visual_angle -= (x - x_previous);
if (visual_angle < 0)
{
	visual_angle += 360;
    visual_angle_previous += 360;
}
else if (visual_angle >= 360)
{
	visual_angle -= 360;
    visual_angle_previous -= 360;
}