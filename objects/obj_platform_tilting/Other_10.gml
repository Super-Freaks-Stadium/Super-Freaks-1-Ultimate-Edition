/// @description Step

var _x = x, _x_delta;
var _width = image_xscale * sprite_get_width(sprite_index);
var _width_half = _width / 2;
var _collider_y1, _collider_y2;
var _i, _instance;
var _list = collider.attach_list;
var _angle = angle, _angle_speed = 0;
var _rotate_back = true;

for (_i = array_length(_list) - 1; _i >= 0; --_i)
{
	_instance = _list[_i];
	
	with (_instance)
	{
		_x_delta = x - _x;
		switch (sign(_x_delta))
		{
			case -1:
				_angle_speed += abs(0.2 * (_x_delta / _width));
				_rotate_back = false;
				break;
			case 0:
				break;
			case 1:
				_angle_speed -= abs(0.2 * (_x_delta / _width));
				_rotate_back = false;
				break;
		}
	}
}

angle_speed += _angle_speed;
angle_speed = clamp(angle_speed, -8, 8);

if (_rotate_back == true)
	return_to_start_angle = true;
else
	return_to_start_angle = false;
	
if (return_to_start_angle)
{
	switch (sign(collider.shape_y1 - collider.shape_y2))
	{
		case -1: //Left Side Pointing Up
			angle_speed += 0.1 * min(abs(collider.shape_y1 - collider.shape_y2), 1);
			break;
		case 0:
			break;
		case 1: //Right Side Pointing Up
			angle_speed -= 0.1 * min(abs(collider.shape_y1 - collider.shape_y2), 1);
			break;
	}
	angle_speed *= 0.9;
}

_angle += angle_speed;

if (_angle >= 22.5)
{
	_angle = 22.5;
	angle_speed = 0;
}
else if (_angle <= -22.5)
{
	_angle = -22.5;
	angle_speed = 0;
}

collider.shape_x1 = lengthdir_x(-_width_half, _angle);
collider.shape_y1 = lengthdir_y(-_width_half, _angle);
collider.shape_x2 = lengthdir_x(_width_half, _angle);
collider.shape_y2 = lengthdir_y(_width_half, _angle);

angle = _angle;


if (my_path == -1)
{
	x += speed_path;

	switch (sign(x - x_previous))
	{
		case -1:
			if (collision_exists_left_simple(x - _width_half, y + _collider_y1, y + _collider_y2, y + _collider_y2))
				speed_path = -speed_path;
			break;
		case 0:
			break;
		case 1:
			if (collision_exists_right_simple(x + _width_half, y + _collider_y1, y + _collider_y2, y + _collider_y2))
				speed_path = -speed_path;
			break;
	}
}
else
{
	switch (path_movement_style)
	{
		case 0:
			path_move(my_path, path_end_actions.reverse);
			break;
		case 1:
			path_move(my_path, path_end_actions.reverse);
			break;
		case 2:
			if (abs(_angle) >= 5)
			{
				speed_path = -(_angle / 22.5) * speed_move;
				path_move(my_path, path_end_actions.reverse);
			}
			break;
	}
}

if (water)
	y = global.water_height - 8;