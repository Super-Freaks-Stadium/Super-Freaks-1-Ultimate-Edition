/// @description Step

event_inherited();

pos = pos + (5 - hp) mod 360;

angle = angle - 10;
if (angle < 0)
{
    angle_previous += 360;
	angle += 360;
}

x = start_x + lengthdir_x(24, pos);
y = start_y + lengthdir_y(24, pos);