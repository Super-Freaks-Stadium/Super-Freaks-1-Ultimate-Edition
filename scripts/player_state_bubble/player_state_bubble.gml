function player_state_bubble()
{
	var _view_x1 = camera_get_view_x(view_camera[0]);
	var _view_y1 = camera_get_view_y(view_camera[0]);
	var _view_x2 = _view_x1 + camera_get_view_width(view_camera[0]);
	var _view_y2 = _view_y1 + camera_get_view_height(view_camera[0]);
	var _nearest_player = player_nearest_alive();
	
	if (state_begin)
	{
		if (state_previous == player_states.drop_in)
		{
			x = view_x1_get();
			y = view_y1_get();
			x_start_frame = x;
			y_start_frame = y;
		}
		visible = true;
		physics = player_physics_modifiers.normal;
		ball = false;
		speed_h = 0;
		speed_v = 0;
		speed_true = 0;
		angle = 0;
		jump_buffer = 0;
		coyote_time = 0;
		instance_attach = undefined;
		rubber_band_can_slingshot = false;
		jump_strength = JUMP_STRENGTH_MIN;
		
		x = clamp(x, _view_x1, _view_x2);
		y = clamp(y, _view_y1, _view_y2);
		hitbox.active = hitbox_active.passive;
		
		sfx_play_local(sfx_bubble);
		timer_death = 0;
		
		if (_nearest_player == undefined)
		{
			sfx_play_global(sfx_record_scratch);
			music_pause();
			direction = random(360);
			camera.active = true;
		}
		else
		{
			direction = point_direction(x, y, _nearest_player.x, _nearest_player.y);
			camera.active = false;
		}
	}
	
	if (speed_true < 2)
		speed_true = min(speed_true + 0.25, 2);
	else
		speed_true = max(speed_true - 0.25, 2);
		
	if (_nearest_player != undefined)
	{
		if (input_check("bubble", player_number) || input_check("jump", player_number))
		{
			speed_true = 4;
			direction = point_direction(x, y, _nearest_player.x, _nearest_player.y);
		}
	}
		
	speed_h = lengthdir_x(speed_true, direction);
	speed_v = lengthdir_y(speed_true, direction);
		
	x += speed_h;
	y += speed_v;
	
	if (x - 32 < _view_x1)
	{
		if (speed_h < 0)
		{
			speed_h = -speed_h;
			direction = (180 - direction);
		}
		x = _view_x1 + 32;
	}
	if (y - 32 < _view_y1)
	{
		if (speed_v < 0)
		{
			speed_v = -speed_v;
			direction = (360 - direction);
		}
		y = _view_y1 + 32;
	}
	if (x + 32 > _view_x2)
	{
		if (speed_h > 0)
		{
			speed_h = -speed_h;
			direction = (180 - direction);
		}
		x = _view_x2 - 32;
	}
	if (y + 32 > _view_y2)
	{
		if (speed_v > 0)
		{
			speed_v = -speed_v;
			direction = (360 - direction);
		}
		y = _view_y2 - 32;
	}
	
	sprite_index = player_animation_get(character_index, player_animations.death);
	image_index = 0;
	
	if (_nearest_player == undefined)
	{
		timer_death++;
		if (timer_death >= 64)
			player_death_reset();
	}
	else
		player_pause_game();
}
