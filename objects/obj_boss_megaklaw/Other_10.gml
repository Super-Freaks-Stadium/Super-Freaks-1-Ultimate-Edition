/// @description Step

var _target;
var _projectile, _shockwave;

// Inherit the parent event
event_inherited();

switch (state)
{
	case boss_megaklaw_states.intro:
		if (state_begin)
		{
			timer = 0;
			face = -1;
		}
		timer = min(timer + 1, 48);
		
		if (timer == 48)
		{
			x = lerp(x, 1056, 0.125);
			y = lerp(y, 720, 0.125);
			sprite_index = spr_megaklaw_fly;
			animate_speed = 0.25;
			
			if (round(x) == 1056)
				state_next_set(boss_megaklaw_states.punch_1);
		}
		break;
	case boss_megaklaw_states.float:
		if (state_begin)
		{
			timer = 0;
			sprite_index = spr_megaklaw_fly;
			animate_speed = 0.25;
			hitbox.active = hitbox_active.inactive;
		}
		
		switch (face)
		{
			case -1:
				x = lerp(x, 544, 0.125);
			
				if (round(x) == 544)
				{
					face = 1;
					state_next_set(boss_megaklaw_states.punch_1);
				}
				break;
			case 1:
				x = lerp(x, 1056, 0.125);
			
				if (round(x) == 1056)
				{
					face = -1;
					state_next_set(boss_megaklaw_states.punch_1);
				}
				break;
		}
		break;
	case boss_megaklaw_states.punch_1:
		if (state_begin)
		{
			timer = 0;
			sprite_index = spr_megaklaw_punch;
			image_index = 0;
			animate_speed = 0.25;
			hitbox.active = hitbox_active.passive;
		}
		
		if (animation_at_end())
		{
			animate_speed = 0;
			state_next_set(boss_megaklaw_states.punch_2);
		}
		break;
	case boss_megaklaw_states.punch_2:
		if (state_begin)
		{
			arm_length = 0;
			hit_counter = 0;
			with (arm_platform)
			{
				x_offset = 0;
				y_offset = 10;
				solid_y1 = collider_solidity.NA;
			}
		}
		
		arm_length = min(arm_length + 12, arm_length_max);
		
		switch (face)
		{
			case -1: //Facing Left
				arm_platform.shape_x1 = -arm_length * (arm_length / arm_length_max);
				arm_platform.shape_y1 = arm_length * (arm_length / arm_length_max);
				arm_platform.shape_x2 = 0;
				arm_platform.shape_y2 = 0;
				break;
			case 1: //Facing Right
				arm_platform.shape_x1 = 0;
				arm_platform.shape_y1 = 0;
				arm_platform.shape_x2 = arm_length * (arm_length / arm_length_max);
				arm_platform.shape_y2 = arm_length * (arm_length / arm_length_max);
				break;
		}
		
		if (arm_length == arm_length_max)
		{
			sfx_play_global(sfx_crash_2);
			state_next_set(boss_megaklaw_states.punch_3);
			_shockwave = instance_create_layer(x + (arm_length * face), y + arm_length + 24, "layer_instances", obj_enemy_shockwave);
			_shockwave.speed_h = 6 * face;
			screen_shake(0, 16);
		}
		break;
	case boss_megaklaw_states.punch_3:
		if (state_begin)
		{
			timer = 0;
			counter = 32;
			animate_speed = 0;
			with (arm_platform)
				solid_y1 = collider_solidity.semi_solid;
		}
		
		timer = min(timer + 1, shoot_timer * shoot_amount);
		counter++;
		
		if (counter >= shoot_timer)
		{
			counter = 0;
			if !(global.difficulty == difficulty_levels.easy && global.boss_phase == 0)
			{
				sprite_index = spr_megaklaw_spit;
				image_index = 1;
			}
			switch (global.boss_phase)
			{
				case 0:
					switch (global.difficulty)
					{
						case difficulty_levels.easy:
							break;
						case difficulty_levels.normal:
							sfx_play_global(sfx_pop);
							_target = player_nearest_alive();
							if (!is_undefined(_target))
							{
								_projectile = instance_create_layer(x + 64 * face, y - 24, "layer_instances", obj_enemy_fireball, 
								{
									speed: 3,
									direction: point_direction(x + 64 * face, y - 24, _target.x, _target.y),
									zone_index: -3
								});
							}
							break;
						case difficulty_levels.hard:
							sfx_play_global(sfx_pop);
							_target = player_nearest_alive();
							if (!is_undefined(_target) && instance_number(obj_enemy_missile) < 3)
							{
								_projectile = instance_create_layer(x + 64 * face, y - 24, "layer_instances", obj_enemy_missile, 
								{
									speed: 4,
									direction: point_direction(x + 64 * face, y - 24, _target.x, _target.y),
									zone_index: -3
								});
							}
							break;
					}
					break;
				case 1:
					sfx_play_global(sfx_pop);
					switch (global.difficulty)
					{
						case difficulty_levels.easy:
							_target = player_nearest_alive();
							if (!is_undefined(_target))
							{
								_projectile = instance_create_layer(x + 64 * face, y - 24, "layer_instances", obj_enemy_fireball, 
								{
									speed: 3,
									direction: point_direction(x + 64 * face, y - 24, _target.x, _target.y),
									zone_index: -3
								});
							}
							break;
						case difficulty_levels.normal:
							_projectile = instance_create_layer(x + 64 * face, y - 24, "layer_instances", obj_crackerbarrel);
							_projectile.speed_move = 1;
							_projectile.face = face;
							_projectile.speed_v = 0;
							_projectile.is_moving = true;
							break;
						case difficulty_levels.hard:
							_projectile = instance_create_layer(x + 64 * face, y - 24, "layer_instances", obj_crackerbarrel);
							_projectile.speed_move = 2;
							_projectile.face = face;
							_projectile.speed_v = 0;
							_projectile.is_moving = true;
							break;
					}
					break;
			}
		}
		else if (counter >= (shoot_timer - 24))
		{
			if !(global.difficulty == difficulty_levels.easy && global.boss_phase == 0)
			{
				sprite_index = spr_megaklaw_spit;
				image_index = 0;
			}
		}
		else if (counter >= 32)
		{
			if !(global.difficulty == difficulty_levels.easy && global.boss_phase == 0)
			{
				sprite_index = spr_megaklaw_punch;
				image_index = 3;
			}
		}
		
		if (timer == (shoot_timer * shoot_amount) || hit_counter >= 2)
		{
			state_next_set(boss_megaklaw_states.punch_4);
			with (arm_platform)
				solid_y1 = collider_solidity.NA;
			
			if (global.boss_phase == 0 && hp <= 7)
			{
				global.boss_phase = 1;
                turbo_time_add(20);
				instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
			}
		}
		break;
	case boss_megaklaw_states.punch_4:
		if (state_begin)
		{
			timer = 0;
			animate_speed = 0;
			with (arm_platform)
				solid_y1 = collider_solidity.NA;
		}
		
		arm_length = max(arm_length - 16, 0);
		
		switch (face)
		{
			case -1: //Facing Left
				arm_platform.shape_x1 = -arm_length * (arm_length / arm_length_max);
				arm_platform.shape_y1 = arm_length * (arm_length / arm_length_max);
				arm_platform.shape_x2 = 0;
				arm_platform.shape_y2 = 0;
				break;
			case 1: //Facing Right
				arm_platform.shape_x1 = 0;
				arm_platform.shape_y1 = 0;
				arm_platform.shape_x2 = arm_length * (arm_length / arm_length_max);
				arm_platform.shape_y2 = arm_length * (arm_length / arm_length_max);
				break;
		}
		
		if (arm_length == 0)
		{
			with (arm_platform)
				solid_y1 = collider_solidity.NA;
			state_next_set(boss_megaklaw_states.float);
		}
		break;
	case boss_megaklaw_states.death:
		if (state_begin)
		{
            global.turbo.pause = true;
			timer = 0;
			animate_speed = 0;
			hitbox.active = hitbox_active.inactive;
			sprite_index = spr_megaklaw_stuck;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
			with (arm_platform)
				solid_y1 = collider_solidity.NA;
		}
		
		arm_length = max(arm_length - 16, 64);
		
		switch (face)
		{
			case -1: //Facing Left
				arm_platform.shape_x1 = -arm_length * (arm_length / arm_length_max);
				arm_platform.shape_y1 = arm_length * (arm_length / arm_length_max);
				arm_platform.shape_x2 = 0;
				arm_platform.shape_y2 = 0;
				break;
			case 1: //Facing Right
				arm_platform.shape_x1 = 0;
				arm_platform.shape_y1 = 0;
				arm_platform.shape_x2 = arm_length * (arm_length / arm_length_max);
				arm_platform.shape_y2 = arm_length * (arm_length / arm_length_max);
				break;
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
			level_beat();
		}
		break;
}