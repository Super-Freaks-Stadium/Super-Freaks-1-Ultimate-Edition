#macro SPAWN_WIDTH_MIN SCREEN_WIDTH_MIN - 128
#macro SPAWN_HEIGHT_MIN SCREEN_HEIGHT_MIN - 128
#macro SPAWN_WIDTH_MAX SCREEN_WIDTH_MAX + 128
#macro SPAWN_HEIGHT_MAX SCREEN_HEIGHT_MAX + 128

/// @function view
/// @param _x = 0
/// @param _y = 0
/// @param _index = 0
function view(_x = 0, _y = 0) constructor
{
	x = _x;
	y = _y;
	z = 1;
	z_target = 1;
	xprevious = x;
	yprevious = y;
	zprevious = 1;
	speed_x = 12;
	speed_y = 12;
	speed_z = 0.005;
	screen_shake_x = 0;
	screen_shake_y = 0;
	
	zone_main_spawn_area = array_create(4, 0);
	spawn_area = array_create(4, 0);
	spawn_area_previous = array_create(4, 0);
	
	border = array_create(4, 32);
}

/// @function view_init
function view_init()
{
	global.view = new view();
}

/// @function view_prestep
function view_prestep()
{
	with (global.view)
	{
		xprevious = x;
		yprevious = y;
		zprevious = z;
	}
}

/// @function view_step
function view_step()
{
	var _view = global.view;
	var _view_x, _view_y, _view_width, _view_height, _view_width_half, _view_height_half;
	var _x_min, _y_min, _x_max, _y_max;
	var _x_priority = 0, _y_priority = 0, _z_priority = 0;
	var _comp;
	var _x = 0, _x_min = 0, _x_max = 0, _x_distance = 0;
	var _y = 0, _y_min = 0, _y_max = 0, _y_distance = 0;
	var _z = undefined;
	
	var _view_border_x1, _view_border_y1, _view_border_x2, _view_border_y2;
	
	var _screen_width = screen_width_get();
	var _screen_height = screen_height_get();
	var _screen_width_min = min(_screen_width, SCREEN_WIDTH_MIN);
	var _screen_height_min = min(_screen_height, SCREEN_HEIGHT_MIN);
	var _screen_width_max = max(_screen_width, SCREEN_WIDTH_MAX);
	var _screen_height_max = max(_screen_height, SCREEN_HEIGHT_MAX);
	
	var _list = global.comp_list_camera;
	var _list_length = array_length(_list);
	var _list_pos;
	var _count = 0;
		
	for (_list_pos = _list_length - 1; _list_pos >= 0; --_list_pos)
	{
		_comp = _list[_list_pos];
			
		if !weak_ref_alive(_comp)
		{
			array_delete(_list, _list_pos, 1);
			continue;
		}
			
		_comp = _comp.ref;
			
		if !instance_exists(_comp.owner)
		{
			array_delete(_list, _list_pos, 1);
			continue;
		}
			
		with (_comp)
		{
			if (active == true)
			{
				_x += x;
				_y += y;
				
				if (_count == 0)
				{
					_x_min = x;
					_y_min = y;
					_x_max = x;
					_y_max = y;
				}
				else
				{
					_x_min = min(_x_min, x);
					_y_min = min(_y_min, y);
					_x_max = max(_x_max, x);
					_y_max = max(_y_max, y);
				}
				_count++;
			}
		}
	}
	
	switch (_count)
	{
		case 0:
			_x = undefined;
			_y = undefined;
			_x_distance = 0;
			_y_distance = 0;
			break;
		case 1:
			_x_distance = 0;
			_y_distance = 0;
			break;
		default:
			_x /= _count;
			_y /= _count;
			_x_distance = abs(_x_max - _x_min);
			_y_distance = abs(_y_max - _y_min);
			break;
	}
	
	_view_x = _x;
	_view_y = _y;
	
	with (_view)
	{
		if (is_undefined(_view_x))
			_view_x = x;
		if (is_undefined(_view_y))
			_view_y = y;
			
		if (instance_exists(obj_view_trapper))
		{
			with (obj_view_trapper)
			{
				if (point_in_rectangle(_view_x, _view_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
				{
					if (!is_undefined(my_x) && priority >= _x_priority)
					{
						_view_x = my_x;
						_x_priority = priority;
					}
					
					if (!is_undefined(my_y) && priority >= _y_priority)
					{
						_view_y = my_y;
						_y_priority = priority;
					}
					
					if (priority >= _z_priority)
					{
						if (my_zoom >= 1)
						{
							_z = my_zoom;
							_z_priority = priority;
						}
					}
				}
			}
		}
		
		if (z == z_target)
		{
			if (is_undefined(_z))
			{
				if (_x_distance > 424 || _y_distance > 128)
					z_target = 1.5;
				else if (_x_distance < 64 && _y_distance < 16)
					z_target = 1;
			}
			else
				z_target = _z;
		}
		else
		{
			if (z > z_target)
				z = max(z - speed_z, z_target);
			else if (z < z_target)
				z = min(z + speed_z, z_target);
		}
		
		_view_width = (_screen_width * z);
		_view_height = (_screen_height * z);
		_view_width_half = _view_width * 0.5;
		_view_height_half = _view_height * 0.5;
		
		_view_border_x1 = _view_x - _view_width_half + (border[0] * z);
		_view_border_y1 = _view_y - _view_height_half + (border[1] * z);
		_view_border_x2 = _view_x + _view_width_half - (border[2] * z);
		_view_border_y2 = _view_y + _view_height_half - (border[3] * z);
		
		if (_x_min < _view_border_x1)
			_view_x += (_x_min - _view_border_x1);
		if (_x_max > _view_border_x2)
			_view_x += (_x_max - _view_border_x2);

		if (_y_min < _view_border_y1)
			_view_y += (_y_min - _view_border_y1);
		if (_y_max > _view_border_y2)
			_view_y += (_y_max - _view_border_y2);
			
		if (instance_exists(obj_view_blocker))
		{
			with (obj_view_blocker)
			{
				if (_view_y == clamp(_view_y, bbox_top, bbox_bottom))
				{
					switch (sign(_view_x - x))
					{
						case -1:
							if (solid_left)
							{
								if (priority >= _x_priority)
								{
									_view_x = min(_view_x, bbox_left - _view_width_half);
									_x_priority = priority;
								}
							}
							break;
						default:
							if (solid_right)
							{
								if (priority >= _x_priority)
								{
									_view_x = max(_view_x, bbox_right + _view_width_half);
									_x_priority = priority;
								}
							}
							break;
					}
				}
			
				if (_view_x == clamp(_view_x, bbox_left, bbox_right))
				{
					switch (sign(_view_y - y))
					{
						case -1:
							if (solid_up)
							{
								if (priority >= _y_priority)
								{
									_view_y = min(_view_y, bbox_top - _view_height_half);
									_y_priority = priority;
								}
							}
							break;
						default:
							if (solid_down)
							{
								if (priority >= _y_priority)
								{
									_view_y = max(_view_y, bbox_bottom + _view_height_half);
									_y_priority = priority;
								}
							}
							break;
					}
				}
			}
		}
		
		_view_x = clamp(_view_x, xprevious - speed_x, xprevious + speed_x);
		_view_y = clamp(_view_y, yprevious - speed_y, yprevious + speed_y);
		_view_x = clamp(_view_x, _screen_width / 2, room_width - (_screen_width / 2));
		_view_y = clamp(_view_y, _screen_height / 2, room_height - (_screen_height / 2));
		
		x = _view_x;
		y = _view_y;
		
		_view_width = (_screen_width_max * z);
		_view_height = (_screen_height_max * z);
		_view_width_half = _view_width * 0.5;
		_view_height_half = _view_height * 0.5;
		
		screen_shake_x = max(abs(screen_shake_x) - 1, 0) * choose(1, -1);
		screen_shake_y = max(abs(screen_shake_y) - 1, 0) * choose(1, -1);
		
		_view_x = clamp(x, _view_width / 2, room_width - (_view_width / 2));
		_view_y = clamp(y, _view_height / 2, room_height - (_view_height / 2));
			
		array_copy(spawn_area_previous, 0, spawn_area, 0, 4);
		spawn_area[0] = _view_x - (_view_width / 2);
		spawn_area[1] = _view_y - (_view_height / 2);
		spawn_area[2] = _view_x + (_view_width / 2);
		spawn_area[3] = _view_y + (_view_height / 2);
		/*
		spawn_area[0] = max(0, x - (_view_width / 2));
		spawn_area[1] = max(0, y - (_view_height / 2));
		spawn_area[2] = min(room_width, spawn_area[0] + _view_width);
		spawn_area[3] = min(room_height, spawn_area[1] + _view_height);
		*/
	}
}

/// @function view_step_delta
/// @param _frame_delta = global.delta
function view_step_delta(_frame_delta = global.delta)
{
	var _view = global.view;
	var _view_x, _view_y, _view_z, _view_width, _view_height, _view_width_half, _view_height_half;
	
	var _screen_width = screen_width_get();
	var _screen_height = screen_height_get();
	
	var _screen_shake_x = 0, _screen_shake_y = 0;

	with (_view)
	{
		if (screen_shake_get())
		{
			_screen_shake_x = screen_shake_x;
			_screen_shake_y = screen_shake_y;
		}
		_view_x = lerp(xprevious, x, _frame_delta);
		_view_y = lerp(yprevious, y, _frame_delta);
		_view_z = lerp(zprevious, z, _frame_delta);
		_view_width = _screen_width * _view_z;
		_view_height = _screen_height * _view_z;
		_view_width_half = _view_width * 0.5;
		_view_height_half = _view_height * 0.5;
		camera_set_view_size(view_camera[0], _view_width, _view_height);
		camera_set_view_pos(view_camera[0], clamp(_view_x - _view_width_half, 0, room_width - _view_width) + _screen_shake_x, clamp(_view_y - _view_height_half, 0, room_height - _view_height) + _screen_shake_y);
	}
}

/// @function view_reset
/// @param _x = 0
/// @param _y = 0
/// @param _z = 1
function view_reset(_x = 0, _y = 0, _z = 1)
{
	var _view = global.view;
	var _view, _view_width, _view_height, _view_width_half, _view_height_half;
	
	var _screen_width = min(screen_width_get(), SCREEN_WIDTH_MAX);
	var _screen_height = min(screen_height_get(), SCREEN_HEIGHT_MAX);
	var _screen_width_max = max(screen_width_get(), SCREEN_WIDTH_MAX);
	var _screen_height_max = max(screen_height_get(), SCREEN_HEIGHT_MAX);
	
	with (_view)
	{
		screen_shake_x = 0;
		screen_shake_y = 0;
		
		if (instance_exists(obj_view_trapper))
		{
			with (obj_view_trapper)
			{
				if (point_in_rectangle(_x, _y, bbox_left, bbox_top, bbox_right, bbox_bottom))
				{
					if (!is_undefined(my_x))
						_x = my_x;
					
					if (!is_undefined(my_y))
						_y = my_y;
					
					if (my_zoom >= 1)
						_z = my_zoom;
				}
			}
		}
		
		_view_width = (_screen_width * _z);
		_view_height = (_screen_height * _z);
		_view_width_half = _view_width * 0.5;
		_view_height_half = _view_height * 0.5;
		
		if (instance_exists(obj_view_blocker))
		{
			with (obj_view_blocker)
			{
				if (_y == clamp(_y, bbox_top, bbox_bottom))
				{
					if (solid_right && (_x - _view_width_half) < bbox_right)
						_x = max(_x, bbox_right + _view_width_half);
					if (solid_left && (_x + _view_width_half) > bbox_left)
						_x = min(_x, bbox_left - _view_width_half);
				}
			
				if (_x == clamp(_x, bbox_left, bbox_right))
				{
					if (solid_down && (_y - _view_height_half) < bbox_bottom)
						_y = max(_y, bbox_bottom + _view_height_half);
					if (solid_up && (_y + _view_height_half) > bbox_top)
						_y = min(_y, bbox_top - _view_height_half);
				}
			}
		}
		
		x = clamp(_x, _view_width_half, room_width - _view_width_half);
		y = clamp(_y, _view_height_half, room_height - _view_height_half);
		z = _z;
		z_target = _z;
		xprevious = x;
		yprevious = y;
		zprevious = z;
		view_set_wport(view_camera[0], _screen_width);
		view_set_hport(view_camera[0], _screen_height);
		camera_set_view_size(view_camera[0], _view_width, _view_height);
		camera_set_view_pos(view_camera[0], clamp(x - _view_width_half, 0, room_width - _view_width), clamp(y - _view_height_half, 0, room_height - _view_height));
		
		_view_width = (_screen_width_max * _z);
		_view_height = (_screen_height_max * _z);
		_view_width_half = _view_width * 0.5;
		_view_height_half = _view_height * 0.5;
			
		spawn_area[0] = x - _view_width_half;
		spawn_area[1] = y - _view_height_half;
		spawn_area[2] = spawn_area[0] + _view_width;
		spawn_area[3] = spawn_area[1] + _view_height;
		array_copy(spawn_area_previous, 0, spawn_area, 0, 4);
		
		zone_main_start();
		zones_step();
	}
}

/// @function view_borders_set
/// @param _x1 = 0
/// @param _y1 = 0
/// @param _x2 = 0
/// @param _y2 = 0
function view_borders_set(_x1 = 0, _y1 = 0, _x2 = 0, _y2 = 0)
{
	var _view = global.view;
	
	_view.border[0] = _x1;
	_view.border[1] = _y1;
	_view.border[2] = _x2;
	_view.border[3] = _y2;
}

/// @function view_x_get
function view_x_get()
{
	return (view_width_get() / 2) + view_x1_get();
	
	gml_pragma("forceinline");
}

/// @function view_y_get
function view_y_get()
{
	return (view_height_get() / 2) + view_y1_get();
	
	gml_pragma("forceinline");
}

/// @function view_x1_get
function view_x1_get()
{
	return camera_get_view_x(view_camera[view_current]);
	
	gml_pragma("forceinline");
}

/// @function view_y1_get
function view_y1_get()
{
	return camera_get_view_y(view_camera[view_current]);
	
	gml_pragma("forceinline");
}

/// @function view_x2_get
function view_x2_get()
{
	return view_x1_get() + view_width_get();
	
	gml_pragma("forceinline");
}

/// @function view_y2_get
function view_y2_get()
{
	return view_y1_get() + view_height_get();
	
	gml_pragma("forceinline");
}

/// @function view_width_get()
function view_width_get()
{
	return camera_get_view_width(view_camera[view_current]);
	
	gml_pragma("forceinline");
}

/// @function view_height_get()
function view_height_get()
{
	return camera_get_view_height(view_camera[view_current]);
	
	gml_pragma("forceinline");
}

/// @function draw_set_projection_2D
/// @param _x
/// @param _y
/// @param _width = screen_width_get()
/// @param _height = screen_height_get()
function draw_set_projection_2D(_x, _y, _width = screen_width_get(), _height = screen_height_get())
{
	var _width_half = _width * 0.5;
	var _height_half = _height * 0.5;
	var _matrix_lookat;
	var _matrix_projection;
	
	gpu_set_zwriteenable(false);
	gpu_set_ztestenable(false);
	_matrix_lookat = matrix_build_lookat(_x + _width_half, _y + _height_half, -1, _x + _width_half, _y + _height_half, 0, 0, 1, 0);
	_matrix_projection = matrix_build_projection_ortho(_width, _height, -16000, 32000);
	camera_set_view_mat(view_camera[view_current], _matrix_lookat);
	camera_set_proj_mat(view_camera[view_current], _matrix_projection);
	camera_apply(view_camera[view_current]);
}

/// @function in_view
/// @param _x1 = x
/// @param _y1 = y
/// @param _x2 = x
/// @param _y2 = y
function in_view(_x1 = x, _y1 = y, _x2 = x, _y2 = y)
{
	if rectangle_in_rectangle(_x1, _y1, _x2, _y2, view_x1_get(), view_y1_get(), view_x2_get(), view_y2_get())
		return true;
		
	return false;
	
	gml_pragma("forceinline");
}

/// @function screen_shake
/// @param _x = 6
/// @param _y = 6
function screen_shake(_x = 6, _y = 6)
{
	with (global.view)
	{
		screen_shake_x = _x;
		screen_shake_y = _y;
	}
}