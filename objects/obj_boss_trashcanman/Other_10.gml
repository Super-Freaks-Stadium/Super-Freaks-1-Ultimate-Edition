/// @description Step

var _player = player_nearest_alive();
var _fast_forward = fast_forward_level_get() + global.frame_machine_level.multiplier;

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
			sfx_play_local(sfx_slide_whistle_up);
		}
		
		speed_y -= 0.25;
		y += speed_y;
			
		if (y <= 200)
			state_next_set(boss_antifreak_states.wait);
		break;
	case boss_antifreak_states.wait:
		if (state_begin)
		{
			if (wait == 0)
				wait = choose(80, 112);
		}
		
		wait--;
		
		if (wait <= 0)
			state_next_set(boss_antifreak_states.attack_1);
		break;
	case boss_antifreak_states.death:
		if (state_begin)
		{
			global.boss_phase = bit_set(global.boss_phase, 3);
			instance_create_layer(x, y, "layer_instances", obj_boss_explosion);
			screen_shake(0, 8);
			sfx_play_local(sfx_yell_wilhelm);
			speed_x = 0;
			speed_y = -7.15;
			hitbox.active = hitbox_active.inactive;
			laser.active = hitbox_active.inactive;
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
			if (choose(0, 1))
			{
				face = -1;
				x = 1264;
			}
			else
			{
				face = 1;
				x = 480;
			}
			y = 240;
		}
		
		y += (3 / _fast_forward);
		
		if (y >= 628)
		{
			y = 628;
			state_next_set(boss_antifreak_states.attack_2);
		}
		break;
	case boss_antifreak_states.attack_2:
		if (state_begin)
		{
			speed_x = (1.5 + global.difficulty) * face;
			laser.active = hitbox_active.passive;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			sprite_index = player_animation_get(character_index, player_animations.air);
			sfx_play_local(sfx_laser_huge_fire);
			animate_speed = 0;
			image_index = 1;
		}
		
		x += speed_x;
		
		attack_x = x;
		if (collision_down_simple(x, x, x, y + 24, infinity,,, true, false))
			attack_y = global.collider_collision[collider_attach_data.collision_y];
		else
			attack_y = room_height;
		laser.shape_y2 = attack_y - y;
		
		if (face == -1 && x <= 480 || face == 1 && x >= 1264)
			state_next_set(boss_antifreak_states.attack_3);
		break;
	case boss_antifreak_states.attack_3:
		if (state_begin)
		{
			speed_x = 0;
			speed_y = 0;
			timer = 96;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			laser.active = hitbox_active.inactive;
			sprite_index = player_animation_get(character_index, player_animations.air);
			animate_speed = 0;
			image_index = 2;
		}
		
		speed_y = min(speed_y + 0.25, 6);
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