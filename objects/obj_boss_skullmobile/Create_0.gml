/// @description 

// Inherit the parent event
event_inherited();

enum boss_skullmobile_states
{
	intro = 0,
	intro_2,
	intro_3,
	active,
	death,
}

boss_name = "Skullmobile";
hp_init(12);

state_next_set(boss_skullmobile_states.intro);
laser_distance_previous = 272;
laser_distance = 272;
laser_angle = 0;
laser_angle_previous = laser_angle;
laser_rotate_speed = 0.5;

switch (global.difficulty)
{
	case difficulty_levels.easy:
		laser_rotate_speed = 0.125;
		break;
	case difficulty_levels.normal:
		laser_rotate_speed = 0.25;
		break;
	case difficulty_levels.hard:
		laser_rotate_speed = 0.35;
		break;
}

target = noone;
target_x = x;
target_y = y + 270;
attack_increment = 0;

angle = 270;
angle_previous = angle;

timer = 0;

hitbox = new comp_hitbox_circle(,, hitbox_active.active, enemy_hitbox_behaviors.hazard, 3, 80);
gun_left = new comp_hitbox_circle(,,, enemy_hitbox_behaviors.hazard, 2, 32);
gun_right = new comp_hitbox_circle(,,, enemy_hitbox_behaviors.hazard, 2, 32);
laser_left = new comp_hitbox_capsule(,, hitbox_active.inactive, enemy_hitbox_behaviors.hazard, 0, 0, 0, 0, 0, 16);
laser_right = new comp_hitbox_capsule(,, hitbox_active.inactive, enemy_hitbox_behaviors.hazard, 0, 0, 0, 0, 0, 16);
laser_color = 16;
animate_speed = 0.125;

gun_left_previous = 
{
    x_offset: gun_left.x_offset,
    y_offset: gun_left.y_offset
}
gun_right_previous = 
{
    x_offset: gun_right.x_offset,
    y_offset: gun_right.y_offset
}
laser_left_previous = 
{
    x_offset: laser_left.x_offset,
    y_offset: laser_left.y_offset,
    shape_x2: laser_left.shape_x2,
    shape_y2: laser_left.shape_y2
}
laser_right_previous = 
{
    x_offset: laser_right.x_offset,
    y_offset: laser_right.y_offset,
    shape_x2: laser_right.shape_x2,
    shape_y2: laser_right.shape_y2
}

switch (global.boss_phase)
{
	case 0:
		break;
	case 1:
		hp = 6;
		y = 704;
		state_next_set(boss_skullmobile_states.active, 9999);
		break;
}