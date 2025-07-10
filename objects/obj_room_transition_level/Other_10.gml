/// @description Step

// Inherit the parent event
event_inherited();

animate_previous = animate;

switch (state)
{
	case 0:
		animate = min(frame, 20) / 20;
		if (frame == 21)
			state_next_set(1);
		break;
	case 1:
		if (state_begin)
		{
			frame = 0;
			animate = 1;
			if (global.game_mode != game_modes.boss_rush)
				music_stop();
			draw_texture_flush();
		}
		if (frame == 20)
		{
			trophies_init(level_trophies_get(), level_trophy_count_max_get());
			spawn_point_set(level_room_get(), undefined, undefined);
			checkpoint_set(level_room_get(),,, -1);
			room_destination_set(spawn_point_room_get());
			global.boss_phase = 0;
			global.checkpoint_death_count = 0;
            global.turbo.time = 30;
            global.turbo.pause = false;
            global.turbo.punish = 1;
			state_next_set(2);
			//audio_stop_all();
		}
		break;
	case 2:
		if (state_begin)
		{
			frame = 0;
			
			switch (global.game_mode)
			{
				case game_modes.randomizer:
					global.score++;
					break;
				case game_modes.boss_rush:
					game_timer_pause(false);
					break;
				case game_modes.speedrun:
					global.hearts = hearts_minimum_get();
					global.heart_meter = 0;
					game_timer_pause(false);
					break;
				default:
					global.hearts = hearts_minimum_get();
					global.heart_meter = 0;
					game_timer_reset();
					game_timer_pause(false);
					break;
			}
			
			with (obj_player)
			{
				ego_invincible = 0;
				ego_refill_pause = 0;
				aura = 0;
				hp = 0;
                sprint = 0;
			}
		}
		animate = (min(frame, 20) / 20) + 1;
		if (frame == 20)
			instance_destroy();
		break;
}
