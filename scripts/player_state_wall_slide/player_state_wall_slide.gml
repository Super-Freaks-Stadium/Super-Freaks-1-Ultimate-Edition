function player_state_wall_slide()
{
	var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;
	var _move_h = 0;
	var _stick_to_wall = true;
	
	if (state_begin)
	{
		visible = true;
		camera.active = true;
		angle_ground = 0;
		ball = false;
		speed_h = 0;
		if (physics == player_physics_modifiers.slime)
			speed_v = 0;
		else
			speed_v = clamp(speed_v, -1, 0);
		instance_attach = undefined;
		lock_gravity = 0;
		rubber_band_can_slingshot = false;
		etc_buffer = 12;
		walljump_auto = false;
	}
	
	hurt_timer_step();
	player_water_step();
	player_pause_game();
	
	if (lock_controls_horizontal == 0)
	{
		if (input_check("left", player_number))
			_move_h -= 1;
		if (input_check("right", player_number))
			_move_h += 1;
	}
	_move_h *= mirror_flip_get();
	if (input_check_pressed("jump", player_number))
		jump_buffer = JUMP_BUFFER_MAX;
	jump_buffer = max(jump_buffer - 1, 0);

	if (physics == player_physics_modifiers.slime)
		speed_v = 0;
	else
		speed_v = min(speed_v + 0.025, 0.5);
	coyote_time = max(coyote_time - 1, 0);
	angle = 0;
		
	if (jump_buffer > 0)
	{
		sfx_play_global(player_jumpsound_get(character_index));
		ball = true;
		speed_h = face * -4;
		speed_v = -(speed_jump + (AURA_JUMP * (aura / 100)));
		physics = player_physics_modifiers.normal;
		ground_on = false;
		coyote_time = 0;
		jump_buffer = 0;
		lock_controls_horizontal = 12;
		lock_friction = 12;
        can_fireball = false;
		face = -face;
		walljump_auto = WALLJUMP_AUTO_MAX;
		_stick_to_wall = false;
	}
	else
	{
		if (_move_h != face)
		{
			etc_buffer = max(etc_buffer - 1, 0);
			if (etc_buffer == 0)
				_stick_to_wall = false;
		}
		else
			etc_buffer = 12;
	}
	
	speed_x = speed_h;
	speed_y = speed_v;
		
	x += speed_x;
	y += speed_y;
		
	if (_stick_to_wall)
	{
		switch sign(face)
		{
			case -1:
				collision_left_simple(,,,, 16,, true);
				behavior_wall = global.collider_collision[collider_collision.behavior];
				break;
			case 0:
				break;
			case 1:
				collision_right_simple(,,,, 16,, true);
				behavior_wall = global.collider_collision[collider_collision.behavior];
				break;
		}
	}
	
	switch sign(y - y_previous)
	{
		case -1:
			collision_up_simple();
			break;
		case 0:
		case 1:
			collision_up_simple();
			collision_down_simple(,,,,,, true);
			break;
	}
		
	_collision_left = collision_flag_get_left();
	_collision_up = collision_flag_get_up();
	_collision_right = collision_flag_get_right();
	_collision_down = collision_flag_get_down();
		
	if (!_collision_left && !_collision_right)
		state_next_set(player_states.normal);
	else
	{
		if (behavior_wall == collider_behaviors_solid.sticky && physics != player_physics_modifiers.slime)
		{
			physics = player_physics_modifiers.slime;
			speed_v = 0;
			sfx_play_global(sfx_splat);
		}
	}
	
	if (_collision_up)
	{
		if (speed_v < 0)
		{
			speed_v = 0;
			sfx_play_global(sfx_honk);
		}
	}
	if (_collision_down)
	{
		if (speed_v > 0)
		{
			speed_v = 0;
			if (!ground_on)
			{
				ground_on = true;
				ball = false;
				state_next_set(player_states.normal);
			}
		}
	}
	
	player_fall();
		
	#region Sprites
		sprite_index = player_animation_get(character_index, player_animations.wall_slide);
		image_index = 0;
		animate_speed = 0;
	#endregion
}
