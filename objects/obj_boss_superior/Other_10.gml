/// @description Step

var _player = player_nearest_alive();
var _fast_forward = fast_forward_level_get() + global.frame_machine_level.multiplier;
var _fireball, _angle;

var _i, _my_fellow_americans = 0;

// Inherit the parent event
event_inherited();

switch (state)
{
	case boss_antifreak_states.inactive:
		if (state_begin)
		{
			speed_x = 0;
			speed_y = 0;
			x = -1000;
			visible = false;
			hitbox.active = hitbox_active.inactive;
		}
		break;
	case boss_antifreak_states.intro:
		if (state_begin)
		{
			speed_x = 0;
			speed_y = 0;
			sprite_index = player_animation_get(character_index, player_animations.idle);
			animate_speed = 0;
			image_index = 0;
		}
		
		timer--;
		
		if (timer <= 0)
			state_next_set(boss_antifreak_states.retreat);
		break;
	case boss_antifreak_states.retreat:
		if (state_begin)
		{
			speed_x = 0;
			speed_y = 0;
			sprite_index = player_animation_get(character_index, player_animations.air);
			animate_speed = 0;
			image_index = 0;
			sfx_play_global(sfx_slide_whistle_up);
		}
		
		speed_y -= 0.25;
		y += speed_y;
			
		if (y <= 200)
			state_next_set(boss_antifreak_states.wait);
		break;
	case boss_antifreak_states.wait:
		if (state_begin)
		{
            for (_i = 0; _i < 4; ++_i)
            {
                _my_fellow_americans += bit_get(global.boss_phase, _i);
            }
            wait = _my_fellow_americans * 24;
		}
		
		if (wait-- <= 0)
			state_next_set(boss_antifreak_states.attack_1);
		break;
	case boss_antifreak_states.death:
		if (state_begin)
		{
			global.boss_phase = bit_set(global.boss_phase, 0);
			instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
			screen_shake(0, 8);
			sfx_play_global(sfx_yell_wilhelm);
			speed_x = 0;
			speed_y = -7.15;
			hitbox.active = hitbox_active.inactive;
			sprite_index = player_animation_get(character_index, player_animations.death);
			image_index = 0;
		}
		
		speed_y += min(0.25, 6 - speed_y);
		
		x += speed_x;
		y += speed_y;
		
		if (y >= room_height)
			state_next_set(boss_antifreak_states.inactive);
		break;
	case boss_antifreak_states.attack_1:
		if (state_begin)
		{
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
			sprite_index = player_animation_get(character_index, player_animations.jump);
			animate_speed = 0.25;
			x = random_range(480, 1264);
			y = 240;
		}
		
		y += (4 / _fast_forward);
		
		if (y >= 512)
		{
			y = 512;
			state_next_set(boss_antifreak_states.attack_2);
		}
		break;
	case boss_antifreak_states.attack_2:
		if (state_begin)
		{
			attack_angle = random(360);
			timer = 0;
		}
		
		attack_angle = (attack_angle + 2) mod 360;
		timer++;
		
		switch (timer mod (60 - (global.difficulty * 15)))
		{
			case 0:
			case 6:
			case 12:
				sfx_play_global(sfx_explode_short);
				_angle = attack_angle;
			
				repeat (4)
				{
					_fireball = instance_create_layer(x, y, "layer_instances", obj_enemy_fireball, 
					{
						speed: 2.5,
						direction: _angle,
					});
					_angle += 90;
				}
				break;
			default:
				break;
		}
		
		if (timer >= 80)
			state_next_set(boss_antifreak_states.attack_3);
		break;
	case boss_antifreak_states.attack_3:
		if (state_begin)
		{
			speed_x = 0;
			speed_y = 3;
			timer = 96;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			sprite_index = player_animation_get(character_index, player_animations.air);
			animate_speed = 0;
			image_index = 1;
		}
		
		y += speed_y;
		
		if (!is_undefined(_player))
		{
			face = (sign(_player.x - x));
			if (face == 0)
				face = 1;
		}
		
		if (collision_down_simple())
		{
			sprite_index = player_animation_get(character_index, player_animations.idle);
			image_index = 0;
			speed_y = 0;
			timer -= (1 / _fast_forward);
			
			if (timer <= 0)
				state_next_set(boss_antifreak_states.retreat);
		}
		break;
}