/// @description Init

enum boss_cinge_states
{
	intro = 0,
	normal,
	shoot,
	fireball,
	stun,
	stun_ground,
	get_up,
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

boss_name = "Cinge";
hp_init(20);

hitbox.shape_x1 = -40;
hitbox.shape_y1 = -40;
hitbox.shape_x2 = 40;
hitbox.shape_y2 = 80;
hitbox.active = hitbox_active.active;

collider_detector_sides_set(-40,, 40,, 80);
collider_detector_up_set(-40,, 40,, -60);
collider_detector_down_set(-40,, 40,, 80);

if (global.boss_phase == 1)
{
	hp = 10;
	instance_create_layer(0, 0, "layer_instances", obj_boss_cinge_heat_haze);
}

switch (global.difficulty)
{
	case difficulty_levels.easy:
		shoot_speed = 3.5;
		counter_max = 3;
		shoot_timer = 40;
		break;	
	case difficulty_levels.normal:
		shoot_speed = 4;
		counter_max = 4;
		shoot_timer = 32;
		break;
	case difficulty_levels.hard:
		shoot_speed = 6;
		counter_max = 6;
		shoot_timer = 8;
		break;
}
	
state_next_set(boss_cinge_states.normal);