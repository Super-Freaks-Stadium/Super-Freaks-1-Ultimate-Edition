/// @description Init

enum boss_kranion_states
{
	intro = 0,
	normal,
	spin,
	bounce,
	jump,
	stun,
	death,
}

// Inherit the parent event
event_inherited();

timer = 0;
counter = 0;
counter_max = 0;
shoot = false;
shoot_speed = 0;
shoot_timer = 0;

speed_h = 0;
speed_v = 0;
speed_acc = 0.125;
speed_grv = 0.25;

if (global.story_mode == story_modes.kranion)
	boss_name = "Cranion";
else
	boss_name = "Kranion";
hp_init(12);

face = -1;

hitbox = new comp_hitbox_circle(, 8,, enemy_hitbox_behaviors.heavy,, 64);

collider_detector_sides_set(-40,, 40,, 80);
collider_detector_up_set(-40,, 40,, -60);
collider_detector_down_set(-40,, 40,, 64);
	
state_next_set(boss_kranion_states.normal);

switch (global.story_mode)
{
	case story_modes.kranion:
		sprite_stand = spr_boss_cranion_stand;
		sprite_roll = spr_boss_cranion_roll;
		sprite_spin = spr_boss_cranion_spin;
		sprite_prepare = spr_boss_cranion_prepare;
		sprite_death = spr_boss_cranion_death;
		break;
	default:
		sprite_stand = spr_boss_kranion_stand;
		sprite_roll = spr_boss_kranion_roll;
		sprite_spin = spr_boss_kranion_spin;
		sprite_prepare = spr_boss_kranion_prepare;
		sprite_death = spr_boss_kranion_death;
		break;
}