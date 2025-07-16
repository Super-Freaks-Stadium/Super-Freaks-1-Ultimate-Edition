/// @description Step

var _i, _instance;
var _list = instance_attach_list;
var _x_delta, _y_delta;
var _speed = rotate_speed;

_x_delta = x - x_previous;
_y_delta = y - y_previous;

for (_i = array_length(_list) - 1; _i >= 0; --_i)
{
	_instance = _list[_i];
	
	if (!instance_exists(_instance) || _instance.instance_attach != id)
	{
		array_delete(_list, _i, 1);
		continue;
	}
		
	with (_instance)
	{
		x += _x_delta;
		y += _y_delta + _speed;
	}
}

//image_index += rotate_speed * 0.5;
offset = offset - rotate_speed;

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