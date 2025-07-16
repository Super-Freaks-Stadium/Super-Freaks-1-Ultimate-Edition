/// @description Step

var _i, _instance;
var _list = collider.attach_list;
var _speed = conveyor_speed * sign(image_xscale);
var _width = abs(image_xscale * sprite_get_width(sprite_index));
//var _height = image_yscale * sprite_get_height(sprite_index);
var _width_half = _width / 2;
var _collider_y1, _collider_y2;

// Inherit the parent event
event_inherited();

collider.shape_x1 = -_width_half;
collider.shape_x2 = _width_half;
_collider_y1 = collider.shape_y1;
_collider_y2 = collider.shape_y2;

for (_i = array_length(_list) - 1; _i >= 0; --_i)
{
	_instance = _list[_i];
	
	with (_instance)
		x += _speed;
}

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
			speed_path = speed_move;
			path_move(my_path, path_end_actions.reverse);
			break;
	}
}

if (water)
	y = global.water_height - 8;

offset = offset - _speed;

if (offset < 0)
{
	offset += 16;
	offset_previous += 16;
}
else if (offset >= 16)
{
	offset -= 16;
	offset_previous -= 16;
}