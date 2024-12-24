/// @description Step

var _attack_angle = 180;
var _missile, _missile_limit, _missile_x, _missile_y;
var _player = player_nearest_alive();
if (!is_undefined(_player))
	_attack_angle = point_direction(x, y + 64, _player.x, _player.y);

event_inherited();

timer_missile++;
if (timer_missile >= 128)
{
	timer_missile = 0;
	sfx_play_global(sfx_explode_short);
	_missile = instance_create_layer(x, y + 64, "layer_instances", obj_enemy_energy_orb,
	{
		speed: 8,
		direction: _attack_angle,
	});
	_missile = instance_create_layer(x, y + 64, "layer_instances", obj_enemy_energy_orb,
	{
		speed: 8,
		direction: _attack_angle - 15,
	});
	_missile = instance_create_layer(x, y + 64, "layer_instances", obj_enemy_energy_orb,
	{
		speed: 8,
		direction: _attack_angle + 15,
	});
}

switch (state)
{
	case 0:
		if (state_begin)
		{
			animate_speed = 0.125;
			timer = 0;
		}
		timer++;
		if (animation_at_end())
		{
			screen_shake(0, 6);
			sfx_play_local(sfx_crash_1);
		}
		if (timer >= 64)
		{
			timer = 0;
			state_next_set(1);
		}
		x -= 6;
		break;
	case 1: //Laser Warning
		if (state_begin)
		{
			timer = 0;
			multiplier = 0;
			laser_alpha = 1;
			hitbox_laser.active = hitbox_active.inactive;
			sfx_play_local(sfx_laser_huge_charge, false);
			hitbox_laser.shape_x1 = lengthdir_x(8000, _attack_angle);
			hitbox_laser.shape_y1 = lengthdir_y(8000, _attack_angle);
			hitbox_laser.shape_x2 = 0;
			hitbox_laser.shape_y2 = 64;
		}
		
		laser_alpha = min(laser_alpha + 0.1, 0.5);
		multiplier = min(multiplier + 0.1, 1);
		timer++;
		
		if (timer >= 96)
			state_next_set(2);
		break;
	case 2: //Laser Strike
		if (state_begin)
		{
			timer = 0;
			laser_alpha = 1;
			audio_stop_sound(sfx_laser_huge_charge);
			sfx_play_local(sfx_laser_huge_fire, false);
			hitbox_laser.active = hitbox_active.passive;
		}
		
		screen_shake(0, choose(-6, 6));
		timer++;
		
		if (timer >= 32)
			state_next_set(3);
		break;
	case 3: //Laser Disappear
		if (state_begin)
		{
			timer = 0;
			laser_alpha = 1;
			hitbox_laser.active = hitbox_active.inactive;
		}
		
		laser_alpha = max(laser_alpha - 0.05, 0);
		
		if (laser_alpha == 0)
			state_next_set(1);
		break;
	case 4: //Death
		if (state_begin)
		{
			music_stop();
			timer = 0;
			animate_speed = 0;
			laser_alpha = 0;
			hitbox.active = hitbox_active.inactive;
			hitbox_laser.active = hitbox_active.inactive;
		}
			
		y += 1;
		timer_missile = 0;
		if (timer < 128)
		{
			if (timer mod 16 == 0)
				instance_create_layer(x - 128 + random(240), y - 256 + random(512), "layer_instances", obj_boss_explosion);
			timer++;
		}
		else
		{
			state_next_set(-1);
			level_beat();
		}
		break;
}