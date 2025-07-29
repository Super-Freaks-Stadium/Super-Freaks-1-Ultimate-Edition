/// @description Step

speed_y += 0.125;
y += speed_y;

angle += angle_speed;
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

if (collision_exists_down_simple())
{
	instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
	instance_destroy();
	screen_shake(0, 4);
}