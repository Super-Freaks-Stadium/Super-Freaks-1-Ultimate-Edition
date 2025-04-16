/// @description Step

var _fireball, _target, _angle, _fireball_speed = shoot_speed;

//enum boss_cinge_states
//{
//	intro = 0,
//	normal,
//	shoot,
//	fireball,
//	stun,
//	stun_ground,
//	get_up,
//	death,
//}

// Inherit the parent event
event_inherited();

collision_flags = 0;

switch (state)
{
	case boss_cinge_states.normal:
		if (state_begin)
		{
			sprite_index = spr_boss_cinge_stand;
			image_index = 0;
			animate_speed = 0.15;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
			hitbox.active = hitbox_active.active;
			timer = 0;
			hitbox.shape_x1 = -40;
			hitbox.shape_y1 = -40;
			hitbox.shape_x2 = 40;
			hitbox.shape_y2 = 80;
		}
		timer = min(timer + 1, 32);
		
		if (timer == 32)
			state_next_set(boss_cinge_states.shoot);
		break;
	case boss_cinge_states.shoot:
		if (state_begin)
		{
			sprite_index = spr_boss_cinge_shoot_prepare;
			image_index = 0;
			animate_speed = 0.15;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
			timer = 0;
			counter = 0;
		}
		
		switch (sprite_index)
		{
			case spr_boss_cinge_shoot_prepare:
				timer = min(timer + 1, shoot_timer);
				
				if (timer == shoot_timer && floor(image_index + animate_speed) == 3)
				{
					_target = player_nearest_alive();
					if (!is_undefined(_target))
					{
						sfx_play_global(sfx_flame);
						_angle = point_direction(x + (76 * face), y + 40, _target.x, _target.y - 32);
						_fireball = instance_create_layer(x + (76 * face), y + 40, "layer_instances", obj_enemy_energy_orb, 
						{
							speed: _fireball_speed,
							direction: _angle,
							zone_index: -3
						});
						
						if (global.boss_phase == 1)
						{
							_fireball = instance_create_layer(x + (76 * face), y + 40, "layer_instances", obj_enemy_fireball, 
							{
								speed: _fireball_speed,
								direction: _angle + 15,
								zone_index: -3
							});
							_fireball = instance_create_layer(x + (76 * face), y + 40, "layer_instances", obj_enemy_fireball, 
							{
								speed: _fireball_speed,
								direction: _angle - 15,
								zone_index: -3
							});
						}
					}
					sprite_index = spr_boss_cinge_shoot;
					image_index = 0;
					counter++;
					timer = 0;
				}
				break;
			case spr_boss_cinge_shoot:
				if (floor(image_index + animate_speed) == 3)
				{
					if (counter >= counter_max)
						sprite_index = spr_boss_cinge_stand;
					else
						sprite_index = spr_boss_cinge_shoot_prepare;
				}
				break;
			case spr_boss_cinge_stand:
				timer = min(timer + 1, 48);
			
				if (timer == 48)
					state_next_set(boss_cinge_states.fireball);
				break;
		}
		break;
	case boss_cinge_states.fireball:
		if (state_begin)
		{
			sprite_index = spr_boss_cinge_fireball;
			image_index = 0;
			animate_speed = 0.5;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
			timer = 0;
			speed_h = 0;
			hitbox.shape_x1 = -60;
			hitbox.shape_x2 = 60;
			sfx_play_global(sfx_run_1, true);
		}
		timer = min(timer + 1, 72);
		
		if (timer == 72)
		{
			switch (face)
			{
				case -1:
					speed_h = max(speed_h - speed_acc, -8);
					break;
				case 0:
					break;
				case 1:
					speed_h = min(speed_h + speed_acc, 8);
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
			speed_h = -0.125 * sign(face);
			speed_v = -4;
			state_next_set(boss_cinge_states.stun);
			audio_stop_sound(sfx_run_1);
			screen_shake(12, 0);
		}
		break;
	case boss_cinge_states.stun:
		if (state_begin)
		{
			sprite_index = spr_boss_cinge_stun;
			image_index = 0;
			animate_speed = 0;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			hit_counter = 0;
			timer = 0;
			hitbox.shape_x1 = -40;
			hitbox.shape_y1 = -40;
			hitbox.shape_x2 = 40;
			hitbox.shape_y2 = 80;
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
			state_next_set(boss_cinge_states.stun_ground);
		break;
		
	case boss_cinge_states.stun_ground:
		if (state_begin)
		{
			sprite_index = spr_boss_cinge_stun_ground;
			image_index = 0;
			animate_speed = 0.125;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			timer = 0;
			hitbox.shape_x1 = -60;
			hitbox.shape_y1 = 0;
			hitbox.shape_x2 = 60;
			hitbox.shape_y2 = 80;
		}
		timer = min(timer + 1, 420);
		
		if (timer == 420 || hit_counter >= 3)
		{
			face = -face;
			hit_counter = 0;
			state_next_set(boss_cinge_states.get_up);
		}
		break;
	case boss_cinge_states.get_up:
		if (state_begin)
		{
			sprite_index = spr_boss_cinge_getup;
			image_index = 0;
			animate_speed = 0.15;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			//hitbox.active = hitbox_active.inactive;
			timer = 0;
			hitbox.shape_x1 = -40;
			hitbox.shape_y1 = -40;
			hitbox.shape_x2 = 40;
			hitbox.shape_y2 = 80;
            fast_forward = false;
		}
		timer = min(timer + 1, 56);
		
		if (animation_at_end())
		{
			image_index = 3;
			
			if (global.boss_phase == 0 && hp <= 10)
			{
				global.boss_phase = 1;
				instance_create_layer(0, 0, "layer_instances", obj_boss_cinge_heat_haze);
			}
		}
		
		if (timer == 56)
        {
			state_next_set(boss_cinge_states.normal);
            fast_forward = true;
        }
		break;
	case boss_cinge_states.death:
		if (state_begin)
		{
			sprite_index = choose(spr_boss_cinge_death, spr_boss_cinge_death_2);
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
			level_beat();
		}
		break;
	default:
		break;
}