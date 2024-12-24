/// @description Init

enum boss_francis_states
{
	intro = 0,
	higher,
	lower,
	buzzsaw,
	death,
}

// Inherit the parent event
event_inherited();

boss_name = "Francis";
hp_init(12);

size = 1;

speed_h_max = 2;

timer = 0;
counter_attack = 0;

claw_side = 0;

claws_active = true;
claw_left_index = 0;
claw_left_timer = 0;
claw_left_pos = 225;
claw_left_pos_previous = claw_left_pos;
claw_left_angle = 270
claw_left_angle_previous = claw_left_angle;

claw_right_index = 0;
claw_right_timer = 0;
claw_right_pos = 315;
claw_right_pos_previous = claw_right_pos;
claw_right_angle = 270;
claw_right_angle_previous = claw_right_angle;

chain_segments = 6;
chain_size = 0;

hitbox = new comp_hitbox_circle(,,, enemy_hitbox_behaviors.heavy,, 112);
hitbox_buzzsaw = new comp_hitbox_circle(,, hitbox_active.inactive, enemy_hitbox_behaviors.hazard,, 32);
hitbox_buzzsaw_2 = new comp_hitbox_circle(,, hitbox_active.inactive, enemy_hitbox_behaviors.hazard,, 32);
buzzsaw_angle = 0;
buzzsaw_angle_previous = 0;
buzzsaw_x = 0;
buzzsaw_y = 0;
buzzsaw_x_previous = 0;
buzzsaw_y_previous = 0;
swing_speed = 0;

attack_frequency = 32;
attack_times = 6;
switch (global.difficulty)
{
	case difficulty_levels.easy:
		attack_frequency = 64;
		attack_times = 6;
		break;
	case difficulty_levels.normal:
		attack_frequency = 48;
		attack_times = 8;
		break;
	case difficulty_levels.hard:
		attack_frequency = 32;
		attack_times = 12;
		break;
}

cockpit_sprite = spr_boss_francis_cockpit_normal;
cockpit_index = 0;
cockpit_timer = 0;

switch (global.boss_phase)
{
	case 0:
		state_next_set(boss_francis_states.intro);
		speed_h_max = 1;
		hp = 12;
		break;
	case 1:
		state_next_set(boss_francis_states.higher);
		size = 1;
		speed_h_max = 1;
		hp = 12;
		break;
	case 2:
		state_next_set(boss_francis_states.higher);
		size = 0.75;
		speed_h_max = 2;
		hp = 9;
		break;
	case 3:
		state_next_set(boss_francis_states.buzzsaw);
		size = 0.5;
		speed_h_max = 1;
		claws_active = false;
		hp = 6;
		y = 736;
		break;
	case 4:
		state_next_set(boss_francis_states.death);
		size = 0.5;
		speed_h_max = 0;
		claws_active = false;
		hp = 0;
		y = 736;
		break;
}

size_multiplier = size;
size_multiplier_previous = size;
chain_size_previous = chain_size;

depth = 5;
