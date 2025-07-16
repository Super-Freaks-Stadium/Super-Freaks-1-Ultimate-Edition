/// @description Step

var _player;
var _shoot_obj, _shoot_instance, _shoot_x, _shoot_y, _shoot_speed, _shoot_angle;
var _zone_index = zone_index;

switch (trigger_id)
{
	case -1:
		break;
	default:
		if (trigger_get(trigger_id))
		{
			if (active == false)
			{
				active = true;
				timer = -shoot_frequency_delay;
				ammo = ammo_amount;
			}
		}
		else
			active = false;
		break;
}

if (active)
{
	if (face_player)
	{
		_player = player_nearest_alive();
	
		if (!is_undefined(_player))
			angle = lerp_360(angle, point_direction(x, y, _player.x, _player.y), 0.25);
	}
	
	timer++;
	if (ammo == 0)
	{
		if (timer >= reload_timer)
		{
			timer = 0;
			ammo = ammo_amount;
		}
	}
	else if (timer >= shoot_frequency)
	{
		if (in_view())
			sfx_play_global(sfx_explode_short);
		switch (weapon)
		{
			case "Bomb":
				_shoot_obj = obj_kranibomb;
				break;
			case "Missile":
				_shoot_obj = obj_enemy_missile;
				break;
		}
		_shoot_x = x + lengthdir_x(16, angle);
		_shoot_y = y + lengthdir_y(16, angle);
		_shoot_speed = shoot_speed;
		_shoot_angle = angle;
		_shoot_instance = instance_create_layer(_shoot_x, _shoot_y, "layer_instances", _shoot_obj,
		{
			speed: _shoot_speed,
			direction: _shoot_angle,
			zone_index: _zone_index
		});
		timer = 0;
		if (ammo > 0)
			ammo = max(ammo - 1, 0);
	}
}

if (angle < 0)
{
	angle += 360;
	angle_previous += 360;
}
else if (angle >= 360)
{
	angle -= 360;
	angle_previous -= 360;
}