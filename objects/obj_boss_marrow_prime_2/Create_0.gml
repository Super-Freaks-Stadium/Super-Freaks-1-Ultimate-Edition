/// @description Init

enum boss_marrow2_states
{
	intro = 0,
	idle,
	finger_raise,
	jump,
	charge,
	death,
}

// Inherit the parent event
event_inherited();

hp_init(30);

timer = 0;
yorb_amount = 20;

hitbox = new comp_hitbox_AABB(,, hitbox_active.passive, enemy_hitbox_behaviors.heavy,, -48, -64, 48, 96);
face = 1;
depth = 5;
boss_name = "Marrow Prime";
speed_h = 0;
cast_counter = 0;
cast_counter_max = 3;
state_next_set(boss_marrow2_states.jump);

collider_detector_down_set(,,,, 96);
collider_detector_sides_set(,,,, 48);