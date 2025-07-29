/// @description Step
var _i, _arm_seg, _arm_length, _shockwave;

event_inherited();

collision_flags = 0;

arm_angle = arm_angle + arm_speed mod 360;
if (arm_angle < 0)
{
	arm_angle += 360;
	arm_angle_previous += 360;
}

if (arm_active)
{
	if (arm_extend)
		arm_length = min(arm_length + 0.015, 1);
	else
		arm_length = max(arm_length - 0.1, 0);
}

switch (state)
{
	case boss_milkman_states.intro_1:
		if (state_begin)
		{
			hit_counter = 0;
			timer = 0;
			sprite_index = spr_milkman_intro;
			image_index = 0;
		}
		timer = min(timer + 1, 64);
		if (timer == 64)
		{
			image_index = 1;
			y -= 16;
			
			if (y <= 128)
			{
				y = 128;
				state_next_set(boss_milkman_states.intro_2);
			}
		}
		break;
	case boss_milkman_states.intro_2:
		if (state_begin)
		{
			sprite_index = spr_milkman_body;
			speed_v = 0;
			sfx_play_global(sfx_fall);
		}
		
		y += 12;
		
		if (collision_down_simple())
		{
			sfx_play_global(sfx_crash_1);
			state_next_set(boss_milkman_states.normal);
			speed_v = 0;
			ground_on = true;
			_shockwave = instance_create_layer(x, y, "layer_instances", obj_enemy_shockwave);
			_shockwave.speed_h = -6;
			_shockwave = instance_create_layer(x, y, "layer_instances", obj_enemy_shockwave);
			_shockwave.speed_h = 6;
			global.boss_phase = 1;
			screen_shake(0, 16);
		}
		break;
	case boss_milkman_states.normal:
		if (state_begin)
		{
			hit_counter = 0;
			timer = 0;
			hitbox.active = hitbox_active.passive;
			hitbox_lower.active = hitbox_active.passive;
			ground_on = true;
			arm_extend = true;
			speed_v = 0;
		}
		
		timer = min(timer + 1, 420);
		
		if (ground_on)
		{
			if (timer == 420 || hit_counter >= 2)
				state_next_set(boss_milkman_states.jump_up);
			else if (timer mod shockwave_frequency == 0)
			{
				speed_v = -2;
				ground_on = false;
			}
			
			y += speed_v;
		}
		else
		{
			speed_v = min(speed_v + 0.125, 2);
			y += speed_v;
			
			if (collision_down_simple())
			{
				sfx_play_global(sfx_crash_1);
				speed_v = 0;
				ground_on = true;
				_shockwave = instance_create_layer(x, y, "layer_instances", obj_enemy_shockwave);
				_shockwave.speed_h = -6;
				_shockwave = instance_create_layer(x, y, "layer_instances", obj_enemy_shockwave);
				_shockwave.speed_h = 6;
				screen_shake(0, 8);
			}
		}
		break;
	case boss_milkman_states.jump_up:
		if (state_begin)
		{
			speed_v = 0;
			if (arm_extend == true)
			{
				arm_extend = false;
				sfx_play_global(sfx_zip);
			}
		}

		if (arm_length == 0)
			speed_v = max(speed_v - speed_grv, -6);
		
		y += speed_v;
		
		if (y <= room_height - 332)
		{
			y = room_height - 332;
			state_next_set(boss_milkman_states.move_air);
		}
		break;
	case boss_milkman_states.move_air:
		if (state_begin)
		{
			speed_h = choose(-4, 4);
			speed_v = 0;
			timer = 0;
		}
		
		timer = min(timer + 1, 96);
		if (timer >= 64)
			speed_h = 0;
		if (timer == 96)
			state_next_set(boss_milkman_states.fall);
			
		x += speed_h;
		
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
	case boss_milkman_states.fall:
		if (state_begin)
		{
			speed_v = 0;
			sfx_play_global(sfx_fall);
		}
		speed_v = min(speed_v + speed_grv, 6);
		
		y += speed_v;
		
		if (collision_down_simple())
		{
			sfx_play_global(sfx_crash_1);
			state_next_set(boss_milkman_states.normal);
			speed_v = 0;
			ground_on = true;
			_shockwave = instance_create_layer(x, y, "layer_instances", obj_enemy_shockwave);
			_shockwave.speed_h = -6;
			_shockwave = instance_create_layer(x, y, "layer_instances", obj_enemy_shockwave);
			_shockwave.speed_h = 6;
			screen_shake(0, 16);
		}
		break;
	case boss_milkman_states.death:
		if (state_begin)
		{
            global.turbo.pause = true;
			global.boss_phase = 3;
			hitbox.active = hitbox_active.inactive;
			hitbox_lower.active = hitbox_active.inactive;
			boss_milkman_activate_arms(false);
			timer = 0;
			audio_stop_sound(sfx_fall);
			audio_stop_sound(sfx_crash_1);
			arm_speed = 8;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
		}
			
		if (timer < 128)
		{
			if (timer mod 16 == 0)
				instance_create_layer(x - 64 + random(128), y - 320 + random(320), "layer_instances", obj_boss_explosion);
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
	
for (_i = array_length(arm[0]) - 1; _i >= 0; --_i)
{
	_arm_seg = arm[0][_i];
	_arm_length = arm_length * 16 * (array_length(arm[0]) - 1 - _i);
	
	_arm_seg.x_offset = -80 + lengthdir_x(_arm_length, -arm_angle);
	_arm_seg.y_offset = arm_offset + lengthdir_y(_arm_length, -arm_angle);
}

for (_i = array_length(arm[1]) - 1; _i >= 0; --_i)
{
	_arm_seg = arm[1][_i];
	_arm_length = arm_length * 16 * (array_length(arm[1]) - 1 - _i);
	
	_arm_seg.x_offset = 80 + lengthdir_x(_arm_length, arm_angle);
	_arm_seg.y_offset = arm_offset + lengthdir_y(_arm_length, arm_angle);
}