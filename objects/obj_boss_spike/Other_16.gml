/// @description Hit

var _player_sign = sign(other.x - x),
	_speed_sign = sign(swing_speed);
if (_player_sign == 0)
	_player_sign = 1;
if (_speed_sign == 0)
	_speed_sign = -1;
var _hit_speed = 1;
var _yorb;
var _speed;
var _direction;
var _offset_x, _offset_y;

repeat (yorb_amount)
{
	_offset_x = x_offset_yorb + random_range(-16, 16);
	_offset_y = y_offset_yorb + random_range(-16, 16);
	_yorb = instance_create_layer(x + thing_x + _offset_x, y + thing_y + _offset_y, "layer_instances", obj_yorb_physics);
	_speed = random_range(6, 10);
	_direction = random_range(67.5, 112.5);
	with (_yorb)
	{
		speed_h = lengthdir_x(_speed, _direction);
		speed_v = lengthdir_y(_speed, _direction);
	}
}
	
if (_speed_sign == _player_sign)
	_player_sign *= -1;
	
switch (global.difficulty)
{
	case difficulty_levels.easy:
		_hit_speed = 1.5;
		break;
	default:
		_hit_speed = 2;
		break;
}

swing_speed = _player_sign * _hit_speed;

switch (global.boss_phase)
{
	case 0:
		if (hp == 10)
		{
			chain_multiplier_max = 1;
			swing_speed /= 2;
			state_next_set(boss_spike_states.normal);
			global.boss_phase = 1;
			instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
            turbo_time_add(20);
		}
		break;
	default:
		break;
}