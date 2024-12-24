/// @description Step

var _zone = zone_index,
	_target,
	_i,
	_attack_x,
	_attack_y,
	_attack_direction,
	_attack_speed,
	_attack_count;
	
var _x1, _y1, _x2, _y2,
	_obstruction = false;

// Inherit the parent event
event_inherited();

/*
enum boss_shadow_states
{
	intro = 0,
	idle,
	teleport_1,
	teleport_2,
	attack_prepare,
	attack_shurikens,
	attack_dragon,
	attack_bombs,
	death,
}
*/

switch (state)
{
	case boss_shadow_states.intro:
		if (state_begin)
		{
			hitbox.active = hitbox_active.inactive;
			timer = 64;
			sprite_index = spr_boss_shadow_idle;
			image_index = 0;
			animate_speed = 0.175;
		}
		
		timer--;
		
		if (timer < 0)
			state_next_set(boss_shadow_states.teleport_1);
		break;
	case boss_shadow_states.idle:
		if (state_begin)
		{
			hitbox.active = hitbox_active.passive;
			timer = 36;
			sprite_index = spr_boss_shadow_idle;
			image_index = 0;
			animate_speed = 0.175;
		}
		
		timer--;
		
		if (timer < 0)
			state_next_set(boss_shadow_states.attack_prepare);
		break;
	case boss_shadow_states.attack_prepare:
		if (state_begin)
		{
			hitbox.active = hitbox_active.passive;
			sprite_index = spr_boss_shadow_attack;
			image_index = 0;
			animate_speed = 0.175;
		}
		
		if (animation_about_to_end())
			state_next_set(choose(boss_shadow_states.attack_dragon, boss_shadow_states.attack_shurikens, boss_shadow_states.attack_bombs));
		break;
	case boss_shadow_states.attack_dragon:
		if (state_begin)
		{
			hitbox.active = hitbox_active.passive;
			animate_speed = 0;
			timer = 36;
			_attack_speed = lerp(2, 6, toughness / toughness_max);
			instance_create_layer(x, y, "layer_instances", obj_boss_shadow_dragon, 
					{
						speed: _attack_speed,
						direction: 90,
						zone_index: _zone
					});
		}
		
		timer--;
		
		if (timer < 0)
			state_next_set(boss_shadow_states.teleport_1);
		break;
	case boss_shadow_states.attack_bombs:
		if (state_begin)
		{
			sfx_play_local(sfx_splat);
			hitbox.active = hitbox_active.passive;
			animate_speed = 0;
			timer = 64;
			repeat(ceil(lerp(2, 6, toughness / toughness_max)))
			{
				location_current = (location_current + 1) mod array_length(locations);
				_attack_x = locations[location_current][0];
				_attack_y = locations[location_current][1];
				instance_create_layer(_attack_x, _attack_y + 64, "layer_instances", obj_boss_shadow_bomb);
			}
		}
		
		timer--;
		
		if (timer < 0)
			state_next_set(boss_shadow_states.teleport_1);
		break;
	case boss_shadow_states.attack_shurikens:
		if (state_begin)
		{
			hitbox.active = hitbox_active.passive;
			animate_speed = 0;
			timer = 36;
			_target = player_nearest_alive();
			_attack_speed = lerp(2, 6, toughness / toughness_max);
			_attack_direction = 0;
			_attack_count = 4;
			for (_i = 0; _i < _attack_count; ++_i)
			{
				instance_create_layer(x, y, "layer_instances", obj_boss_shadow_shuriken, 
						{
							speed: _attack_speed,
							direction: _attack_direction,
							target: _target,
							zone_index: _zone
						});
				_attack_direction += (360 / _attack_count);
			}
		}
		
		timer--;
		
		if (timer < 0)
			state_next_set(boss_shadow_states.teleport_1);
		break;
	case boss_shadow_states.teleport_1:
		if (state_begin)
		{
			hitbox.active = hitbox_active.inactive;
			sprite_index = spr_boss_shadow_melt;
			image_index = 0;
			animate_speed = 0;
			sfx_play_local(sfx_splat);
		}
		
		image_index = min(image_index + 0.15, 3);
		if (image_index == 3)
			state_next_set(boss_shadow_states.teleport_2);
		break;
	case boss_shadow_states.teleport_2:
		if (state_begin)
		{
			hitbox.active = hitbox_active.inactive;
			sprite_index = spr_boss_shadow_melt;
			image_index = 3;
			animate_speed = 0;
			
			while (true)
			{
				_obstruction = false;
				location_current = (location_current + 1) mod array_length(locations);
				x = locations[location_current][0];
				y = locations[location_current][1];
				
				_x1 = x + hitbox.shape_x1 - 48;
				_y1 = y + hitbox.shape_y1 - 48;
				_x2 = x + hitbox.shape_x2 + 48;
				_y2 = y + hitbox.shape_y2 + 48;
				
				with (obj_player)
				{
					if (player_is_alive())
					{
						if (point_in_rectangle(x, y, _x1, _y1, _x2, _y2))
							_obstruction = true;
					}
				}
				
				if (!_obstruction)
					break;
			}
		}
		
		image_index = max(image_index - 0.15, 0);
		if (image_index == 0)
			state_next_set(boss_shadow_states.idle);
		break;
	case boss_shadow_states.death:
		if (state_begin)
		{
			sprite_index = spr_boss_shadow_melt;
			image_index = 0;
			animate_speed = 0;
			hitbox.behavior = enemy_hitbox_behaviors.normal;
			hitbox.active = hitbox_active.inactive;
			timer = 0;
			audio_stop_sound(sfx_run_1);
			music_stop();
				
			with (obj_boss_shadow_bomb)
				instance_destroy();
			with (obj_boss_shadow_dragon)
				instance_destroy();
			with (obj_boss_shadow_shuriken)
				instance_destroy();
				
			global.boss_phase = 2;
		}
		
		image_index = min(image_index + 0.05, image_number - 1);
			
		if (timer < 128)
		{
			if (timer mod 8 == 0)
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