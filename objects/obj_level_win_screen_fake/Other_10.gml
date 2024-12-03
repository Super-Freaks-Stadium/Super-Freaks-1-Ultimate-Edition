/// @description Step

var _screen_width = screen_width_get();
var _screen_height = screen_height_get();
var _view_x1 = view_x1_get();
var _view_y1 = view_y1_get();
var _screen_width_half = _screen_width / 2;
var _screen_height_half = _screen_height / 2;

// Inherit the parent event
event_inherited();

animate_previous = animate;
lower_offset_previous = lower_offset;

switch (state)
{
	case 0:
		animate = frame / 20;
		if (frame == 20)
			state_next_set(1);
		break;
	case 1:
		if (state_begin)
		{
			animate = 1;
			frame = 15;
			with (obj_boss_kranion)
				instance_destroy();
		}

		if (frame == 15)
		{
			if (trophy_count < global.trophies_max)
			{
				trophy_count++;
				frame = 0;
				sfx_play_global(sfx_pop);
			}
			else
			{
				if (perfect_flag)
				{
					clear_text = "perfect";
					sfx_play_global(sfx_unlock_level);
				}
				state_next_set(2);
			}
		}
		break;
	case 2:
		if (state_begin)
		{
			frame = 0;
		}
			
		frame++;
		
		if (frame >= 80)
			state_next_set(3);
		break;
	case 3:
		if (state_begin)
		{
			global.frame_machine_level.pause = false;
			instance_create_layer(_view_x1 + _screen_width_half, _view_y1 + _screen_height_half, "layer_instances", obj_boss_explosion);
			instance_create_layer(_view_x1 + _screen_width_half, _view_y1 + _screen_height_half, "layer_instances", obj_boss_kranion_final);
			victory_quote = choose("Hey!", "You gotta be kidding me!", "Here we go again!", "Right when I have to use the bathroom!");
			frame = 0;
		}
		frame++;
		
		if (frame >= 80)
			state_next_set(4);
		break;
	case 4:
		if (state_begin)
		{
			global.frame_machine_player.pause = false;
			lower_offset = 0;
			game_timer_pause(false);
		}
		lower_offset += 0.05;
		
		if (lower_offset >= 1)
			instance_destroy();
		break;
}
