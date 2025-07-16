/// @description Step

// Inherit the parent event
event_inherited();

rotate += angle_speed;
if (rotate >= 360)
{
    rotate_previous -= 360;
	rotate -= 360;
}
else if (rotate < 0)
{
    rotate_previous += 360;
	rotate += 360;
}

spikeball[0][0].x_offset = lengthdir_x(spikeball_distance, rotate);
spikeball[0][0].y_offset = lengthdir_y(spikeball_distance, rotate);

spikeball[1][0].x_offset = lengthdir_x(spikeball_distance, rotate + 180);
spikeball[1][0].y_offset = lengthdir_y(spikeball_distance, rotate + 180);