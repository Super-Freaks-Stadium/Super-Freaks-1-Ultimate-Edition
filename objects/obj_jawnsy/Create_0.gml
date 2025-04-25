/// @description Init

var _target;

// Inherit the parent event
event_inherited();

enum enemy_jawnsy_states
{
	swim = 0,
	prepare,
	jump,
}

can_despawn = false;
speed_swim = 10;
speed_acc = 0.125;
speed_dec = 0.25;
speed_grv = 0.25;
timer = 0;
hitbox = new comp_hitbox_circle(,,, enemy_hitbox_behaviors.hazard,, 48);
animate_speed = 0.25;
fast_forward_setting = fast_forward;

if (global.checkpoint[spawn_point_data.go_to_checkpoint] == true)
	_target = global.checkpoint[spawn_point_data.x];
else	
	_target = global.spawn_point[spawn_point_data.x];

if (!is_undefined(_target))
	x = _target;
y = global.water_height;