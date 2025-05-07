/// @description Step

var _shockwave;

// Inherit the parent event
event_inherited();

collision_flags = 0;

switch (state)
{
	case boss_kranion_states.normal:
		if (state_begin)
		{
			sprite_index = sprite_stand;
			image_index = 0;
			animate_speed = 0.15;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			hitbox.active = hitbox_active.passive;
			timer = 0;
		}
		timer = min(timer + 1, 128);
		
		if (timer == 128)
		{
			switch (choose(0, 1, 2))
			{
				case 0:
					state_next_set(boss_kranion_states.spin);
					break;
				case 1:
					state_next_set(boss_kranion_states.bounce);
					break;
				case 2:
					state_next_set(boss_kranion_states.jump);
					break;
			}
		}
		else if (timer >= 80)
			sprite_index = sprite_prepare;
		break;
	case boss_kranion_states.spin:
		if (state_begin)
		{
			sprite_index = sprite_spin;
			image_index = 0;
			animate_speed = 0.5;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
			timer = 0;
			speed_h = 0;
			switch (global.difficulty)
			{
				case difficulty_levels.easy:
					counter = 2;
					break;
				case difficulty_levels.normal:
					counter = 3;
					break;
				case difficulty_levels.hard:
					counter = 5;
					break;
			}
			sfx_play_global(sfx_run_1, true);
		}
		timer = min(timer + 1, 52);
		
		if (timer == 52 && speed_h == 0)
		{
            speed_v = -8;
			switch (face)
			{
				case -1:
					speed_h = -4;
					break;
				case 0:
					break;
				case 1:
					speed_h = 4;
					break;
			}
			animate_speed += 0.0025;
		}
		
		x += speed_h;
		
		switch (sign(x - x_previous))
		{
			case -1:
				collision_left_simple();
				break;
			case 0:
				break;
			case 1:
				collision_right_simple();
				break;
		}
		
		if (collision_flag_get_left() || collision_flag_get_right())
		{
			counter--;
			if (counter > 0)
			{
				speed_h = (abs(speed_h) + 4) * -sign(face);
				face = -face;
				screen_shake(12, 0);
				sfx_play_global(sfx_crash_1);
			}
			else
			{
				speed_h = -6 * sign(face);
				speed_v = -2;
				state_next_set(boss_kranion_states.stun);
				audio_stop_sound(sfx_run_1);
				screen_shake(12, 0);
				sfx_play_global(sfx_crash_1);
			}
		}
		break;
	case boss_kranion_states.bounce:
		if (state_begin)
		{
			sprite_index = sprite_roll;
			image_index = 0;
			animate_speed = 0.5;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
			timer = 0;
			speed_h = 0;
			speed_v = 0;
			sfx_play_global(sfx_run_1, true);
		}
		timer = min(timer + 1, 48);
		
		if (timer == 48 && speed_h == 0)
		{
			switch (global.difficulty)
			{
				case difficulty_levels.easy:
					speed_h = 3 * face;
					speed_v = -4;
					counter = 1;
					break;
				case difficulty_levels.normal:
					speed_h = 5 * face;
					speed_v = -8;
					counter = 2;
					break;
				case difficulty_levels.hard:
					speed_h = 6 * face;
					speed_v = -10;
					counter = 2;
					break;
			}
			animate_speed += 0.0025;
		}
		
		x += speed_h;
		y += speed_v;
		
		switch (sign(x - x_previous))
		{
			case -1:
				collision_left_simple();
				break;
			case 0:
				break;
			case 1:
				collision_right_simple();
				break;
		}
		switch (sign(y - y_previous))
		{
			case -1:
				collision_up_simple();
				break;
			case 0:
				break;
			case 1:
				collision_down_simple();
				break;
		}
		
		if (collision_flag_get_left() || collision_flag_get_right())
		{
			counter--;
			if (counter > 0)
			{
				speed_h = -speed_h;
				face = -face;
				screen_shake(12, 0);
				sfx_play_global(sfx_crash_1);
			}
			else
			{
				speed_h = -3 * sign(face);
				speed_v = 0;
				state_next_set(boss_kranion_states.stun);
				audio_stop_sound(sfx_run_1);
				screen_shake(12, 0);
				sfx_play_global(sfx_crash_1);
			}
		}
		
		if (collision_flag_get_up() || collision_flag_get_down())
		{
			speed_v = -speed_v;
			sfx_play_global(sfx_crash_1);
			screen_shake(0, 12);
		}
		break;
	case boss_kranion_states.jump:
		if (state_begin)
		{
			sprite_index = sprite_stand;
			image_index = 0;
			animate_speed = 0;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			hit_counter = 0;
			timer = 0;
			counter = 0;
			speed_h = 0;
			speed_v = -4;
		}
		
		speed_v = min(speed_v + speed_grv, 6);
		
		x += speed_h;
		y += speed_v;
		
		switch (sign(x - x_previous))
		{
			case -1:
				collision_left_simple();
				break;
			case 0:
				break;
			case 1:
				collision_right_simple();
				break;
		}
		
		switch (sign(y - y_previous))
		{
			case -1:
				collision_up_simple();
				break;
			case 0:
				break;
			case 1:
				collision_down_simple();
				break;
		}
		
		if (collision_flag_get_left() || collision_flag_get_right())
			speed_h = 0;
			
		if (collision_flag_get_up())
			speed_v = max(speed_v, 0);
		
		if (collision_flag_get_down())
		{
			counter++;
			if (counter >= 5)
				state_next_set(boss_kranion_states.normal);
			else
			{
				switch (global.difficulty)
				{
					case difficulty_levels.easy:
						speed_v = -8;
						break;
					case difficulty_levels.normal:
						speed_v = choose(-4, -8);
						break;
					case difficulty_levels.hard:
						speed_v = -3;
						break;
				}
				screen_shake(0, 12);
				sfx_play_global(sfx_crash_1);
				_shockwave = instance_create_layer(x, y + 64, "layer_instances", obj_enemy_shockwave);
				_shockwave.speed_h = -6;
				_shockwave = instance_create_layer(x, y + 64, "layer_instances", obj_enemy_shockwave);
				_shockwave.speed_h = 6;
			}
		}
		break;
	case boss_kranion_states.stun:
		if (state_begin)
		{
			sprite_index = sprite_death;
			image_index = 0;
			animate_speed = 0;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			hit_counter = 0;
			timer = 0;
			sfx_play_global(sfx_crash_2);
		}
		
		speed_v = min(speed_v + speed_grv, 6);
		
		x += speed_h;
		y += speed_v;
		
		switch (sign(x - x_previous))
		{
			case -1:
				collision_left_simple();
				break;
			case 0:
				break;
			case 1:
				collision_right_simple();
				break;
		}
		
		switch (sign(y - y_previous))
		{
			case -1:
				collision_up_simple();
				break;
			case 0:
				break;
			case 1:
				collision_down_simple();
				break;
		}
		
		if (collision_flag_get_left() || collision_flag_get_right())
			speed_h = 0;
			
		if (collision_flag_get_up())
			speed_v = max(speed_v, 0);
		
		if (collision_flag_get_down())
		{
			state_next_set(boss_kranion_states.normal);
			face = -face;
		}
		break;
	case boss_kranion_states.death:
		if (state_begin)
		{
            global.turbo.pause = true;
			sprite_index = sprite_death;
			image_index = 0;
			animate_speed = 0.15;
			hitbox.behavior = enemy_hitbox_behaviors.normal;
			hitbox.active = hitbox_active.inactive;
			timer = 0;
			audio_stop_sound(sfx_run_1);
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
		{
			state_next_set(-1);
			instance_create_layer(0, 0, "layer_instances", obj_level_win_screen_fake);
		}
		break;
	default:
		break;
}