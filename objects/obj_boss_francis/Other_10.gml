/// @description Step

var _target = player_nearest_alive();
var _attack_finish = false;
var _fast_forward = fast_forward_level_get() + global.frame_machine_level.multiplier;

var _claw_left_x = x + lengthdir_x(112 * size, claw_left_pos);
var _claw_left_y = y + lengthdir_y(112 * size, claw_left_pos);
var _claw_right_x = x + lengthdir_x(112 * size, claw_right_pos);
var _claw_right_y = y + lengthdir_y(112 * size, claw_right_pos);

var _fireball, _attack_angle;
var _angle;
var _length = (chain_segments * 32) * chain_size;

#region Buzzsaw
	buzzsaw_angle_previous = buzzsaw_angle;
	buzzsaw_angle = (buzzsaw_angle + swing_speed);
	if (buzzsaw_angle < 0)
		buzzsaw_angle += 360;
	buzzsaw_angle = buzzsaw_angle mod 360;

	_angle = (lengthdir_x(90, buzzsaw_angle) + 270) mod 360;

	buzzsaw_x_previous = buzzsaw_x;
	buzzsaw_y_previous = buzzsaw_y;
	buzzsaw_x = lengthdir_x(_length, _angle);
	buzzsaw_y = lengthdir_y(_length, _angle);
	hitbox_buzzsaw.x_offset = buzzsaw_x;
	hitbox_buzzsaw.y_offset = buzzsaw_y;
	hitbox_buzzsaw_2.x_offset = -buzzsaw_x;
	hitbox_buzzsaw_2.y_offset = buzzsaw_y;
#endregion

#region Body Size
	size_multiplier_previous = size_multiplier;
	size_multiplier = max(size_multiplier - 0.025, size);
	hitbox.radius = 112 * size_multiplier;
#endregion

#region Claws
	claw_left_angle_previous = claw_left_angle;
	claw_left_pos_previous = claw_left_pos;
	claw_left_timer = max(claw_left_timer - 1, 0);
	if (claw_left_timer == 0)
		claw_left_index = 0;
	
	claw_right_angle_previous = claw_right_angle;
	claw_right_pos_previous = claw_right_pos;
	claw_right_timer = max(claw_right_timer - 1, 0);
	if (claw_right_timer == 0)
		claw_right_index = 0;
#endregion
	
#region Animations
	cockpit_index = cockpit_index + 0.125 mod 4;
	cockpit_timer = max(cockpit_timer - 1, 0);
	if (cockpit_timer == 0)
		cockpit_sprite = spr_boss_francis_cockpit_normal;
#endregion
	
hurt_timer_step();

switch (state)
{
	case boss_francis_states.intro:
		if (state_begin)
		{
			hitbox.active = hitbox_active.inactive;
			y = 1124;
		}
		
		y = max(y - 3, 608);
		
		if (y == 608)
		{
			hitbox.active = hitbox_active.passive;
			state_next_set(boss_francis_states.higher);
			global.boss_phase = 1;
		}
		break;
	case boss_francis_states.higher:
		if (state_begin)
		{
			speed_h = choose(-speed_h_max, speed_h_max);
			timer = 0;
			counter_attack = 0;
			claw_left_index = 0;
			claw_right_index = 0;
		}
		
		claw_left_pos = lerp_360(claw_left_pos, 225, 0.125);
		claw_right_pos = lerp_360(claw_right_pos, 315, 0.125);
		
		timer = min(timer + (1 / _fast_forward), attack_frequency);
		if (timer >= attack_frequency)
		{
			if (counter_attack >= attack_times)
				state_next_set(boss_francis_states.lower);
			else
			{
				switch (claw_side)
				{
					case 0: //Left
						if (!is_undefined(_target))
						{
							_attack_angle = point_direction(_claw_left_x, _claw_left_y, _target.x, _target.y);
							claw_left_angle = lerp_360(claw_left_angle, _attack_angle, 0.5);
							if (abs(angle_difference(round(claw_left_angle), round(_attack_angle))) == 0)
							{
								_attack_finish = true;
								claw_left_index = 1;
								claw_left_timer = 16;
								sfx_play_global(sfx_explode_short);
								_fireball = instance_create_layer(_claw_left_x, _claw_left_y, "layer_instances", obj_enemy_fireball, 
								{
									speed: 4,
									direction: _attack_angle,
									zone_index: -3
								});
								if (global.boss_phase > 1)
								{
									_fireball = instance_create_layer(_claw_left_x, _claw_left_y, "layer_instances", obj_enemy_fireball, 
									{
										speed: 4,
										direction: _attack_angle - 2.5,
										zone_index: -3
									});
									_fireball = instance_create_layer(_claw_left_x, _claw_left_y, "layer_instances", obj_enemy_fireball, 
									{
										speed: 4,
										direction: _attack_angle + 2.5,
										zone_index: -3
									});
								}
							}
						}
						break;
					case 1: //Right
						if (!is_undefined(_target))
						{
							_attack_angle = point_direction(_claw_right_x, _claw_right_y, _target.x, _target.y);
							claw_right_angle = lerp_360(claw_right_angle, _attack_angle, 0.5);
							if (abs(angle_difference(round(claw_right_angle), round(_attack_angle))) == 0)
							{
								_attack_finish = true;
								sfx_play_global(sfx_explode_short);
								claw_right_index = 1;
								claw_right_timer = 16;
								_fireball = instance_create_layer(_claw_right_x, _claw_right_y, "layer_instances", obj_enemy_fireball, 
								{
									speed: 4,
									direction: _attack_angle,
									zone_index: -3
								});
								if (global.boss_phase > 1)
								{
									_fireball = instance_create_layer(_claw_right_x, _claw_right_y, "layer_instances", obj_enemy_fireball, 
									{
										speed: 4,
										direction: _attack_angle - 2.5,
										zone_index: -3
									});
									_fireball = instance_create_layer(_claw_right_x, _claw_right_y, "layer_instances", obj_enemy_fireball, 
									{
										speed: 4,
										direction: _attack_angle + 2.5,
										zone_index: -3
									});
								}
							}
						}
						break;
				}
			
				if (_attack_finish)
				{
					counter_attack++;
					claw_side = !claw_side;
					timer = 0;
				}
			}
		}
			
		x += speed_h;
		y = max(y - 6, 608);
		
		if (x >= 1040 && sign(speed_h) == 1)
		{
			x = 1040;
			speed_h = -speed_h;
		}
		else if (x <= 558 && sign(speed_h) == -1)
		{
			x = 558;
			speed_h = -speed_h;
		}
		break;
	case boss_francis_states.lower:
		if (state_begin)
		{
			timer = 0;
			speed_h = 0;
		}
		
		claw_left_angle = lerp_360(claw_left_angle, 247.5, 0.5);
		claw_right_angle = lerp_360(claw_right_angle, 292.5, 0.5);
		claw_left_pos = lerp_360(claw_left_pos, 180, 0.25);
		claw_right_pos = lerp_360(claw_right_pos, 360, 0.25);
		claw_left_index = 1;
		claw_right_index = 1;
			
		//x += speed_h;
		y = min(y + 4, 736);
		
		if (y == 736)
		{
			timer = min(timer + 1, 128);
			if (timer == 128)
				state_next_set(boss_francis_states.higher);
			else if (timer mod 4 == 0)
			{
				_fireball = instance_create_layer(_claw_left_x, _claw_left_y + 24, "layer_instances", obj_enemy_fireball, 
				{
					speed: 4,
					direction: 247.5,
					zone_index: -3
				});
				_fireball = instance_create_layer(_claw_right_x, _claw_right_y + 24, "layer_instances", obj_enemy_fireball, 
				{
					speed: 4,
					direction: 292.5,
					zone_index: -3
				});
			}
		}
		
		if (x >= 1040 && sign(speed_h) == 1)
		{
			x = 1040;
			speed_h = -speed_h;
		}
		else if (x <= 558 && sign(speed_h) == -1)
		{
			x = 558;
			speed_h = -speed_h;
		}
		break;
	case boss_francis_states.buzzsaw:
		if (state_begin)
		{
			speed_h = choose(-speed_h_max, speed_h_max);
			timer = 0;
			counter_attack = 0;
		}
		
		x += speed_h;
		y = min(y + 4, 736);
		
		timer = min(timer + 1, 64);
		if (timer == 64)
		{
			chain_size = min(chain_size + 0.025, 1);
			hitbox_buzzsaw.active = hitbox_active.passive;
			if (global.difficulty == difficulty_levels.hard)
				hitbox_buzzsaw_2.active = hitbox_active.passive;
			if (chain_size == 1)
			{
				switch (global.difficulty)
				{
					case difficulty_levels.easy:
						swing_speed = 1;
						break;
					case difficulty_levels.normal:
						swing_speed = 2;
						break;
					case difficulty_levels.hard:
						swing_speed = 1.25;
						break;
				}
			}
		}
		
		if (x >= 1040 && sign(speed_h) == 1)
		{
			x = 1040;
			speed_h = -speed_h;
		}
		else if (x <= 558 && sign(speed_h) == -1)
		{
			x = 558;
			speed_h = -speed_h;
		}
		break;
	case boss_francis_states.death:
		if (state_begin)
		{
			speed_h = 0;
			hitbox.active = hitbox_active.inactive;
			hitbox_buzzsaw.active = hitbox_active.inactive;
			hitbox_buzzsaw_2.active = hitbox_active.inactive;
			swing_speed = 0;
			timer = 0;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
		}
		
		y += 2;
		
		cockpit_sprite = spr_boss_francis_cockpit_hurt;
		cockpit_timer = 8;
		
		if (timer < 128)
		{
			if (timer mod 16 == 0)
				instance_create_layer(x - 64 + random(128), y - 64 + random(128), "layer_instances", obj_boss_explosion);
			timer++;
		}
		else
		{
			state_next_set(-1);
			level_beat();
		}
		break;
}