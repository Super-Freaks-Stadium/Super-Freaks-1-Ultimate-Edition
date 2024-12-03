/// @description Step

wartnose_visuals.y_offset_previous = wartnose_visuals.y_offset;

var _cup,
	_cup_list = cups,
	_cup_list_length = array_length(_cup_list);
	
var _x_intended,
	_y,
	_timer;

/*
enum boss_wartnose_states
{
	intro = 0,
	shuffle,
	attack,
	lower,
	death,
}
*/

hurt_timer_step();

switch (state)
{
	case boss_wartnose_states.intro:
		if (state_begin)
		{
			y = 600;
			hide = true;
			hitbox.active = hitbox_active.inactive;
		}
		y = min(y + 4, ystart);
		if (y == ystart)
			state_next_set(boss_wartnose_states.lower);
		break;
	case boss_wartnose_states.lower:
		if (state_begin)
		{
			hide = false;
			timer = 48;
			hitbox.active = hitbox_active.passive;
			sprite_index = spr_boss_wartnose;
		}
		timer--;
			
		if (timer < 1)
			state_next_set(boss_wartnose_states.raise);
		break;
	case boss_wartnose_states.raise:
		if (state_begin)
		{
			hide = true;
			timer = 16;
		}
		timer--;
			
		if (timer < 1)
			state_next_set(boss_wartnose_states.shuffle);
		break;
	case boss_wartnose_states.shuffle:
		if (state_begin)
		{
			shuffles = 2 + global.boss_phase;
			timer_max = lerp(72, 12, phase / 4);
			timer = timer_max;
			shuffle_cups();
			hide = true;
			fast_forward = true;
			sfx_play_global(sfx_zip);
			
			if (global.boss_phase == 1)
			{
				if (choose(0, 1) == 1)
				{
					with (instance_create_layer(320, 896, "layer_instances", obj_pointy))
						speed_h = 4;
				}
				else
				{
					with (instance_create_layer(1280, 896, "layer_instances", obj_pointy))
						speed_h = -4;
				}
			}
		}
		
		timer = max(timer - 1, 0);
		_timer = (timer_max - timer) / timer_max;
		
		for (_cup = 0; _cup < _cup_list_length; ++_cup)
		{
			_x_intended = cup_positions[_cup];
			with (cups[_cup])
            {
                x_previous = x;
				x = lerp(x, _x_intended, _timer);
            }
		}
		
		if (timer == 0)
		{
			if (shuffles > 0)
			{
				shuffles--;
				shuffle_cups();
				timer_max = lerp(56, 12, phase / 4);
				timer = timer_max;
				sfx_play_global(sfx_zip);
			}
			else
				state_next_set(boss_wartnose_states.attack);
		}
		break;
	case boss_wartnose_states.attack:
		if (state_begin)
		{
			timer = 48;
			fast_forward = false;
		}
		
		timer = max(timer - 1, 0);
		
		if (timer > 16 && (timer mod 4 == 0))
		{
			_y = y;
			sfx_play_global(sfx_explode_short);
			for (_cup = 1; _cup < _cup_list_length; ++_cup)
			{
				with (cups[_cup])
				{
					instance_create_layer(x - 16, _y, "layer_instances", obj_enemy_fireball, 
					{
						speed: 4,
						direction: 270,
						zone_index: -3
					});
					instance_create_layer(x + 16, _y, "layer_instances", obj_enemy_fireball, 
					{
						speed: 4,
						direction: 270,
						zone_index: -3
					});
				}
			}
		}
		
		if (timer == 0)
			state_next_set(boss_wartnose_states.lower);
		break;
	case boss_wartnose_states.death:
		if (state_begin)
		{
			hide = false;
			timer = 0;
			hitbox.active = hitbox_active.inactive;
			global.boss_phase = 2;
			sprite_index = spr_boss_wartnose_death;
			music_stop();
			with (obj_pointy)
				enemy_hurt(100);
			with (obj_enemy_fireball)
				instance_destroy();
		}
		
		y++;
		
		if (timer < 128)
		{
			if (timer mod 4 == 0)
			{
				_cup = cups[irandom(_cup_list_length - 1)];
				instance_create_layer(_cup.x - 64 + random(128), y - 64 + random(128), "layer_instances", obj_boss_explosion);
			}
			timer++;
		}
		else
		{
			state_next_set(-1);
			level_beat();
		}
		break;
}



if (hide)
	wartnose_visuals.y_offset = max(wartnose_visuals.y_offset - 8, -128);
else
	wartnose_visuals.y_offset = min(wartnose_visuals.y_offset + 8, 0);

hitbox.x_offset = cups[0].x - x;
hitbox.y_offset = wartnose_visuals.y_offset;
x_offset_yorb = hitbox.x_offset;
	
wartnose_visuals.flip_timer++;
if (wartnose_visuals.flip_timer > 7)
{
	wartnose_visuals.flip_timer = 0;
	wartnose_visuals.flip *= -1;
}