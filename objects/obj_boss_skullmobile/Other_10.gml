/// @description Step

var _angle;
var _missile, _attack_angle, _missile_x, _missile_y;

// Inherit the parent event
event_inherited();

switch (state)
{
	case boss_skullmobile_states.intro:
		y = min(y + 2, 704);
		
		if (y == 704)
			state_next_set(boss_skullmobile_states.intro_2);
		break;
	case boss_skullmobile_states.intro_2:
		laser_distance = max(laser_distance - 4, 64);
		
		if (laser_distance == 64)
			state_next_set(boss_skullmobile_states.intro_3);
		break;
	case boss_skullmobile_states.intro_3:
		if (state_begin)
		{
			timer = 0;
			screen_shake(0, 8);
			sfx_play_global(sfx_crash_1);
		}
		
		timer++;
		if (timer >= 24)
			state_next_set(boss_skullmobile_states.active);
		break;
	case boss_skullmobile_states.active:
		if (state_begin)
		{
			timer = 0;
			target = player_nearest_alive();
			laser_distance = 64;
			laser_left.active = hitbox_active.passive;
			laser_right.active = hitbox_active.passive;
			sfx_play_global(sfx_laser_huge_fire);
		}
		
		#region Laser Angle
			laser_angle_previous = laser_angle;
			laser_angle += laser_rotate_speed;
			if (laser_angle < 0)
			{
				laser_angle += 360;
				laser_angle_previous += 360;
			}
			else if (laser_angle >= 360)
			{
				laser_angle -= 360;
				laser_angle_previous -= 360;
			}
		#endregion
		
		#region Ship Angle
			if (!is_undefined(target) && instance_exists(target))
			{
				target_x = target.x;
				target_y = target.y;
			}
			_angle = point_direction(x, y, target_x, target_y);
			angle = lerp_360(angle, _angle, 0.125);
			if (angle < 0)
			{
				angle += 360;
				angle_previous += 360;
			}
			else if (angle >= 360)
			{
				angle -= 360;
				angle_previous -= 360;
			}
		#endregion
		
		timer++;
		
		if (timer >= 120)
		{
			timer = 0;
			sfx_play_global(sfx_explode_short);
			_attack_angle = angle;
			_missile_x = x + lengthdir_x(80, angle);
			_missile_y = y + lengthdir_y(80, angle);
            
            _missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_energy_orb,
			{
				speed: 3,
				direction: _attack_angle,
			});
            /*
			switch (attack_increment)
			{
				case 0:
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_energy_orb,
					{
						speed: 3,
						direction: _attack_angle,
					});
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_fireball,
					{
						speed: 3,
						direction: _attack_angle - 45,
					});
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_fireball,
					{
						speed: 3,
						direction: _attack_angle + 45,
					});
					break;
				case 1:
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_energy_orb,
					{
						speed: 3,
						direction: _attack_angle - 45,
					});
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_fireball,
					{
						speed: 3,
						direction: _attack_angle,
					});
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_fireball,
					{
						speed: 3,
						direction: _attack_angle + 45,
					});
					break;
				case 2:
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_energy_orb,
					{
						speed: 3,
						direction: _attack_angle + 45,
					});
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_fireball,
					{
						speed: 3,
						direction: _attack_angle - 45,
					});
					_missile = instance_create_layer(_missile_x, _missile_y, "layer_instances", obj_enemy_fireball,
					{
						speed: 3,
						direction: _attack_angle,
					});
					break;
			}
            */
			
			target = player_nearest_alive();
			attack_increment = (attack_increment + 1) mod 3;
		}
		break; 
    case boss_skullmobile_states.death:
        if (state_begin)
        {
            global.turbo.pause = true;
            timer = 0;
            laser_distance = 64;
            hitbox.active = hitbox_active.inactive;
            gun_left.active = hitbox_active.inactive;
            gun_right.active = hitbox_active.inactive;
            laser_left.active = hitbox_active.inactive;
            laser_right.active = hitbox_active.inactive;
            screen_shake(0, 8);
            if (global.game_mode != game_modes.boss_rush)
                music_stop();
        }
        
        y += 0.5;
        
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



gun_left.x_offset = lengthdir_x(laser_distance, laser_angle + 180);
gun_left.y_offset = lengthdir_y(laser_distance, laser_angle + 180);
laser_left.x_offset = gun_left.x_offset;
laser_left.y_offset = gun_left.y_offset;
laser_left.shape_x2 = lengthdir_x(2000, laser_angle + 180);
laser_left.shape_y2 = lengthdir_y(2000, laser_angle + 180);
gun_right.x_offset = lengthdir_x(laser_distance, laser_angle);
gun_right.y_offset = lengthdir_y(laser_distance, laser_angle);
laser_right.x_offset = gun_right.x_offset;
laser_right.y_offset = gun_right.y_offset;
laser_right.shape_x2 = lengthdir_x(2000, laser_angle);
laser_right.shape_y2 = lengthdir_y(2000, laser_angle);

laser_color = laser_color + 15 mod 360;