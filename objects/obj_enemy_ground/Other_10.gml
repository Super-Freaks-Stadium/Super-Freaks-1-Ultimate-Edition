/// @description Step

var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;

collision_flags = 0;

hurt_timer_step();
enemy_behavior_ground(speed_walk,,speed_walk);

_collision_left = collision_flag_get_left();
_collision_up = collision_flag_get_up();
_collision_right = collision_flag_get_right();
_collision_down = collision_flag_get_down();
		
if (_collision_left)
{
	if (speed_h < 0)
	{
		speed_h = -speed_h;
		face = 1;
	}
}
if (_collision_right)
{
	if (speed_h > 0)
	{
		speed_h = -speed_h;
		face = -1;
	}
}
if (_collision_up)
{
	if (speed_v < 0)
	{
		speed_v = 0;
		sfx_play_local(sfx_honk);
	}
}
if (_collision_down)
{
	if (_collision_up)
	{
		player_hit_speed_x = 0;
		hp = 0;
		event_user(5);
	}
	if (speed_v > 0)
	{
		speed_v = 0;
		ground_on = true;
	}
}
else
{
	ground_on = false;
	collider_attach_clear();
}
