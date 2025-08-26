/// @description 

var _hitbox_self = global.hitbox_collision_stored[hitbox_collision_stored_data.hitbox];
var _hitbox_self_x = _hitbox_self.x_offset + x;
var _hitbox_self_y = _hitbox_self.y_offset + y;
var _hitbox_player = global.hitbox_collision_stored[hitbox_collision_stored_data.hitbox_other];
var _hitbox_player_behavior = _hitbox_player.behavior;
var _enemy_hurt = false;
var _player_hurt = false;
var _enemy_hurt_timer = hurt_timer;
var _direction;

player_hit = other;
player_hit_speed_x = other.x - other.x_start_frame;
player_hit_speed_y = other.y - other.y_start_frame;

switch (_hitbox_self.behavior)
{
	case enemy_hitbox_behaviors.normal:
		if (other.ball)
		{
			with (other)
			{
				if (jetpack)
				{
					if (_enemy_hurt_timer == 0)
					{
						jetpack_jump_timer = JETPACK_JUMP_TIMER_MAX;
						lock_friction = 8;
						speed_h *= 1.5;
						speed_v *= 1.5;
						_enemy_hurt = true;
					}
				}
				else
				{
					if (_enemy_hurt_timer == 0 || speed_v >= 0)
					{
						speed_v = min(speed_v, -speed_jump);
						_enemy_hurt = true;
					}
				}
			}
		}
		else
		{
			if (other.star_arrow > 0 || other.ego_invincible > 0)
				_enemy_hurt = true;
			else
				_player_hurt = true;
		}
		break;
	case enemy_hitbox_behaviors.heavy:
		with (other)
		{
			if (ball)
			{
				//speed_h = 4 * sign(x - _hitbox_self_x);
				_enemy_hurt = true;
				if (underwater || jetpack)
				{
					//speed_h = 4 * sign(-speed_h);
					//speed_v = 4 * sign(-speed_v);
					speed_h = 4 * sign(((x + x_start_frame) / 2) - _hitbox_self_x);
					speed_v = 4 * sign(((y + y_start_frame) / 2) - _hitbox_self_y);
					jetpack_jump_timer = JETPACK_JUMP_TIMER_MAX;
					lock_friction = 8;
					lock_controls_vertical = 20;
				}
				else
				{
					//speed_h = 4 * sign(-speed_h);
					speed_h = 4 * sign(((x + x_start_frame) / 2) - _hitbox_self_x);
					speed_v = 3 * sign(((y + y_start_frame) / 2) - _hitbox_self_y);
					//speed_v = min(speed_v, -5);
				}
				lock_controls_horizontal = 20;
			}
			else
			{
				if (star_arrow > 0 || ego_invincible > 0)
					_enemy_hurt = true;
				else
					_player_hurt = true;
			}
				
			repeat(32)
			{
				if (hitbox_collision_check(_hitbox_self, _hitbox_player))
				{
					x += sign(x - _hitbox_self_x);
					//x += speed_h * 2;
					if (!ground_on)
						y += sign(y - _hitbox_self_y);
						//y += speed_v * 2;
				}
				else
					break;
			}
		}
		break;
	case enemy_hitbox_behaviors.heavy_360:
		with (other)
		{
			if (ball)
			{
				//speed_h = 4 * sign(x - _hitbox_self_x);
				_enemy_hurt = true;
				_direction = point_direction(_hitbox_self_x, _hitbox_self_y, x, y);
				if (underwater || jetpack)
				{
					//speed_h = 4 * sign(-speed_h);
					//speed_v = 4 * sign(-speed_v);
					speed_h = lengthdir_x(4, _direction);
					speed_v = lengthdir_y(4, _direction);
					jetpack_jump_timer = JETPACK_JUMP_TIMER_MAX;
					lock_friction = 8;
					lock_controls_vertical = 20;
				}
				else
				{
					//speed_h = 4 * sign(-speed_h);
					speed_h = lengthdir_x(4, _direction);
					speed_v = lengthdir_y(4, _direction);
					//speed_v = min(speed_v, -5);
				}
				lock_controls_horizontal = 20;
			}
			else
			{
				if (star_arrow > 0 || ego_invincible > 0)
					_enemy_hurt = true;
				else
					_player_hurt = true;
			}
				
			repeat(32)
			{
				if (hitbox_collision_check(_hitbox_self, _hitbox_player))
				{
					x += sign(x - _hitbox_self_x);
					//x += speed_h * 2;
					if (!ground_on)
						y += sign(y - _hitbox_self_y);
						//y += speed_v * 2;
				}
				else
					break;
			}
		}
		break;
	case enemy_hitbox_behaviors.heavy_invulnerable:
		with (other)
		{
			if (ball)
			{
				sfx_play_global(sfx_honk);
				//speed_h = 4 * sign(x - _hitbox_self_x);
				if (underwater || jetpack)
				{
					speed_h = 4 * sign(-speed_h);
					speed_v = 4 * sign(-speed_v);
					jetpack_jump_timer = JETPACK_JUMP_TIMER_MAX;
					lock_friction = 8;
					lock_controls_vertical = 20;
				}
				else
				{
					//speed_h = 4 * sign(-speed_h);
					speed_h = 4 * sign(((x + x_start_frame) / 2) - _hitbox_self_x);
					speed_v = 3 * sign(((y + y_start_frame) / 2) - _hitbox_self_y);
					//speed_v = min(speed_v, -5);
				}
				lock_controls_horizontal = 20;
			}
			else
			{
				if (star_arrow > 0 || ego_invincible > 0)
					_enemy_hurt = true;
				else
					_player_hurt = true;
			}
				
			repeat(32)
			{
				if (hitbox_collision_check(_hitbox_self, _hitbox_player))
				{
					x += sign(x - _hitbox_self_x);
					//x += speed_h * 2;
					if (!ground_on)
						y += sign(y - _hitbox_self_y);
						//y += speed_v * 2;
				}
				else
					break;
			}
		}
		break;
	case enemy_hitbox_behaviors.hazard:
		with (other)
		{
			if (hurt_timer == 0)
			{
				if (star_arrow > 0 || ego_invincible > 0)
					_enemy_hurt = true;
				else
					player_hurt();
			}
		}
		break;
	case enemy_hitbox_behaviors.heavy_hazard:
		with (other)
		{
			if (hurt_timer == 0)
			{
				if (star_arrow > 0 || ego_invincible > 0)
					_enemy_hurt = true;
				else
					player_hurt();
			}
		
			repeat(32)
			{
				if (hitbox_collision_check(_hitbox_self, _hitbox_player))
				{
					x += sign(x - _hitbox_self_x);
					//x += speed_h * 2;
					if (!ground_on)
						y += sign(y - _hitbox_self_y);
						//y += speed_v * 2;
				}
				else
					break;
			}
		}
		break;
	case enemy_hitbox_behaviors.die:
		if (other.star_arrow == 0 && other.ego_invincible == 0)
			_player_hurt = true;
		if (hurt_timer == 0)
			event_user(5);
		break;
	default:
		break;
}

if (_enemy_hurt)
{
	with (other)
	{
		if (physics == player_physics_modifiers.ice)
			player_physics_set_normal();
	}
	if (hurt_timer == 0)
		enemy_hurt();
	else
		sfx_play_global(sfx_bounce_rubber);
}

if (_player_hurt)
{
	if (_enemy_hurt_timer == 0)
	{
		with (other)
			player_hurt();
	}
}
