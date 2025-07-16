/// @description Step

angle += rotate_speed;

var _width = searchlight_width / 2;

if (angle < 0)
{
	angle += 360;
	angle_previous += 360;
}
else if (angle >= 360)
{
	angle -= 360;
	angle_previous -= 360;
}

searchlight.shape_x2 = lengthdir_x(searchlight_length, angle - _width);
searchlight.shape_y2 = lengthdir_y(searchlight_length, angle - _width);
searchlight.shape_x3 = lengthdir_x(searchlight_length, angle + _width);
searchlight.shape_y3 = lengthdir_y(searchlight_length, angle + _width);