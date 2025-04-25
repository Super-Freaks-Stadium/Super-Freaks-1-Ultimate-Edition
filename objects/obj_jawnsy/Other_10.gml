/// @description Step

var _target, _target_distance;

hurt_timer_step();

switch (state)
{
	case enemy_jawnsy_states.swim:
		_target = player_nearest_to_point_alive(room_width, room_height);
		
		if (state_begin)
		{
			timer = 0;
			speed_h = 0;
			speed_v = 0;
			sprite_index = spr_jawnsy;
            fast_forward = fast_forward_setting;
		}
		
		y = max(y - 4, global.water_height);
		timer = min(timer + 1, 128);
		
		if (!is_undefined(_target))
		{
			switch (sign(_target.x - x))
			{
				case -1:
					if (speed_h > 0)
						speed_h -= speed_dec;
					else
					{
						speed_h = max(speed_h - speed_acc, -speed_swim);
						face = -1;
					}
					break;
				case 0:
					break;
				case 1:
					if (speed_h < 0)
						speed_h += speed_dec;
					else
					{
						speed_h = min(speed_h + speed_acc, speed_swim);
						face = 1;
					}
					break;
			}
			if (timer >= 128 && distance_to_point(_target.x, y) < 256)
				state_next_set(enemy_jawnsy_states.prepare);
		}
		else
			speed_h -= min(abs(speed_h), speed_dec) * sign(speed_h);
		break;
	case enemy_jawnsy_states.prepare:
		if (state_begin)
		{
			timer = 0;
		}
		speed_h -= min(abs(speed_h), speed_dec) * sign(speed_h);
		speed_v = 2;
		timer++;
		
		if (timer >= 56)
			state_next_set(enemy_jawnsy_states.jump);
		break;
	case enemy_jawnsy_states.jump:
		if (state_begin)
		{
			timer = 0;
			speed_h = 0;
			speed_v = -12;
			sprite_index = spr_jawnsy_bite;
            fast_forward = false;
		}
		if (y < global.water_height)
			speed_v = min(speed_v + speed_grv, 6);
		else
		{
			if (speed_v > 0)
			{
				speed_v = max(speed_v - 0.25, 0);
				if (speed_v == 0)
					state_next_set(enemy_jawnsy_states.swim);
			}
		}
		break;
}

x += speed_h;
y += speed_v;