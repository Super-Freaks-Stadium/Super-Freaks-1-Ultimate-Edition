/// @function draw_sprite_interpolated
/// @param _sprite_index
/// @param _image_index = image_index
/// @param _x = x
/// @param _y = y
/// @param _xprevious = _x_start_frame
/// @param _yprevious = _y_start_frame
/// @param _scale_x = 1
/// @param _scale_y = 1
/// @param _scale_xprevious = _scale_x
/// @param _scale_yprevious = _scale_y
/// @param _angle = 0
/// @param _angleprevious = _angle
/// @param _color = draw_get_color()
/// @param _alpha = draw_get_alpha()
/// @param _frame_delta = global.delta
function draw_sprite_interpolated(_sprite_index, _image_index = image_index, _x = x, _y = y, _xprevious = x_start_frame, _yprevious = y_start_frame, _scale_x = 1, _scale_y = 1, _scale_xprevious = _scale_x, _scale_yprevious = _scale_y, _angle = 0, _angleprevious = _angle, _color = draw_get_color(), _alpha = draw_get_alpha(), _frame_delta = global.delta)
{
	var _x_delta = _x;
	var _y_delta = _y;
	var _scale_x_delta = _scale_x;
	var _scale_y_delta = _scale_y;
	var _angle_delta = _angle;
	
	if (_frame_delta < 1)
	{
		if (_xprevious != _x)
			_x_delta = lerp(_xprevious, _x, _frame_delta);
		if (_yprevious != _y)
			_y_delta = lerp(_yprevious, _y, _frame_delta);
		
		if (_scale_xprevious != _scale_x)
			_scale_x_delta = lerp(_scale_xprevious, _scale_x, _frame_delta);
		if (_scale_yprevious != _scale_y)
			_scale_y_delta = lerp(_scale_yprevious, _scale_y, _frame_delta);
		
		if (_angleprevious != _angle)
			_angle_delta = lerp_360(_angleprevious, _angle, _frame_delta) mod 360;
	}
		
	draw_sprite_ext(_sprite_index, _image_index, _x_delta, _y_delta, _scale_x_delta, _scale_y_delta, _angle_delta, _color, _alpha);
}

/// @function draw_sprite_parallax
/// @param _sprite_index
/// @param _image_index = 0
/// @param _x
/// @param _y
/// @param _x_parallax = 2
/// @param _y_parallax = 2
/// @param _x_offset = 0
/// @param _y_offset = 0
/// @param _x_spacing = 0
/// @param _y_spacing = 0
function draw_sprite_parallax(_sprite_index, _image_index = 0, _x, _y, _x_parallax = 2, _y_parallax = 2, _x_offset = 0, _y_offset = 0, _x_spacing = 0, _y_spacing = 0)
{
	var _draw_x, _draw_y;
	var _draw_amount_x, _draw_amount_y;
	var _sprite_width = sprite_get_width(_sprite_index) + _x_spacing;
	var _sprite_height = sprite_get_height(_sprite_index) + _y_spacing;
	var _view_x1 = view_x1_get(), _view_y1 = view_y1_get();
	
	_x -= _view_x1;
	_x_parallax = _view_x1 / _x_parallax;
	_x_offset = (_x_offset - _x_parallax) mod _sprite_width;
	_draw_amount_x = ceil(view_width_get() / _sprite_width) + 1;
	
	_y -= _view_y1;
	_y_parallax = _view_y1 / _y_parallax;
	_y_offset = (_y_offset - _y_parallax) mod _sprite_height;
	_draw_amount_y = ceil(view_height_get() / _sprite_height) + 1;

	for (_draw_x = -1; _draw_x <= _draw_amount_x; _draw_x++)
	{
		for (_draw_y = -1; _draw_y <= _draw_amount_y; _draw_y++)
		{
		    draw_sprite(_sprite_index, _image_index, _x + _x_offset + (_draw_x * _sprite_width), _y + _y_offset + (_draw_y * _sprite_height));
		}
	}
}

/// @function draw_sprite_parallax_x
/// @param _sprite_index
/// @param _image_index = 0
/// @param _x
/// @param _y
/// @param _x_parallax = 2
/// @param _x_offset = 0
/// @param _x_spacing = 0
function draw_sprite_parallax_x(_sprite_index, _image_index = 0, _x, _y, _x_parallax = 2, _x_offset = 0, _x_spacing = 0)
{
	var _draw_x;
	var _draw_amount_x;
	var _sprite_width = sprite_get_width(_sprite_index) + _x_spacing;
	var _view_x1 = view_x1_get();
	
	_x -= _view_x1;
	_x_parallax = _view_x1 / _x_parallax;
	_x_offset = (_x_offset - _x_parallax) mod _sprite_width;
	_draw_amount_x = ceil(view_width_get() / _sprite_width) + 1;

	for (_draw_x = -1; _draw_x <= _draw_amount_x; _draw_x++)
	{
	    draw_sprite(_sprite_index, _image_index, _x + _x_offset + (_draw_x * _sprite_width), _y);
	}
}

/// @function draw_sprite_parallax_y
/// @param _sprite_index
/// @param _image_index = 0
/// @param _x
/// @param _y
/// @param _y_parallax = 2
/// @param _y_offset = 0
/// @param _y_spacing = 0
function draw_sprite_parallax_y(_sprite_index, _image_index = 0, _x, _y, _y_parallax = 2, _y_offset = 0, _y_spacing = 0)
{
	var _draw_y;
	var _draw_amount_y;
	var _sprite_height = sprite_get_height(_sprite_index) + _y_spacing;
	var _view_y1 = view_y1_get();
	
	_y -= _view_y1;
	_y_parallax = _view_y1 / _y_parallax;
	_y_offset = (_y_offset - _y_parallax) mod _sprite_height;
	_draw_amount_y = ceil(view_height_get() / _sprite_height) + 1;

	for (_draw_y = -1; _draw_y <= _draw_amount_y; _draw_y++)
	{
	    draw_sprite(_sprite_index, _image_index, _x, _y + _y_offset + (_draw_y * _sprite_height));
	}
}

/// @function animation_at_end
function animation_at_end()
{
	return (floor(image_index + animate_speed) >= image_number);
	
	gml_pragma("forceinline");
}

/// @function animation_about_to_end
function animation_about_to_end()
{
	return (floor(image_index + animate_speed) >= image_number - 1);
	
	gml_pragma("forceinline");
}