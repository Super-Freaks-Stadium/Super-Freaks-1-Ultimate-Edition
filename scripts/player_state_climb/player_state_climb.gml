function player_state_climb()
{
	var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;
	var _move_h = 0, _move_v = 0;
    var _move = new vector2();
	var _climb_obj, _climb_off = false, _climb_boundaries = false;
	var _player_pos;
	var _climb_speed = speed_run;
    
    _climb_speed *= 1.2;
	
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
		collider_attach_clear();
		with (hitbox)
			active = hitbox_active.active;
		rubber_band_can_slingshot = false;
		physics = player_physics_modifiers.normal;
	}
	
	if (global.story_mode == story_modes.swordsman)
		_climb_speed += (AURA_WALK * (aura / 100))
	
	animate_speed = 0;
	hurt_timer_step();
	player_water_step();
		
	//if (button_left == controls_action_states.hold) || (button_left == controls_action_states.press)
	if (input_check("left", player_number))
		_move_h -= 1;
	//if (button_right == controls_action_states.hold) || (button_right == controls_action_states.press)
	if (input_check("right", player_number))
		_move_h += 1;
	_move_h *= mirror_flip_get();
			
	//if (button_up == controls_action_states.hold) || (button_up == controls_action_states.press)
	if (input_check("up", player_number))
		_move_v -= 1;
	//if (button_down == controls_action_states.hold) || (button_down == controls_action_states.press)
	if (input_check("down", player_number))
		_move_v += 1;
    
    _move.x = input_x("left", "right", "up", "down", player_number);
    _move.y = input_y("left", "right", "up", "down", player_number);
	
	switch (sign(_move.x))
	{
		case -1:
			x -= _climb_speed * abs(_move.x);
			face = -1;
			animate_speed = 0.125 * abs(_move.length());
			break;
		case 0:
			break;
		case 1:
			x += _climb_speed * abs(_move.x);
			face = 1;
			animate_speed = 0.125 * abs(_move.length());
			break;
	}
	
	switch (sign(_move.y))
	{
		case -1:
			y -= _climb_speed * abs(_move.y);
			animate_speed = 0.125 * abs(_move.length());
			break;
		case 0:
			speed_v = 0;
			break;
		case 1:
			y += _climb_speed * abs(_move.y);
			animate_speed = 0.125 * abs(_move.length());
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
		speed_v = -speed_jump;
		ground_on = false;
		coyote_time = 0;
		instance_attach = undefined;
	}
	jump_buffer = max(jump_buffer - 1, 0);
	
	if (!is_undefined(instance_attach))
		_climb_boundaries = true;
		
	if (lock_friction == 0)
	{
		speed_h -= min(abs(speed_h), speed_frc) * sign(speed_h);
		speed_v -= min(abs(speed_v), speed_frc) * sign(speed_v);
	}
		
	x += speed_h;
	y += speed_v;
		
	_player_pos = x;
	switch sign(x - x_previous)
	{
		case -1:
			if (_climb_boundaries)
			{
				with (instance_attach)
					_climb_off = collision_rectangle(bbox_left - 8, bbox_top, bbox_left, bbox_bottom, obj_climb_mesh, false, true);
				if (!_climb_off)
					x = max(x, instance_attach.bbox_left + collider_detector_sides_width_get());
			}
			collision_right_simple(,,,,,,, false);
			collision_left_simple();
			behavior_wall_left = global.collider_collision[collider_collision.behavior];
			break;
		case 0:
			collision_left_simple();
			behavior_wall_left = global.collider_collision[collider_collision.behavior];
			collision_right_simple();
			behavior_wall_right = global.collider_collision[collider_collision.behavior];
			break;
		case 1:
			if (_climb_boundaries)
			{
				with (instance_attach)
					_climb_off = collision_rectangle(bbox_right, bbox_top, bbox_right + 8, bbox_bottom, obj_climb_mesh, false, true);
				if (!_climb_off)
					x = min(x, instance_attach.bbox_right - collider_detector_sides_width_get());
			}
			collision_left_simple(,,,,,,, false);
			collision_right_simple();
			behavior_wall_right = global.collider_collision[collider_collision.behavior];
			break;
	}
	
	switch sign(y - y_previous)
	{
		case -1:
			if (_climb_boundaries && !collision_down_simple(,,,,,,, false))
			{
				with (instance_attach)
					_climb_off = collision_rectangle(bbox_left, bbox_top - 8, bbox_right, bbox_top, obj_climb_mesh, false, true);
				if (!_climb_off)
					y = max(y, instance_attach.bbox_top- collider_detector_up_y_get());
			}
			collision_up_simple();
			behavior_ceiling = global.collider_collision[collider_collision.behavior];
			break;
		case 0:
			collision_up_simple();
			behavior_ceiling = global.collider_collision[collider_collision.behavior];
			collision_down_simple();
			behavior_floor = global.collider_collision[collider_collision.behavior];
			break;
		case 1:
			if (_climb_boundaries && !collision_up_simple(,,,,,, false))
			{
				with (instance_attach)
					_climb_off = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 8, obj_climb_mesh, false, true);
				if (!_climb_off)
					y = min(y, instance_attach.bbox_bottom - collider_detector_down_y_get());
			}
			collision_down_simple();
			behavior_floor = global.collider_collision[collider_collision.behavior];
			break;
	}
	
	_collision_left = collision_flag_get_left();
	_collision_up = collision_flag_get_up();
	_collision_right = collision_flag_get_right();
	_collision_down = collision_flag_get_down();
		
	if (_collision_left)
	{
		if (speed_h < 0)
			speed_h = 0;
		switch (behavior_wall_left)
		{
			case collider_behaviors_solid.hazard:
				player_hurt();
				break;
			default:
				break;
		}
	}
	if (_collision_right)
	{
		if (speed_h > 0)
			speed_h = 0;
		switch (behavior_wall_right)
		{
			case collider_behaviors_solid.hazard:
				player_hurt();
				break;
			default:
				break;
		}
	}
	if (_collision_up)
	{
		if (speed_v < 0)
			speed_v = 0;
		switch (behavior_ceiling)
		{
			case collider_behaviors_solid.hazard:
				player_hurt();
				break;
			default:
				break;
		}
	}
	if (_collision_down)
	{
		if (speed_v > 0)
			speed_v = 0;
			
		instance_attach = undefined;
		ground_on = true;
		coyote_time = 0;
		switch (behavior_floor)
		{
			case collider_behaviors_solid.hazard:
				player_hurt();
				break;
			default:
				state_next_set(player_states.normal, 5);
				break;
		}
	}
	
	player_fall();
	
	#region Sprites
		sprite_index = player_animation_get(character_index, player_animations.climb);
	#endregion
}
