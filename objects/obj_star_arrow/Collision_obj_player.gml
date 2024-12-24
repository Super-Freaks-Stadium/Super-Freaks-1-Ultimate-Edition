/// @description 

var _x = x;
var _y = y;
var _launch_speed = launch_speed;
var _launch_duration = launch_duration;
var _direction = image_angle;

with (other)
{
	state_next_set(player_states.normal);
	ball = true;
	ground_on = false;
	x = _x + lengthdir_x(48, _direction);
	y = _y + lengthdir_y(48, _direction);
	speed_h = lengthdir_x(_launch_speed, _direction);
	speed_v = lengthdir_y(_launch_speed, _direction);
	lock_controls_horizontal = _launch_duration;
	lock_controls_vertical = _launch_duration;
	lock_friction = _launch_duration;
	lock_gravity = _launch_duration;
	player_physics_set_normal();
}

//if (hitbox.radius > 8)
//{
	rotate_speed = 16;
    scale_effect_timer = 1.0;
    scale_x = 
	sfx_play_local(sfx_stararrow);
	hitbox.radius = 0;
//}