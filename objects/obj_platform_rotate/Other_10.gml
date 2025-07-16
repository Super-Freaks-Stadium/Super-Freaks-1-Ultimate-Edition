/// @description Step

var _i;

angle += rotate_speed;

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

for (_i = 0; _i < array_length(colliders); _i += 2)
{
	collider_side_step(_i);
}

for (_i = 1; _i < array_length(colliders); _i += 2)
{
	collider_corner_step(_i);
}