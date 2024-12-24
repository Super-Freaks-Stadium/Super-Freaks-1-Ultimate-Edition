/// @description Step

var _fireball, _shoot_direction;
var _zone = zone_index;
var _attack_x;

// Inherit the parent event
event_inherited();

switch (state)
{
	case enemy_gunnery_states.walk:
		if (state_begin)
		{
			sprite_index = spr_gunnery_walk;
			image_index = 0;
			timer = 0;
			speed_walk = walk_speed;
			animate_speed = speed_walk * 0.125;
			ammo = 6;
		}
		switch (face)
		{
			case -1:
				collision_left_simple(x, y, y, y, infinity,,, true, false);
				_attack_x = global.collider_collision[collider_attach_data.collision_x];
				break;
			default:
				collision_right_simple(x, y, y, y, infinity,,, true, false);
				_attack_x = global.collider_collision[collider_attach_data.collision_x];
				break;
		}
		if (collision_rectangle(_attack_x, y - 48, x, y + 48, obj_player, false, false))
			state_next_set(enemy_gunnery_states.shoot_1);
		break;
	case enemy_gunnery_states.shoot_1:
		if (state_begin)
		{
			sprite_index = spr_gunnery_shoot;
			image_index = 0;
			//timer = 0;
			speed_walk = 0;
			animate_speed = 0;
		}
		timer++;
		if (timer >= 24)
			state_next_set(enemy_gunnery_states.shoot_2);
		break;
	case enemy_gunnery_states.shoot_2:
		if (state_begin)
		{
			sprite_index = spr_gunnery_shoot;
			image_index = 1;
			timer = 0;
			speed_walk = 0;
		}
		ammo--;
		switch (face)
		{
			case -1:
				_shoot_direction = 180;
				break;
			default:
				_shoot_direction = 0;
				break;
		}
		if (in_view())
			sfx_play_local(sfx_explode_short);
		_fireball = instance_create_layer(x, y + lengthdir_y(4, shoot_spread), "layer_instances", obj_enemy_fireball, 
		{
			speed: 4,
			direction: _shoot_direction,
			zone_index: _zone
		});
		shoot_spread = (shoot_spread + 45) mod 360;
		if (ammo <= 0)
			state_next_set(enemy_gunnery_states.reload);
		else
			state_next_set(enemy_gunnery_states.shoot_3);
		break;
	case enemy_gunnery_states.shoot_3:
		if (state_begin)
		{
			sprite_index = spr_gunnery_shoot;
			image_index = 0;
			timer = 0;
		}
		timer++;
		if (timer >= 4)
		{
			switch (face)
			{
				case -1:
					collision_left_simple(x, y, y, y, infinity,,,, false);
					_attack_x = global.collider_collision[collider_attach_data.collision_x];
					break;
				default:
					collision_right_simple(x, y, y, y, infinity,,,, false);
					_attack_x = global.collider_collision[collider_attach_data.collision_x];
					break;
			}
			if (collision_rectangle(_attack_x, y - 48, x, y + 48, obj_player, false, false))
				state_next_set(enemy_gunnery_states.shoot_2);
			else
				state_next_set(enemy_gunnery_states.reload);
		}
		break;
	case enemy_gunnery_states.reload:
		if (state_begin)
		{
			sprite_index = spr_gunnery_reload;
			image_index = 0;
			timer = 0;
			ammo = 6;
			animate_speed = 0;
		}
		
		timer++;
		
		if (animate_speed == 0 && timer > 32)
		{
			animate_speed = 0.1;
			sfx_play_local(sfx_gun_cock);
		}
		
		if (animation_about_to_end())
		{
			switch (face)
			{
				case -1:
					collision_left_simple(x, y, y, y, infinity,,,, false);
					_attack_x = global.collider_collision[collider_attach_data.collision_x];
					break;
				default:
					collision_right_simple(x, y, y, y, infinity,,,, false);
					_attack_x = global.collider_collision[collider_attach_data.collision_x];
					break;
			}
			if (collision_rectangle(_attack_x, y - 48, x, y + 48, obj_player, false, false))
				state_next_set(enemy_gunnery_states.shoot_2);
			else
				state_next_set(enemy_gunnery_states.walk);
		}
		break;
}

