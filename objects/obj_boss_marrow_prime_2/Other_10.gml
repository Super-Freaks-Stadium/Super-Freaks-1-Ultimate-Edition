/// @description Step

var _i,
	_target,
	_attack_choice;
	
var _fast_forward = fast_forward_level_get() + global.frame_machine_level.multiplier;

/*
enum boss_marrow2_states
{
	intro = 0,
	idle,
	finger_raise,
	jump,
	charge,
	death,
}
*/

// Inherit the parent event
event_inherited();

switch (state)
{
	case boss_marrow2_states.idle:
		if (state_begin)
		{
			speed_h = 0;
			speed_v = 0;
			sprite_index = spr_boss_marrow_prime_stand;
			image_index = 0;
			animate_speed = 0;
			timer = 80;
		}
		
		_target = player_nearest_alive();
		if (!is_undefined(_target))
		{
			if (_target.x < x)
				face = -1;
			else
				face = 1;
		}
		
		timer--;
		
		if (timer < 1)
		{
			if (cast_counter == cast_counter_max)
			{
				speed_h = choose(-3, 3);
				state_next_set(boss_marrow2_states.jump);
				cast_counter = 0;
			}
			state_next_set(boss_marrow2_states.finger_raise);
		}
		break;
	case boss_marrow2_states.finger_raise:
		if (state_begin)
		{
			timer = 56;
			sprite_index = spr_boss_marrow_prime_cast_prepare;
			animate_speed = 0.25;
		}
		
		if (sprite_index == spr_boss_marrow_prime_cast_prepare && animation_at_end())
		{
			sprite_index = spr_boss_marrow_prime_cast;
			image_index = 0;
			sfx_play_global(sfx_powerup);
		}
		
		timer -= (1 / _fast_forward);
		
		if (hit_counter >= 6)
		{
			speed_h = choose(-3, 3);
			state_next_set(boss_marrow2_states.jump);
			cast_counter = 0;
		}
		
		if (timer < 1)
		{
			_attack_choice = choose(0, 1, 2);
			if (_attack_choice == 1 && instance_exists(obj_marrow_lightning))
				_attack_choice = choose(0, 2);
				
			switch (_attack_choice)
			{
				case 0:
					for (_i = 0; _i < 4; ++_i)
					{
						instance_create_layer(x - (72 * face), y - 80, "layer_instances", obj_marrow_fireball, 
						{
							speed: 3,
							direction: 45 + (90 * _i),
						});
					}
					if (global.difficulty > difficulty_levels.easy)
					{
						for (_i = 0; _i < 4; ++_i)
						{
							instance_create_layer(x - (72 * face), y - 80, "layer_instances", obj_marrow_fireball, 
							{
								speed: 3,
								direction: 90 * _i,
							});
						}
					}
					if (global.difficulty == difficulty_levels.hard)
					{
						for (_i = 0; _i < 8; ++_i)
						{
							instance_create_layer(x - (72 * face), y - 80, "layer_instances", obj_marrow_fireball, 
							{
								speed: 1,
								direction: 22.5 + (45 * _i),
							});
						}
					}
			
					sfx_play_global(sfx_explode);
					screen_shake(0, 6);
					break;
				case 1:
					instance_create_layer(random_range(600, 1000), 840, "layer_instances", obj_marrow_lightning);
					break;
				case 2:
					if (choose(0, 1))
					{
						_target = player_nearest_alive();
						if (!is_undefined(_target))
							_attack_choice = _target.x;
						else
							_attack_choice = random_range(688, 896);
					}
					else
						_attack_choice = x;
						
					instance_create_layer(clamp(_attack_choice, 688, 896), y - 524, "layer_instances", obj_marrow_meteor);
					break;
			}
			state_next_set(boss_marrow1_states.idle);
			cast_counter++;
		}
		break;
	case boss_marrow2_states.jump:
		if (state_begin)
		{
			speed_v = -10;
			sfx_play_global(sfx_jump);
			sprite_index = spr_boss_marrow_prime_jump;
			image_index = 0;
			animate_speed = 0;
		}
		
		speed_v = min(speed_v + 0.25, 6);
		x += speed_h;
		y += speed_v;
		
		switch (sign(x - x_previous))
		{
			case -1:
				face = -1;
				if (collision_left_simple())
					speed_h = -speed_h;
				break;
			case 0:
				break;
			case 1:
				face = 1;
				if (collision_right_simple())
					speed_h = -speed_h;
				break;
		}
		
		if (speed_v >= 0)
		{
			if (collision_down_simple(,,,,,,, false))
			{
				speed_v = 0;
				hit_counter = 0;
				screen_shake(0, 12);
				sfx_play_global(sfx_crash_2);
				state_next_set(boss_marrow2_states.idle);
			}
		}
		break;
	case boss_marrow2_states.death:
		if (state_begin)
		{
            global.turbo.pause = true;
			sprite_index = choose(spr_boss_marrow_prime_jump, spr_boss_marrow_prime_death_funny);
			image_index = 0;
			animate_speed = 0.15;
			hitbox.behavior = enemy_hitbox_behaviors.normal;
			hitbox.active = hitbox_active.inactive;
			timer = 0;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
				
			with (obj_marrow_fireball)
				instance_destroy();
			with (obj_marrow_lightning)
				instance_destroy();
			with (obj_marrow_meteor)
				instance_destroy();
		}
			
		if (timer < 128)
		{
			if (timer mod 16 == 0)
				instance_create_layer(x - 80 + random(160), y - 80 + random(160), "layer_instances", obj_boss_explosion);
			timer++;
		}
		else
		{
			with instance_create_layer(x, y, "layer_instances", obj_boss_explosion)
			{
				image_xscale = 4;
				image_yscale = 4;
			}
			sfx_play_global(sfx_explode);
			screen_shake(0, 20);
			instance_destroy();
			instance_create(obj_marrow_death, x, y);
		}
		break;
	default:
		break;
}