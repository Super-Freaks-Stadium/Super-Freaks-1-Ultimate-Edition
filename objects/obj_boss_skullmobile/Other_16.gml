/// @description Hit

event_inherited();

if (global.boss_phase == 0)
{
	if (hp <= 6)
	{
		global.boss_phase = 1;
		instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
		laser_rotate_speed = -laser_rotate_speed;
        turbo_time_add(30);
	}
}