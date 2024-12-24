/// @description Hit

event_inherited();

cockpit_sprite = spr_boss_francis_cockpit_hurt;
cockpit_timer = 8;

if (global.boss_phase == 1 && hp <= 9)
{
	instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
	sfx_play_local(sfx_explode);
	global.boss_phase = 2;
	speed_h_max = 2;
	size = 0.75;
	state_next_set(boss_francis_states.higher);
	screen_shake(0, 16);
    counter_attack = attack_times;
}
else if (global.boss_phase == 2 && hp <= 6)
{
	instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
	sfx_play_local(sfx_explode);
	global.boss_phase = 3;
	speed_h_max = 1;
	size = 0.5;
	claws_active = false;
	state_next_set(boss_francis_states.buzzsaw);
	screen_shake(0, 16);
}