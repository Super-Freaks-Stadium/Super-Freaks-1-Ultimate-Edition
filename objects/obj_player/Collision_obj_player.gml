/// @description 

var _y = y;

switch (other.state)
{
	case player_states.bubble:
		switch (state)
		{
			case player_states.inactive:
			case player_states.debug:
			case player_states.death:
			case player_states.bubble:
				break;
			default:
				with (other)
				{
					state_next_set(player_states.normal, 99999);
					speed_h = 0;
					speed_v = -4;
					y = min(y, _y);
					hurt_timer_set(120);
					sfx_play_local(sfx_pop);
					if (other.jetpack == true)
						jetpack = true;
				}
				break;
		}
		break;
	default:
		break;
}