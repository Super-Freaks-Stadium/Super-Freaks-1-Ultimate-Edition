/// @description 
var _radius = 64;

// Inherit the parent event
event_inherited();

enum boss_kranion_final_states
{
	intro_1 = 0,
	intro_2,
	idle,
	spikes_expand,
	spikes_retract,
	bounce,
	suction,
	death_1,
	death_2,
}

if (global.story_mode == story_modes.kranion)
	boss_name = "Cranion Ultimate Edition";
else
	boss_name = "Kranion Ultimate Edition";
hp_init(12);
	
hitbox = new comp_hitbox_circle(,,, enemy_hitbox_behaviors.heavy,, _radius);
collider_detector_up_set(-_radius + 4, 0, _radius - 4, 0, -_radius);
collider_detector_down_set(-_radius + 4, 0, _radius - 4, 0, _radius);
collider_detector_sides_set(-_radius + 4, 0, _radius - 4, 0, _radius);

depth = 3;
state_next_set(boss_kranion_final_states.intro_1);

face_angle = 0;
face_angle_previous = 0;
face_rotate_speed = 0;
aura_size = 1;
aura_angle = 0;
aura_angle_previous = 0;
spike_size = 0;
spike_angle = 0;
spike_angle_previous = 0;
spike_speed = 0;
animate_speed = 0.25;

switch (global.story_mode)
{
	case story_modes.kranion:
		sprite_aura = spr_boss_cranion_ultimate_aura;
		sprite_spikes = spr_boss_cranion_ultimate_spikes;
		sprite_face = spr_boss_cranion_ultimate_face;
		sprite_death = spr_boss_cranion_death;
		break;
	default:
		sprite_aura = spr_boss_kranion_ultimate_aura;
		sprite_spikes = spr_boss_kranion_ultimate_spikes;
		sprite_face = spr_boss_kranion_ultimate_face;
		sprite_death = spr_boss_kranion_death;
		break;
}