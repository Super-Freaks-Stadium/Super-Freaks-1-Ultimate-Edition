/// @description Init

enum boss_marrow1_states
{
	intro = 0,
	idle,
	finger_raise,
}

// Inherit the parent event
event_inherited();

hp_init(20);
timer = 0;
yorb_amount = 20;

hitbox = new comp_hitbox_AABB(,, hitbox_active.passive, enemy_hitbox_behaviors.heavy,, -72, -72, 72, 72);
depth = 5;
boss_name = "Marrow Prime";
state_next_set(boss_marrow1_states.idle);