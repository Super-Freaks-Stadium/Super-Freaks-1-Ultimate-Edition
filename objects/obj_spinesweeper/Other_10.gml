/// @description Step

var _target = player_nearest_alive();
var _target_direction;

// Inherit the parent event
event_inherited();

switch (state)
{
	case 0:
		if (state_begin)
		{
			sprite_index = spr_spinesweeper_normal;
			hitbox.active = hitbox_active.passive;
		}
			
		if (!is_undefined(_target))
		{
			_target_direction = point_direction(x, y, _target.x, _target.y);
			x += lengthdir_x(2, _target_direction);
			y += lengthdir_y(2, _target_direction);
			if (point_distance(x, y, _target.x, _target.y) < 96)
				state_next_set(1);
		}

		if (point_distance(xstart, ystart, x, y) > range)
		{
			_target_direction = point_direction(xstart, ystart, x, y);
			x = xstart + lengthdir_x(range, _target_direction);
			y = ystart + lengthdir_y(range, _target_direction);
		}
		break;
	case 1:
		if (state_begin)
			sprite_index = spr_spinesweeper_danger;
		size += 0.05;
		if (size >= 3)
		{
			instance_create_layer(x, y, "layer_instances", obj_explosion_bomb,
			{
				image_xscale: 1.5,
			});
			state_next_set(2);
		}
		break;
	case 2:
		if (state_begin)
		{
			timer = 0;
			size = 0.5;
			size_previous = 0.5;
			sprite_index = spr_spinesweeper_recover;
			hitbox.active = hitbox_active.inactive;
		}
		
		if (!is_undefined(_target))
		{
			_target_direction = point_direction(x, y, _target.x, _target.y);
			x += lengthdir_x(1, _target_direction);
			y += lengthdir_y(1, _target_direction);
		}
		if (point_distance(xstart, ystart, x, y) > range)
		{
			_target_direction = point_direction(xstart, ystart, x, y);
			x = xstart + lengthdir_x(range, _target_direction);
			y = ystart + lengthdir_y(range, _target_direction);
		}
		
		timer = min(timer + 1, 128);
		
		if (timer == 128)
		{
			size = min(size + 0.025, 1);
			if (size == 1)
				state_next_set(0);
		}
		break;
}

hitbox.radius = 24 * size;