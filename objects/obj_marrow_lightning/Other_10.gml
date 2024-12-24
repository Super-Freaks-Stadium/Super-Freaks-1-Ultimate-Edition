/// @description Step

var _x;

switch (state)
{
	case 0: //Warning
		if (state_begin)
		{
			timer = 0;
			hitbox.active = hitbox_active.inactive;
		}
		
		rectangle_radius = min(rectangle_radius + 1, 8);
		
		timer++;
		
		if (timer >= timer_max)
			state_next_set(1);
		break;
	case 1: //Strike
		if (state_begin)
		{
			timer = 0;
			sfx_play_local(sfx_lightning, false);
			hitbox.active = hitbox_active.passive;
			rectangle_radius = 0;
			screen_shake(0, 6);
		}
		
		timer++;
		
		if (timer >= 16)
		{
			if (spawn_left)
			{
				if (global.difficulty == difficulty_levels.easy)
					_x = x - 128;
				else
					_x = x - 96;
					
				if (_x > 576)
				{
					with (instance_create_layer(_x, y, "layer_instances", obj_marrow_lightning))
					{
						spawn_left = true;
						spawn_right = false;
						if (global.difficulty == difficulty_levels.hard)
							timer_max = 16;
					}
				}
			}
			if (spawn_right)
			{
				if (global.difficulty == difficulty_levels.easy)
					_x = x + 128;
				else
					_x = x + 96;
					
				if (_x < 1024)
				{
					with (instance_create_layer(_x, y, "layer_instances", obj_marrow_lightning))
					{
						spawn_left = false;
						spawn_right = true;
						if (global.difficulty == difficulty_levels.hard)
							timer_max = 16;
					}
				}
			}
			state_next_set(2);
		}
		break;
	case 2: //Disappear
		if (state_begin)
		{
			timer = 0;
			image_alpha = 1;
			hitbox.active = hitbox_active.inactive;
		}
		
		image_alpha = max(image_alpha - 0.1, 0);
		
		if (image_alpha == 0)
			instance_destroy();
		break;
}