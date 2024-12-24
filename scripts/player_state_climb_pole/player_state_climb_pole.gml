function player_state_climb_pole()
{
	var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;
	var _move_h = 0, _move_v = 0;
	var _climb_obj, _climb_boundaries = false;
	var _hitbox_width = abs(hitbox.shape_x2 - hitbox.shape_x1);
	
	var _sprite_climb = player_animation_get(character_index, player_animations.pole_climb);
	var _sprite_turn = player_animation_get(character_index, player_animations.pole_turn);
	
	if (state_begin)
	{
		visible = true;
		camera.active = true;
		physics = player_physics_modifiers.normal;
		ball = false;
		speed_h = 0;
		speed_v = 0;
		lock_controls_horizontal = 0;
		lock_controls_vertical = 0;
		lock_friction = 0;
		lock_gravity = 0;
		animate_speed = 0;
		collider_attach_clear();
		with (hitbox)
			active = hitbox_active.active;
		rubber_band_can_slingshot = false;
		physics = player_physics_modifiers.normal;
		sprite_index = _sprite_climb;
	}
	
	hurt_timer_step();
	player_water_step();
		
	if (!is_undefined(instance_attach))
	{
		//if (button_left == controls_action_states.press)
		if (input_check("left", player_number))
			_move_h -= 1;
		//if (button_right == controls_action_states.press)
		if (input_check("right", player_number))
			_move_h += 1;
		_move_h *= mirror_flip_get();
		
		if (instance_attach.rotate_speed == 0)
		{
			//if (button_up == controls_action_states.hold) || (button_up == controls_action_states.press)
			if (input_check("up", player_number))
				_move_v -= 1;
			//if (button_down == controls_action_states.hold) || (button_down == controls_action_states.press)
			if (input_check("down", player_number))
				_move_v += 1;
		}
	}
		
	switch (_move_h)
	{
		case -1:
			if (face == -1)
			{
				face = 1;
				x = instance_attach.x - _hitbox_width;
				x_start_frame = x;
				sprite_index = _sprite_turn;
				image_index = 0;
				animate_speed = 0.25;
			}
			break;
		case 0:
			break;
		case 1:
			if (face == 1)
			{
				face = -1;
				x = instance_attach.x + _hitbox_width;
				x_start_frame = x;
				sprite_index = _sprite_turn;
				image_index = 0;
				animate_speed = 0.25;
			}
			break;
	}
	
	switch (_move_v)
	{
		case -1:
			y -= 2 + (AURA_WALK * (aura / 100));
			if (sprite_index == _sprite_climb)
				animate_speed = 0.125;
			break;
		case 0:
			speed_v = 0;
			if (sprite_index == _sprite_climb)
				animate_speed = 0;
			break;
		case 1:
			y += 4 + (AURA_WALK * (aura / 100));
			if (sprite_index == _sprite_climb)
			{
				image_index = 0;
				animate_speed = 0;
			}
			break;
	}
		
	player_pause_game();
		
	//if (button_jump == controls_action_states.press)
	if (input_check_pressed("jump", player_number))
	{
		jump_buffer = JUMP_BUFFER_MAX;
		state_next_set(player_states.normal, 5);
		sfx_play_local(sfx_jump);
		ball = true;
		speed_h = face * -4;
		speed_v = -speed_jump;
		ground_on = false;
		coyote_time = 0;
		lock_controls_horizontal = 12;
		lock_friction = 12;
		instance_attach = undefined;
	}
	jump_buffer = max(jump_buffer - 1, 0);
	
	if (!is_undefined(instance_attach))
		_climb_boundaries = true;
		
	if (lock_friction == 0)
		speed_v -= min(abs(speed_v), speed_frc) * sign(speed_v);
		
	y += speed_v;
	
	switch sign(y - y_previous)
	{
		case -1:
			if (_climb_boundaries)
			{
				if (!place_meeting(instance_attach.x, instance_attach.bbox_top + 32, obj_pole))
					y = max(y, instance_attach.bbox_top + 32);
			}
			collision_up_simple();
			break;
		case 0:
			collision_up_simple();
			collision_down_simple();
			break;
		case 1:
			collision_down_simple();
			break;
	}
	
	if (_climb_boundaries)
	{
		if (!place_meeting(instance_attach.x, y + 8, obj_pole))
		{
			state_next_set(player_states.normal, 5);
			instance_attach = undefined;
		}
	}
	
	_collision_left = collision_flag_get_left();
	_collision_up = collision_flag_get_up();
	_collision_right = collision_flag_get_right();
	_collision_down = collision_flag_get_down();
		
	if (_collision_left)
	{
		if (speed_h < 0)
			speed_h = 0;
	}
	if (_collision_right)
	{
		if (speed_h > 0)
			speed_h = 0;
	}
	if (_collision_up)
	{
		if (speed_v < 0)
			speed_v = 0;
	}
	if (_collision_down)
	{
		if (speed_v > 0)
			speed_v = 0;
			
		if (_move_v == 1)
		{
			state_next_set(player_states.normal, 5);
			instance_attach = undefined;
			ground_on = true;
			coyote_time = 0;
		}
	}
	
	player_fall();
	
	#region Sprites
		if (sprite_index == _sprite_turn)
		{
			if (animation_at_end())
			{
				sprite_index = _sprite_climb;
				image_index = 0;
				animate_speed = 0;
			}
		}
	#endregion
}
