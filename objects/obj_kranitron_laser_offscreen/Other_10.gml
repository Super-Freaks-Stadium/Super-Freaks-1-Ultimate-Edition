/// @description Step
var _player;

switch (state)
{
	case 0: //Delay
		if (state_begin)
		{
			timer = 0;
			image_alpha = 0;
			hitbox.active = hitbox_active.inactive;
		}
		
		timer++;
		
		if (timer >= delay)
			state_next_set(1);
		break;
	case 1: //Warning
		if (state_begin)
		{
			timer = 0;
			multiplier = 0;
			image_alpha = 1;
			hitbox.active = hitbox_active.inactive;
			sfx_play_local(sfx_laser_huge_charge, false);
			_player = player_nearest_alive();
			if (!is_undefined(_player))
			{
				y = _player.y;
			}
		}
		
		image_alpha = min(image_alpha + 0.1, 0.5);
		multiplier = min(multiplier + 0.1, 1);
		timer++;
		
		if (timer >= 96)
			state_next_set(2);
		break;
	case 2: //Strike
		if (state_begin)
		{
			timer = 0;
			image_alpha = 1;
			audio_stop_sound(sfx_laser_huge_charge);
			sfx_play_local(sfx_laser_huge_fire, false);
			hitbox.active = hitbox_active.passive;
		}
		
		screen_shake(0, choose(-6, 6));
		timer++;
		
		if (timer >= 32)
			state_next_set(3);
		break;
	case 3: //Disappear
		if (state_begin)
		{
			timer = 0;
			image_alpha = 1;
			hitbox.active = hitbox_active.inactive;
		}
		
		image_alpha = max(image_alpha - 0.05, 0);
		
		if (image_alpha == 0)
			state_next_set(0);
		break;
}