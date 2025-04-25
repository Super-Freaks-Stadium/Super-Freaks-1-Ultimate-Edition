/// @description Hit

event_inherited();

if (global.boss_phase == 1 && hp <= 10)
{
	boss_milkman_activate_arms();
	instance_create_layer(x - 80, y - 160, "layer_instances", obj_boss_explosion);
	instance_create_layer(x + 80, y - 160, "layer_instances", obj_boss_explosion);
	sfx_play_global(sfx_explode);
    turbo_time_add(20);
	global.boss_phase = 2;
	arm_active = true;
	screen_shake(0, 16);
}