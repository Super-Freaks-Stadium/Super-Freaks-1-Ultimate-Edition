/// @description Step

direction_previous = direction;

var _speed_h, _speed_v, _player;
var _point_dir, _point_speed, _point_damp;

_player = player_nearest_to_point_alive(x, y);

if (!is_undefined(_player))
{
	_point_dir = point_direction(x, y,_player.x, _player.y);
	_point_speed = max(speed, 0);
	_point_damp = clamp(0.025, 0, 1);

	direction -= clamp(angle_difference(direction, _point_dir) * _point_damp, -_point_speed, _point_speed);
}

_speed_h = lengthdir_x(speed, direction);
_speed_v = lengthdir_y(speed, direction);

x += _speed_h;
y += _speed_v;

switch (sign(_speed_h))
{
	case -1:
		if (collision_left_simple())
			instance_destroy();
		break;
	case 0:
		break;
	case 1:
		if (collision_right_simple())
			instance_destroy();
		break;
}

switch (sign(_speed_v))
{
	case -1:
		if (collision_up_simple())
			instance_destroy();
		break;
	case 0:
		break;
	case 1:
		if (collision_down_simple())
			instance_destroy();
		break;
}