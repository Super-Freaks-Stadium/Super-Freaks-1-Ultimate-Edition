/// @description Step

var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;

collision_flags = 0;

hurt_timer_step();
enemy_behavior_ground(speed_move,,speed_move,,, false);

_collision_left = collision_flag_get_left();
_collision_up = collision_flag_get_up();
_collision_right = collision_flag_get_right();
_collision_down = collision_flag_get_down();
		
if (_collision_left)
{
	if (speed_h < 0)
	{
		speed_h = -speed_h;
		face = 1;
	}
}
if (_collision_right)
{
	if (speed_h > 0)
	{
		speed_h = -speed_h;
		face = -1;
	}
}
if (_collision_up)
{
	if (speed_v < 0)
	{
		speed_v = 0;
		sfx_play_local(sfx_honk);
	}
}
if (_collision_down)
{
	if (speed_v > 0)
	{
		speed_v = 0;
		ground_on = true;
		if (!is_moving)
		{
			is_moving = true;
			speed_move = speed_initial;
		}
	}
	switch (sign(x - xprevious))
	{
		case -1:
			switch (sign(dsin(angle_ground)))
			{
				case -1: //Uphill
					speed_move -= 0.05;
					break;
				case 0:
					break;
				case 1: //Downhill
					speed_move += 0.05;
					break;
			}
			break;
		case 0:
			break;
		case 1:
			switch (sign(dsin(angle_ground)))
			{
				case -1: //Downhill
					speed_move += 0.05;
					break;
				case 0:
					break;
				case 1: //Uphill
					speed_move -= 0.05;
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

if (abs(speed_h) > 0)
	face = sign(speed_h);
animate_speed = abs(speed_h) * 0.125;