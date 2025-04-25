/// @description Hurt

// Inherit the parent event
event_inherited();

sprite_index = spr_boss_wartnose_death;

if (global.boss_phase == 0 && hp < 5)
{
	instance_create_layer(x + hitbox.x_offset, y + hitbox.y_offset + 64, "layer_instances", obj_boss_explosion);
	global.boss_phase = 1;
    turbo_time_add(20);
}