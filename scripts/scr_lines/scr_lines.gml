/// @function y_intercept_get
/// @description Returns the y-intercept of a sloped line
/// @param _x
/// @param _y
/// @param _slope
function y_intercept_get(_x, _y, _slope)
{
	return (_y - _slope * _x);
	
	gml_pragma("forceinline");
}

/// @function line_normalise
/// @param _x1
/// @param _y1
/// @param _x2
/// @param _y2
function line_normalise(_x1, _y1, _x2, _y2)
{
	var _vector_x = (_x2 - _x1);
	var _vector_y = (_y2 - _y1);
	var _length = sqr(_vector_x + (_vector_y * _vector_y));
	
	return [_vector_x / _length, _vector_y / _length];
	
	gml_pragma("forceinline");
}

/// @function point_line_nearest
/// @param _x
/// @param _y
/// @param _line_x1
/// @param _line_y1
/// @param _line_x2
/// @param _line_y2
function point_line_nearest(_x, _y, _line_x1, _line_y1, _line_x2, _line_y2)
{
    var _line_dx = _line_x1 - _line_x2,
        _line_dy = _line_y1 - _line_y2,
        _point_dx = _x - _line_x2,
        _point_dy = _y - _line_y2;
	var _ratio = clamp(dot_product(_point_dx, _point_dy, _line_dx, _line_dy) / dot_product(_line_dx, _line_dy, _line_dx, _line_dy), 0, 1);
	
	return [lerp(_line_x2, _line_x1, _ratio), lerp(_line_y2, _line_y1, _ratio)];
}