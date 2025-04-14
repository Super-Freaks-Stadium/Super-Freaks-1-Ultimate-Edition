/// @description 

var _i;

// Inherit the parent event
event_inherited();

enum boss_milkman_states
{
	intro_1 = 0,
	intro_2,
	normal,
	jump_up,
	move_air,
	fall,
	death,
}

/// @function boss_milkman_activate_arms
/// @param {boolean} _flag = true
function boss_milkman_activate_arms(_flag = true)
{
	var _i, _active = hitbox_active.passive;
	var _last_seg = array_length(arm[0]);
	
	if (_flag == false)
		_active = hitbox_active.inactive;
		
	for (_i = 0; _i < _last_seg; ++_i)
	{
		arm[0][0].active = _active;
		arm[1][0].active = _active;
	}
}

boss_name = "Milk Man";

timer = 0;
counter = 0;
shoot = false;

speed_h = 0;
speed_v = 0;
speed_acc = 0.125;
speed_grv = 0.25;

arm_angle = 0;
arm_angle_previous = 0;
arm_length = 0;
arm_length_previous = 0;
arm_active = false;
arm_extend = false;
arm_speed = 1.5;
arm_offset = -196;

ground_on = false;

shockwave_frequency = 0;

y_offset_yorb = -128;

switch (global.difficulty)
{
	case difficulty_levels.easy:
		shockwave_frequency = 128;
		break;
	case difficulty_levels.normal:
		shockwave_frequency = 112;
		break;
	case difficulty_levels.hard:
		shockwave_frequency = 80;
		break;
}

hp_init(15);
hitbox = new comp_hitbox_AABB(, -232, hitbox_active.inactive, enemy_hitbox_behaviors.heavy,, -80, 0, 80, 150);
hitbox_lower = new comp_hitbox_AABB(, -64, hitbox_active.inactive, enemy_hitbox_behaviors.heavy,, -12, 0, 12, 64);
arm[0][0] = new comp_hitbox_circle(, arm_offset, hitbox_active.inactive, enemy_hitbox_behaviors.hazard,, 24);
arm[1][0] = new comp_hitbox_circle(, arm_offset, hitbox_active.inactive, enemy_hitbox_behaviors.hazard,, 24);

for (_i = 0; _i < 9; ++_i)
{
	array_push(arm[0], new comp_hitbox_circle(, arm_offset, hitbox_active.inactive, enemy_hitbox_behaviors.hazard,,8));
	array_push(arm[1], new comp_hitbox_circle(, arm_offset, hitbox_active.inactive, enemy_hitbox_behaviors.hazard,,8));
}

collider_detector_down_set(-8,, 8,, 0);

if (global.boss_phase == 0)
{
	state_next_set(boss_milkman_states.intro_1);
}
if (global.boss_phase == 1)
{
	state_next_set(boss_milkman_states.normal);
	hp = 15;
	arm_length = 0;
	arm_length_previous = 0;
	arm_active = false;
	arm_extend = false;
}
else if (global.boss_phase == 2)
{
	boss_milkman_activate_arms();
	state_next_set(boss_milkman_states.normal);
	hp = 10;
	arm_length = 1;
	arm_length_previous = 1;
	arm_active = true;
	arm_extend = true;
}
if (global.boss_phase == 3)
{
	state_next_set(boss_milkman_states.death);
	hp = 0;
}