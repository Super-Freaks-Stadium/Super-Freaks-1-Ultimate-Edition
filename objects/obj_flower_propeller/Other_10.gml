/// @description Step

var _move_h = 0, _move_v = 0;
var _i, _instance;
var _list = instance_attach_list;
var _x_delta, _y_delta;

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
		if (_i == 0)
		{
			if (input_check("left", player_number))
				_move_h -= 1;
			if (input_check("right", player_number))
				_move_h += 1;
			if (input_check("up", player_number))
				_move_v -= 1;
			if (input_check("down", player_number))
				_move_v += 1;
		}
	}
}

_move_h *= mirror_flip_get();

switch (_move_h)
{
	case -1:
		speed_h = max(speed_h - 0.125, -3);
		break;
	case 0:
		speed_h *= 0.95;
		break;
	case 1:
		speed_h = min(speed_h + 0.125, 3);
		break;
}

if (active)
{
	if (array_length(_list) == 0)
	{
		speed_v -= 4;
		hitbox.active = hitbox_active.inactive;
		timer++;
		if (timer >= 48)
		{
			timer = 0;
			x = xstart;
			y = ystart;
			speed_h = 0;
			speed_v = 0;
			hitbox.active = hitbox_active.active;
			active = false;
			can_despawn = true;
			if (in_view(x - 32, y - 96, x + 32, y + 96))
				sfx_play_local(sfx_pop);
		}
	}
	else
	{
		can_despawn = false;
		if (speed_v < 0)
			speed_v += 0.125;
		else
		{
			switch (_move_v)
			{
				case -1:
					if (speed_v > 0.5)
						speed_v = max(speed_v - 0.025, 0.5);
					else
						speed_v = min(speed_v + 0.025, 0.5);
					break;
				case 0:
					if (speed_v > 1)
						speed_v = max(speed_v - 0.025, 1);
					else
						speed_v = min(speed_v + 0.025, 1);
					break;
				case 1:
					if (speed_v > 2)
						speed_v = max(speed_v - 0.025, 2);
					else
						speed_v = min(speed_v + 0.025, 2);
					break;
			}
		}
	}
}

x += speed_h;
y += speed_v;

_x_delta = x - x_previous;
_y_delta = y - y_previous;

for (_i = array_length(_list) - 1; _i >= 0; --_i)
{
	_instance = _list[_i];

	with (_instance)
	{
		x += _x_delta;
		y += _y_delta;
	}
}