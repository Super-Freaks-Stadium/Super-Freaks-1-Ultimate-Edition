/// @description Step

var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false, _jump = false;
var _x1 = x - 16, _x2 = x + 16, _y1 = y - 128, _y2 = y;

collision_flags = 0;

hurt_timer_step();

switch (state)
{
	case 0: //Ground
		if (state_begin)
		{
			sprite_index = spr_skizzor_walk;
			image_index = 0;
			animate_speed = 0.125;
		}
		enemy_behavior_ground(speed_acc,,move_speed, speed_grv);
		
		if (ground_on)
		{
			with (obj_player)
			{
				if (!player_is_alive())
					continue;
				if (rectangle_in_rectangle(x + hitbox.shape_x1, y + hitbox.shape_y1, x + hitbox.shape_x2, y + hitbox.shape_y2, _x1, _y1, _x2, _y2))
				{
					_jump = true;
					break;
				}
			}
		}
		
		if (_jump)
			state_next_set(1);

		#region Collision Reaction
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
		#endregion
		break;
	case 1: //Bite
		if (state_begin)
		{
			ground_on = false;
			speed_h = 0;
			speed_v = -5;
			sprite_index = spr_skizzor_bite;
			image_index = 0;
			animate_speed = 0;
		}
		
		speed_v = min(speed_v + speed_grv, 6);
		
		#region Collision Detection
			y += speed_v;
			enemy_collisions_ground(false);
			//switch sign(x - x_previous)
			//{
			//	case -1:
			//		collision_left();
			//		break;
			//	case 0:
			//		collision_left();
			//		collision_right();
			//		break;
			//	case 1:
			//		collision_right();
			//		break;
			//}
			
			//switch sign(y - y_previous)
			//{
			//	case -1:
			//		collision_up(x, x, x);
			//		break;
			//	case 0:
			//	case 1:
			//		collision_up(x, x, x);
			//		collision_down(x, x, x,,,, true);
			//		angle_ground = global.collider_collision[collider_collision.angle];
			//		break;
			//}
		#endregion
		#region Collision Reaction
			_collision_left = collision_flag_get_left();
			_collision_up = collision_flag_get_up();
			_collision_right = collision_flag_get_right();
			_collision_down = collision_flag_get_down();
		
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
				if (speed_v > 0)
				{
					speed_v = 0;
					ground_on = true;
					state_next_set(0);
				}
			}
			else
			{
				ground_on = false;
				collider_attach_clear();
			}
		#endregion
		
		#region Visuals
			if (speed_v > 1)
			{
				image_index = 2;
			}
			else if (speed_v > 0)
			{
				if (image_index == 0)
				{
					image_index = 1;
					sfx_play_local(sfx_bite);
				}
			}
		#endregion
		break;
}

