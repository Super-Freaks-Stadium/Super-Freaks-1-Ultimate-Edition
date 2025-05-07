/// @description Step

var _angle, _collision_left, _collision_up, _collision_right, _collision_down, _my_x, _my_y;
var _fireball, _speed, _target;
var _fast_forward = fast_forward_level_get() + global.frame_machine_level.multiplier;

// Inherit the parent event
event_inherited();

collision_flags = 0;

face_angle_previous = face_angle;
aura_angle_previous = aura_angle;
spike_angle_previous = spike_angle;

aura_angle += 5;
face_angle += face_rotate_speed;
spike_angle += spike_speed;

switch (state)
{
	case boss_kranion_final_states.intro_1:
		if (state_begin)
		{
			speed_x = 2;
			speed_y = 6;
			hitbox.active = hitbox_active.inactive;
			depth = -9999;
			with (obj_player)
			{
				jetpack = true;
				ground_on = false;
			}
		}
		speed_y -= 0.25;
		x += speed_x;
		y += speed_y;
		
		if (y < 368)
			state_next_set(boss_kranion_final_states.intro_2);
		break;
	case boss_kranion_final_states.intro_2:
		if (state_begin)
		{
			x = 798;
			y = 368;
			speed_x = 0;
			speed_y = 6;
			hitbox.active = hitbox_active.passive;
			global.boss_phase = 1;
			with (obj_player)
			{
				jetpack = true;
				ground_on = false;
			}
			depth = 3;
		}
		y = min(y + speed_y, 782);
		if (y == 782)
        {
			state_next_set(boss_kranion_final_states.idle);
            global.turbo.pause = false;
        }
		break;
	case boss_kranion_final_states.idle:
		if (state_begin)
		{
			_target = player_nearest_alive();
			if (!is_undefined(_target))
				_angle = point_direction(x, y, _target.x, _target.y);
			else
				_angle = random(360);
			speed_x = lengthdir_x(1, -_angle);
			speed_y = lengthdir_y(1, -_angle);
			timer = 0;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
		}
		
		face_angle = lerp_360(face_angle, 0, 0.25);
		
		x += speed_x;
		y += speed_y;

		switch sign(x - x_previous)
		{
			case -1:
				collision_left_simple();
				break;
			case 0:
			case 1:
				collision_right_simple();
				break;
		}

		switch sign(y - y_previous)
		{
			case -1:
				collision_up_simple();
				break;
			case 0:
			case 1:
				collision_down_simple();
				break;
		}
		
		_collision_left = collision_flag_get_left();
		_collision_up = collision_flag_get_up();
		_collision_right = collision_flag_get_right();
		_collision_down = collision_flag_get_down();
		
		if (_collision_left)
		{
			if (speed_x < 0)
				speed_x = -speed_x;
		}
		if (_collision_right)
		{
			if (speed_x > 0)
				speed_x = -speed_x;
		}
		if (_collision_up)
		{
			if (speed_y < 0)
				speed_y = -speed_y;
		}
		if (_collision_down)
		{
			if (speed_y > 0)
				speed_y = -speed_y;
		}
		
		timer++;
		
		if (timer >= 128)
			state_next_set(boss_kranion_final_states.spikes_expand);
		break;
	case boss_kranion_final_states.bounce:
		if (state_begin)
		{
			switch (global.difficulty)
			{
				case difficulty_levels.easy:
					_speed = 3;
					break;
				case difficulty_levels.normal:
					_speed = 4.5;
					break;
				case difficulty_levels.hard:
					_speed = 5;
					break;
			}
			_target = player_nearest_alive();
			if (!is_undefined(_target))
				_angle = point_direction(x, y, _target.x, _target.y);
			else
				_angle = random(360);
			speed_x = lengthdir_x(_speed, _angle);
			speed_y = lengthdir_y(_speed, _angle);
			timer = 0;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
		}
		
		face_angle += 5;
		
		x += speed_x;
		y += speed_y;

		switch sign(x - x_previous)
		{
			case -1:
				collision_left_simple();
				break;
			case 0:
			case 1:
				collision_right_simple();
				break;
		}

		switch sign(y - y_previous)
		{
			case -1:
				collision_up_simple();
				break;
			case 0:
			case 1:
				collision_down_simple();
				break;
		}
		
		_collision_left = collision_flag_get_left();
		_collision_up = collision_flag_get_up();
		_collision_right = collision_flag_get_right();
		_collision_down = collision_flag_get_down();
		
		if (_collision_left)
		{
			if (speed_x < 0)
			{
				speed_x = -speed_x;
				screen_shake(12, 0);
				sfx_play_global(sfx_crash_1);
			}
		}
		if (_collision_right)
		{
			if (speed_x > 0)
			{
				speed_x = -speed_x;
				screen_shake(12, 0);
				sfx_play_global(sfx_crash_1);
			}
		}
		if (_collision_up)
		{
			if (speed_y < 0)
			{
				speed_y = -speed_y;
				screen_shake(0, 12);
				sfx_play_global(sfx_crash_1);
			}
		}
		if (_collision_down)
		{
			if (speed_y > 0)
			{
				speed_y = -speed_y;
				screen_shake(0, 12);
				sfx_play_global(sfx_crash_1);
			}
		}
		
		timer++;
		
		if (timer > 200)
			state_next_set(boss_kranion_final_states.spikes_retract);
		break;
	case boss_kranion_final_states.suction:
		if (state_begin)
		{
			face_rotate_speed = 0;
			timer = 0;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
		}
		
		face_rotate_speed = min(face_rotate_speed + 0.5, 15);
		_my_x = x;
		_my_y = y;
		
		with (obj_player)
		{
			if (player_is_alive())
			{
				_angle = point_direction(x, y, _my_x, _my_y);
				x += lengthdir_x(2, _angle);
				y += lengthdir_y(2, _angle);
			}
		}
		
		if (timer < 200)
		{
			if (timer mod 4 == 0)
				instance_create_layer(x - 256 + random(512), y - 256 + random(512), "layer_instances", obj_kranion_suction_star);
			if (timer mod (16 - (global.difficulty - 1) * 2) == 0)
			{
				sfx_play_global(sfx_explode_short);
				switch (global.difficulty)
				{
					case difficulty_levels.easy:
						_speed = 2;
						break;
					case difficulty_levels.normal:
						_speed = 3;
						break;
					case difficulty_levels.hard:
						_speed = 3.5;
						break;
				}
				_fireball = instance_create_layer(x, y, "layer_instances", obj_enemy_fireball, 
				{
					speed: _speed,
					direction: random(360),
				});
			}
			timer++;
		}
		else
			state_next_set(boss_kranion_final_states.spikes_retract);
		break;
	case boss_kranion_final_states.spikes_expand:
		if (state_begin)
		{
			aura_size = 1;
			spike_size = 0;
			spike_speed = 0;
		}
		
		speed_x = lerp(speed_x, 0, 0.125);
		speed_y = lerp(speed_y, 0, 0.125);
		
		aura_size = max(aura_size - (0.05 / _fast_forward), 0);
		spike_size = min(spike_size + (0.05 / _fast_forward), 1);
		
		if (spike_size == 1)
		{
			if (spike_speed == 0)
				sfx_play_global(sfx_pluck);
			spike_speed += 0.125;
			if (spike_speed == 3)
			{
				switch (choose(0, 1))
				{
					case 0:
						state_next_set(boss_kranion_final_states.bounce);
						break;
					case 1:
						state_next_set(boss_kranion_final_states.suction);
						break;
				}
			}
		}
		break;
	case boss_kranion_final_states.spikes_retract:
		if (state_begin)
		{
			aura_size = 0;
			spike_size = 1;
			face_rotate_speed = 0;
		}
		
		speed_x = lerp(speed_x, 0, 0.125);
		speed_y = lerp(speed_y, 0, 0.125);
		
		spike_size = max(spike_size - 0.05, 0);
		aura_size = min(aura_size + 0.05, 1);
		face_angle = lerp_360(face_angle, 0, 0.25);
		
		if (aura_size == 1)
			state_next_set(boss_kranion_final_states.idle);
		break;
	case boss_kranion_final_states.death_1:
		if (state_begin)
		{
            global.turbo.pause = true;
			hitbox.active = hitbox_active.inactive;
			timer = 0;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
		}
			
		if (timer < 128)
		{
			if (timer mod 16 == 0)
				instance_create_layer(x - 80 + random(160), y - 80 + random(160), "layer_instances", obj_boss_explosion);
			timer++;
		}
		else
			state_next_set(boss_kranion_final_states.death_2);
		break;
	case boss_kranion_final_states.death_2:
		if (state_begin)
		{
			speed_y = -2;
			hitbox.active = hitbox_active.inactive;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
		}
		
		speed_y = min(speed_y + 0.125, 6);
		
		x += 1;
		y += speed_y;
			
		if (timer mod 16 == 0)
			instance_create_layer(x - 80 + random(160), y - 80 + random(160), "layer_instances", obj_boss_explosion);
		timer++;
		
		if (y >= room_height + 128)
		{
			state_next_set(-1);
			level_beat();
			if (global.game_mode != game_modes.boss_rush && global.game_mode != game_modes.speedrun)
			{
				music_stop();
				music_set(MUSIC_NA);
				audio_stop_all();
				audio_play_sound_on(global.audio_emitter_music, msc_victory_kranion, false, 0);
			}
		}
		break;
}

if (aura_angle >= 360)
{
	aura_angle -= 360;
	aura_angle_previous -= 360;
}

if (face_angle >= 360)
{
	face_angle -= 360;
	face_angle_previous -= 360;
}

if (spike_angle >= 360)
{
	spike_angle -= 360;
	spike_angle_previous -= 360;
}