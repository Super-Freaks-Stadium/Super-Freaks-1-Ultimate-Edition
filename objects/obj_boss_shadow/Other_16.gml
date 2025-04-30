/// @description Hit

// Inherit the parent event
event_inherited();

if (global.boss_phase == 0 && hp <= 10)
{
	global.boss_phase = 1;
	toughness++;
	instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
	state_next_set(boss_shadow_states.teleport_1, 99);
    turbo_time_add(20);
}