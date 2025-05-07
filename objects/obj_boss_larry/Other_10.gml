/// @description Step

var _collision_left = false, _collision_right = false, _collision_up = false, _collision_down = false;
var _radius = 64 * image_xscale;
var _collider_size = 28 * image_xscale;

hurt_timer_step();
collision_flags = 0;
angle_previous = angle;

//speed_h *= speed_frc_air;
if (speed_v < 6)
	speed_v = min(speed_v + speed_grv, 6);

x += speed_h;
y += speed_v;

switch sign(x - x_previous)
{
	case -1:
		collision_right_simple(,,,,,,, false);
		collision_left_simple();
		break;
	case 0:
		collision_left_simple();
		collision_right_simple();
		break;
	case 1:
		collision_left_simple(,,,,,,, false);
		collision_right_simple();
		break;
}
		
switch sign(y - y_previous)
{
	case -1:
		collision_down_simple(,,,,,,, false);
		collision_up_simple();
		break;
	case 0:
	case 1:
		collision_up_simple();
		collision_down_simple();
		break;
}

_collision_left = collision_flag_get_left();
_collision_up = collision_flag_get_up();
_collision_right = collision_flag_get_right();
_collision_down = collision_flag_get_down();

if (_collision_left)
{
	if (speed_h < 0)
	{
		speed_h = -speed_h;
		sfx_play_global(sfx_bounce_rubber);
	}
}
if (_collision_right)
{
	if (speed_h > 0)
	{
		speed_h = -speed_h;
		sfx_play_global(sfx_bounce_rubber);
	}
}
if (_collision_up)
{
	if (speed_v < 0)
	{
		speed_v = -speed_v;
		sfx_play_global(sfx_bounce_rubber);
	}
}
if (_collision_down)
{
	if (speed_v >= 0)
	{
		speed_v = -7.15;
		sfx_play_global(sfx_bounce_rubber);
	}
}

switch (state)
{
	case 0: //Normal
		if (state_begin)
		{
			image_index = 0;
			hitbox.behavior = enemy_hitbox_behaviors.heavy;
			blink = false;
		}
		timer = min(timer + 1, 256);
		
		if (timer == 256)
		{
			state_next_set(1);
			timer = 0;
		}
		else if (timer >= 200)
		{
			image_index = 1;
			if (global.game_frame_new)
			{
				//if (timer mod 2 == 0)
					blink = !blink;
			}
		}
		break;
	case 1: //Spike
		if (state_begin)
		{
			image_index = 1;
			hitbox.behavior = enemy_hitbox_behaviors.heavy_hazard;
			blink = false;
			sfx_play_global(sfx_pluck);
		}
		timer = min(timer + 1, 96);
		
		if (timer == 96)
		{
			state_next_set(0);
			timer = 0;
		}
		break;
	case 2: //Death
		if (state_begin)
		{
            global.turbo.pause = true;
			image_index = 2;
			hitbox.active = hitbox_active.inactive;
			blink = false;
			speed_h *= -4;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
			timer = 0;
		}
		if (timer < 128)
		{
			image_xscale += 0.01;
			image_yscale = image_xscale;
			if (timer mod 8 == 0)
				instance_create_layer(x - 80 + random(160), y - 80 + random(160), "layer_instances", obj_boss_explosion);
			timer++;
		}
		else
			state_next_set(3);
		collider_detector_sides_set(-_collider_size,, _collider_size,, _radius);
		collider_detector_up_set(-_collider_size,, _collider_size,, -_radius);
		collider_detector_down_set(-_collider_size,, _collider_size,, _radius);
		break;
	case 3: //Death 2
		if (state_begin)
		{
			speed_h = 0;
			speed_v = 0;
			speed_grv = 0;
			image_alpha = 0;
			timer = 0;
			instance_create_layer(x, y, "layer_instances", obj_boss_explosion, 
			{
				image_xscale: 3,
				image_yscale: 3,
			});
		}
		
		timer = min(timer + 1, 48);
		if (timer == 48)
		{
			state_next_set(-1);
			level_beat();
		}
		break;
}

angle -= (x - x_previous);

if (angle < 0)
{
	angle += 360;
	angle_previous += 360;
}
if (angle >= 360)
{
	angle -= 360;
	angle_previous -= 360;
}