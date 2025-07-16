/// @description Step 2

var _back_width = sprite_get_width(spr_hippie_wind);
var _back_height = sprite_get_height(spr_hippie_wind);
var _speed_h, _speed_v;

switch (state)
{
	case 0:
		if (state_begin)
		{
			timer = 0;
			audio_stop_sound(sfx_wind);
		}
		speed_h = lerp(speed_h, 0, 0.1);
		speed_v = 0;
		offset_x += sign(wind_speed_x) * 0.125;
		offset_y += 0.125;
		
		timer = min(timer + 1, timer_turn_on);
		
		if (timer == timer_turn_on)
			state_next_set(1);
		break;
	case 1:
		if (state_begin)
		{
			timer = 0;
			sfx_play_global(sfx_wind, true);
		}
		speed_h = lerp(speed_h, wind_speed_x, 0.025);
		speed_v = lerp(speed_v, wind_speed_y, 0.025);
		
		timer = min(timer + 1, timer_turn_off);
		
		if (timer == timer_turn_off)
			state_next_set(0);
		break;
}

_speed_h = speed_h;
_speed_v = speed_v;

with (obj_player)
{
	switch (state)
	{
		case player_states.normal:
		case player_states.hurt:
		case player_states.death:
			if (_speed_v < 0 && !ground_on)
			{
				if (speed_v > _speed_v)
					speed_v = 0;
			}
			if (!ground_on)
			{
				x += _speed_h;
				y += _speed_v;
			}
			else
				x += _speed_h * 0.5;
			break;
		default:
			break;
	}
}

offset_x += speed_h;
offset_y += speed_v;

if (offset_x > _back_width)
{
	offset_x -= _back_width;
	offset_x_previous -= _back_width;
}
else if (offset_x < 0)
{
	offset_x += _back_width;
	offset_x_previous += _back_width;
}

if (offset_y > _back_height)
{
	offset_y -= _back_height;
	offset_y_previous -= _back_height;
}
else if (offset_y < 0)
{
	offset_y += _back_height;
	offset_y_previous += _back_height;
}