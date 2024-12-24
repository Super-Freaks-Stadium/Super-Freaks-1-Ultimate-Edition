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
			x = room_width;
		}
		
		timer++;
		
		if (metronome_warn() and timer >= delay)
			state_next_set(1);
		break;
	case 1: //Warning
		if (state_begin)
		{
			timer = 0;
			image_alpha = 1;
			hitbox.active = hitbox_active.inactive;
			_player = player_nearest_alive();
			if (!is_undefined(_player))
			{
				switch (sign(_player.x - _player.x_previous))
				{
					case -1:
					case 0:
						x = _player.x;
						break;
					case 1:
						x = _player.x + (32 * (_player.x - _player.x_previous));
						break;
				}
			}
		}
		
		image_alpha = max(image_alpha - 0.05, 0);
		timer++;
		
		if (timer >= 64)
			state_next_set(0)
		if (metronome_strike())
			state_next_set(2);
		break;
	case 2: //Strike
		if (state_begin)
		{
			timer = 0;
			image_alpha = 1;
			sfx_play_local(sfx_lightning, false);
			hitbox.active = hitbox_active.passive;
			global.water_electric_timer = 8;
			screen_shake(0, 6);
		}
		
		image_alpha = max(image_alpha - 0.05, 0);
		timer++;
		
		if (timer >= 16)
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