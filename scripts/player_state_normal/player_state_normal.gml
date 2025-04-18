function player_state_normal()
{
	var _collider, _collider_speed_x, _collider_speed_y;
	var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;
	var _move_h = 0, _move_v = 0;
    var _move = new vector2(0, 0);
	var _speedup_h = 0;
    var _speed_true;
	var _speed_run = speed_run;
	var _speed_fall = speed_fall;
	var _speed_acc = speed_acc, _speed_dec = speed_dec, _speed_frc = speed_frc;
	var _speed_frc_air = speed_frc_air;
    var _anti_freak_jump_min = 5 * (underwater || jetpack);
	
	if (global.story_mode == story_modes.swordsman)
		_speed_run += (AURA_WALK * (aura / 100));
	
	if (jetpack)
	{
		_speed_dec = _speed_acc;
		_speed_frc_air = 0.9;
	}
	
	if (state_begin)
	{
		visible = true;
		camera.active = true;
		rubber_band_can_slingshot = true;
		hitbox.active = hitbox_active.active;
	}
	
	behavior_ceiling = 0;
	behavior_floor = 0;
	behavior_wall = 0;
	behavior_wall_left = 0;
	behavior_wall_right = 0;
	
	hurt_timer_step();
	player_water_step();
	if (underwater)
		_speed_fall = max(_speed_fall - 2, 0);
	instance_attach = undefined;
		
	player_pause_game();
		
	switch (physics)
	{
		case player_physics_modifiers.slime:
		case player_physics_modifiers.rail:
			if (lock_controls_horizontal == 0)
			{
				if (input_check("left", player_number))
					_speedup_h -= 1;
				if (input_check("right", player_number))
					_speedup_h += 1;
			}
			break;
		default:
			if (lock_controls_horizontal == 0)
			{
				if (input_check("left", player_number))
					_move_h -= 1;
                    _move.x = input_x("left", "right", "up", "down", player_number);
				if (input_check("right", player_number))
					_move_h += 1;
                    _move.x = input_x("left", "right", "up", "down", player_number);
			}
			break;
	}
	_move_h *= mirror_flip_get();
    _move.x *= mirror_flip_get();
	_speedup_h *= mirror_flip_get();
	if (lock_controls_vertical == 0)
	{
		if (input_check("up", player_number))
			_move_v -= 1;
            _move.y = input_y("left", "right", "up", "down", player_number);
		if (input_check("down", player_number))
			_move_v += 1;
            _move.y = input_y("left", "right", "up", "down", player_number);
	}
			
	if (input_check_pressed("jump", player_number))
		jump_buffer = JUMP_BUFFER_MAX;
	jump_buffer = max(jump_buffer - 1, 0);

	if (!ground_on)
	{
		if (lock_gravity <= 0 && speed_v < speed_fall && !jetpack)
		{
			if (!input_check("jump", player_number) && speed_v < -1)
				speed_v += min(speed_grv * 2, _speed_fall - speed_v);
			else
				speed_v += min(speed_grv, _speed_fall - speed_v);
		}
		coyote_time = max(coyote_time - 1, 0);
		angle = 0;
		_speed_acc = speed_acc_air;
		_speed_dec = speed_dec_air;
		_speed_frc = speed_frc_air;
	}
			
	#region Horizontal Movement
    if (!jetpack)
    {
		switch (_move_h)
		{
			case -1:
				if (speed_h > 0)
				{
					speed_h += -_speed_dec;
					platform_jump_off = false;
					if (ground_on)
						skid = true;
				}
				else
				{
					if (speed_h >= -_speed_run)
						speed_h = max(speed_h - _speed_acc, -_speed_run);
					else
                        if (lock_friction == 0)
                            player_friction_normal(_speed_frc, _speed_frc_air);
					face = -1;
					skid = false;
				}
				break;
			case 0:
				if (physics != player_physics_modifiers.rail)
					player_friction_normal(_speed_frc, _speed_frc_air);
				break;
			case 1:
				if (speed_h < 0)
				{
					speed_h += _speed_dec;
					platform_jump_off = false;
					if (ground_on)
						skid = true;
				}
				else
				{
					if (speed_h <= _speed_run)
						speed_h = min(speed_h + _speed_acc, _speed_run);
					else
                        if (lock_friction == 0)
						  player_friction_normal(_speed_frc, _speed_frc_air);
					face = 1;
					skid = false;
				}
				break;
		}
    }
	#endregion
	
	#region Jetpack Movement
		if (jetpack)
		{
            var _speed_run_jetpack = _speed_run * 1.2;
            var _target_speed = _move.multiply(_speed_run_jetpack); 
            var _speed = new vector2(speed_h, speed_v);
            
            if (_move.x != 0) 
            {
                if (sign(_move.x) != sign(_speed.x))
                    _speed.x = move_toward(_speed.x, _target_speed.x, _speed_dec);
                else 
                {
                    if (_speed.x * sign(_target_speed.x) <= abs(_target_speed.x))
                        _speed.x = move_toward(_speed.x, _target_speed.x, _speed_acc);
                    else
                        if (lock_friction == 0)
                            _speed.x *= _speed_frc_air
                    if (sign(_speed.x) != 0) 
                        face = sign(_speed.x); 
                }
            } 
            else 
                _speed.x *= _speed_frc_air;
            
            if (_move.y != 0)
            {
                if (sign(_move.y) != sign(_speed.y))
                    _speed.y = move_toward(_speed.y, _target_speed.y, _speed_dec);
                else
                {
                    if (_speed.y * sign(_target_speed.y) <= abs(_target_speed.y))
                        _speed.y = move_toward(_speed.y, _target_speed.y, _speed_acc);
                    else
                        if (lock_friction == 0)
                            _speed.y *= _speed_frc_air;
                }
            }
            else
                _speed.y *= _speed_frc_air;
                    
                    //if (_move.dot(_speed) < 0.0)
                    //    _speed = _speed.move_toward(_target_speed, _speed_dec);
                    //else
                    //    if _speed.project(_target_speed).rotated(-_target_speed.angle()).x < _target_speed.length()
                    //        _speed = _speed.move_toward(_target_speed, _speed_acc);
                    //    else
                    //        _speed = _speed.multiply(_speed_frc_air)
                    //    if (sign(_speed.x) != 0)
                    //        face = sign(_speed.x);
                    
            speed_h = _speed.x;
            speed_v = _speed.y;
        }
            
			//switch (_move_v)
			//{
			//	case -1:
			//		if (speed_v > 0)
			//			speed_v += -_speed_dec;
			//		else
			//		{
			//			if (speed_v >= -_speed_run)
			//				speed_v = max(speed_v - _speed_acc, -_speed_run);
			//			else
			//				speed_v *= _speed_frc_air;
			//		}
			//		ground_on = false;
			//		break;
			//	case 0:
			//		speed_v *= _speed_frc_air;
			//		break;
			//	case 1:
			//		if (speed_v < 0)
			//			speed_v += _speed_dec;
			//		else
			//		{
			//			if (speed_v <= _speed_run)
			//				speed_v = min(speed_v + _speed_acc, _speed_run);
			//			else
			//				speed_v *= _speed_frc_air;
			//		}
			//		break;
			//}
	#endregion
	
	
	if (global.story_mode == story_modes.anti_freaks)
	{
		if (input_check_pressed("jump", player_number))
		{
			if (!ground_on)
				can_fireball = true;
			else
				can_fireball = false;
		}
			
		if (can_fireball)
		{
			if (input_check("jump", player_number))
			{ 
                if (aura_stored == 0)
                    aura_stored = aura;
                
				if (aura_stored > ANTI_FREAK_WEAK)
				{
					if (jump_strength < JUMP_STRENGTH_MAX)
					{
						jump_strength++;
                        if (jump_strength == _anti_freak_jump_min)
                            aura = max(aura - 7, 0);
						if (jump_strength > _anti_freak_jump_min)
							aura = max(aura - 1.5, 0);
					}
					if (jump_strength > _anti_freak_jump_min)
						instance_create_layer(x - 12 + random(24), y - 12 + random(24), "layer_instances", obj_yorb_collected_single);
				}
			}
            
			if (input_check_released("jump", player_number))
			{
				if (jump_strength > _anti_freak_jump_min)
				{
					jump_buffer = 0;
					coyote_time = 0;
					ground_on = false;
					ball = true;
					skid = false;
					if (jetpack) 
                    {
                        if (_move.x != 0 || _move.y != 0)
                        {
                            _speed_true = lerp(2, 16, jump_strength / JUMP_STRENGTH_MAX);
                            speed_h = lengthdir_x(_speed_true, point_direction(0, 0, _move.x, _move.y));
                            speed_v = lengthdir_y(_speed_true, point_direction(0, 0, _move.x, _move.y));
                        }
                        else
                            speed_h *= lerp(1, 4, jump_strength / JUMP_STRENGTH_MAX);
                        jump_buffer = JUMP_BUFFER_MAX;
                    }
                    else
                    {
                        if (physics == player_physics_modifiers.rail)
                            speed_h *= lerp(1, 1.25, jump_strength / JUMP_STRENGTH_MAX); 
                        else
                            speed_h *= lerp(1, 4, jump_strength / JUMP_STRENGTH_MAX);
                        speed_v = -lerp(speed_jump, speed_jump * 1.5, jump_strength / JUMP_STRENGTH_MAX);
                    }
					sfx_play_global(sfx_explode_short);
					_collider = collider_attach[collider_attach_data.collider];
					if (!is_undefined(_collider))
					{
						_collider_speed_x = collider_attach[collider_attach_data.speed_x];
						_collider_speed_y = collider_attach[collider_attach_data.speed_y];
                        if (!jetpack)
                        {
						    speed_h += _collider_speed_x;
						    speed_v = min(speed_v, _collider_speed_y);
                        }
						collider_attach_clear();
					}
				}
				jump_strength = JUMP_STRENGTH_MIN;
				aura_stored = 0;
                can_fireball = false;
			}
		}
	}
	
	if (jump_buffer > 0)
	{
		if (jetpack)
		{
			if (!ball || jetpack_jump_timer < 8)
			{
				ball = true;
				sfx_play_global(player_jumpsound_get(character_index));
				jetpack_jump_timer = JETPACK_JUMP_TIMER_MAX;
			}
			ground_on = false;
		}
		else
		{
			if (!ball)
				ball = true;
				
			if (!underwater && ground_on) || (underwater) || (coyote_time > 0)
			{
				sfx_play_global(player_jumpsound_get(character_index));
				switch (global.story_mode)
				{
					default:
						speed_v = -speed_jump;
						break;
					case story_modes.swordsman:
						speed_v = -(speed_jump + (AURA_JUMP * (aura / 100)));
						break;
				}
				
				ground_on = false;
				coyote_time = 0;
				if (skid)
				{
					speed_h = 0;
					skid = false;
				}
				jump_buffer = 0;
			
				_collider = collider_attach[collider_attach_data.collider];
				if (!is_undefined(_collider))
				{
					_collider_speed_x = collider_attach[collider_attach_data.speed_x];
					_collider_speed_y = collider_attach[collider_attach_data.speed_y];
					speed_h += _collider_speed_x;
					speed_v = min(speed_v, _collider_speed_y);
					collider_attach_clear();
				}
			}
		}
	}

	if (ground_on)
	{
		speed_x = lengthdir_x(speed_h, angle_ground);
		speed_y = lengthdir_y(speed_h, angle_ground);
	}
	else
	{
		speed_x = speed_h;
		speed_y = speed_v;
	}
		
	x += speed_x;
	y += speed_y;
		
	switch sign(x - x_previous)
	{
		case -1:
			collision_right_simple(,,,,,,, false);
			collision_left(x_start_frame - collider_detector_sides_width_get(), x - collider_detector_sides_width_get());
			behavior_wall_left = global.collider_collision[collider_collision.behavior];
			break;
		case 0:
			collision_left_simple();
			behavior_wall_left = global.collider_collision[collider_collision.behavior];
			collision_right_simple();
			behavior_wall_right = global.collider_collision[collider_collision.behavior];
			break;
		case 1:
			collision_left_simple(,,,,,,, false);
			collision_right(x_start_frame + collider_detector_sides_width_get(), x + collider_detector_sides_width_get());
			behavior_wall_right = global.collider_collision[collider_collision.behavior];
			break;
	}
		
	if (ground_on)
	{
		collision_up_simple();
		behavior_ceiling = global.collider_collision[collider_collision.behavior];
		collision_down_simple(,,,, 16,, true);
		angle_ground = global.collider_collision[collider_collision.angle];
		behavior_floor = global.collider_collision[collider_collision.behavior];
	}
	else
	{
		switch sign(y - y_previous)
		{
			case -1:
				collision_down_simple(,,,,,,, false);
				collision_up(,,, y_start_frame + collider_detector_up_y_get(), y + collider_detector_up_y_get());
				behavior_ceiling = global.collider_collision[collider_collision.behavior];
				break;
			case 0:
			case 1:
				collision_up_simple();
				behavior_ceiling = global.collider_collision[collider_collision.behavior];
				collision_down(,,, y_start_frame + collider_detector_down_y_get(), y + collider_detector_down_y_get(),, true);
				angle_ground = global.collider_collision[collider_collision.angle];
				behavior_floor = global.collider_collision[collider_collision.behavior];
				break;
		}
	}
		
	_collision_left = collision_flag_get_left();
	_collision_up = collision_flag_get_up();
	_collision_right = collision_flag_get_right();
	_collision_down = collision_flag_get_down();
		
	if (_collision_left)
	{
		crush_flags = bit_set(crush_flags, collision_flag_bits.left);
		if (speed_h < 0)
		{
			speed_h = 0;
			if (behavior_wall_left != collider_behaviors_solid.ice && !jetpack && !underwater && !_collision_down && (((_move_h == -1 && speed_y > -3) || walljump_auto > 0)))
			{
				face = -1;
				state_next_set(player_states.wall_slide);
			}
		}
		switch (behavior_wall_left)
		{
			case collider_behaviors_solid.hazard:
				physics = player_physics_modifiers.normal;
				player_hurt();
				break;
			default:
				//physics = player_physics_modifiers.normal;
				break;
		}
	}
	if (_collision_right)
	{
		crush_flags = bit_set(crush_flags, collision_flag_bits.right);
		if (speed_h > 0)
		{
			speed_h = 0;
			if (behavior_wall_right != collider_behaviors_solid.ice && !jetpack && !underwater && !_collision_down && (((_move_h == 1 && speed_y > -3) || walljump_auto > 0)))
			{
				face = 1;
				state_next_set(player_states.wall_slide);
			}
		}
		switch (behavior_wall_right)
		{
			case collider_behaviors_solid.hazard:
				physics = player_physics_modifiers.normal;
				player_hurt();
				break;
			default:
				//physics = player_physics_modifiers.normal;
				break;
		}
	}
	if (_collision_up)
	{
		crush_flags = bit_set(crush_flags, collision_flag_bits.up);
		if (speed_v < 0)
		{
			speed_v = 0;
			if (sign(y - yprevious) == -1)
				sfx_play_global(sfx_honk);
		}
		if (behavior_ceiling == collider_behaviors_solid.hazard)
			player_hurt();
	}
	if (_collision_down)
	{
		crush_flags = bit_set(crush_flags, collision_flag_bits.down);
		if (speed_v >= 0)
		{
			speed_v = 0;
			if (!ground_on && !jetpack)
			{
				ground_on = true;
				platform_jump_off = false;
				ball = false;
				walljump_auto = 0;
			}
			switch (behavior_floor)
			{
				case collider_behaviors_solid.NA:
					player_physics_set_normal();
					break;
				case collider_behaviors_solid.hazard:
					physics = player_physics_modifiers.normal;
					player_hurt();
					break;
				case collider_behaviors_solid.ice:
					player_physics_set_ice();
					break;
				case collider_behaviors_solid.sticky:
					if (physics != player_physics_modifiers.slime)
					{
						physics = player_physics_modifiers.slime;
						speed_h = 0;
						sfx_play_global(sfx_splat);
					}
					break;
				case collider_behaviors_solid.rail:
					if (physics != player_physics_modifiers.rail)
						physics = player_physics_modifiers.rail;
						
					//speed_h = 5 * face + _speedup_h;
					break;
				case collider_behaviors_solid.rail_left:
					if (physics != player_physics_modifiers.rail)
						physics = player_physics_modifiers.rail;
						
					//speed_h = -5 + _speedup_h;
					if (speed_h < -12 || speed_h > -4)
						speed_h = approach(speed_h, clamp(speed_h, -12, -4), 2);
					speed_h = approach(speed_h, -5 + _speedup_h, 0.1);
					break;
				case collider_behaviors_solid.rail_right:
					if (physics != player_physics_modifiers.rail)
						physics = player_physics_modifiers.rail;
						
					//speed_h = 5 + _speedup_h;
					if (speed_h < 4 || speed_h > 12)
						speed_h = approach(speed_h, clamp(speed_h, 4, 12), 2);
					speed_h = approach(speed_h, 5 + _speedup_h, 0.1);
					break;
			}
		}
	}
	else
	{
		if (ground_on)
		{
			ground_on = false;
			skid = false;
			coyote_time = COYOTE_TIME_MAX;
			angle_ground = 0;
			speed_h = speed_x;
			speed_v = speed_y;
		}
		collider_attach_clear();
		if (physics == player_physics_modifiers.slime)
			physics = player_physics_modifiers.normal;
	}
	
	player_fall();
		
	#region Sprites
		if (ground_on)
		{
			if (physics == player_physics_modifiers.rail)
			{
				sprite_index = player_animation_get(character_index, player_animations.rail_grind);
				image_index = 0;
				animate_speed = 0;
			}
			else
			{
				if (skid)
				{
					sprite_index = player_animation_get(character_index, player_animations.skid);
					image_index = 0;
					animate_speed = 0;
				}
				else
				{
					if (abs(speed_h) > 0)
					{
						sprite_index = player_animation_get(character_index, player_animations.walk);
						animate_speed = 0.125;
					}
					else
					{
						sprite_index = player_animation_get(character_index, player_animations.idle);
						image_index = 0;
						animate_speed = 0;
					}
				}
			}
		}
		else
		{
			if (ball)
			{
				sprite_index = player_animation_get(character_index, player_animations.jump);
				animate_speed = 0.25;
			}
			else
			{
				sprite_index = player_animation_get(character_index, player_animations.air);
				animate_speed = 0;
				
				if ((y - y_previous) < -2)
					image_index = 0;
				else if ((y - y_previous) > 2)
					image_index = 2;
				else
					image_index = 1;
			}
		}
	#endregion
}