/// @description Step

var _level_save = global.level_save_data_list[global.story_mode][global.level_id];
var _cutscene_room = global.level_cutscene_list[global.story_mode][global.level_id][level_cutscene_data.after];

// Inherit the parent event
event_inherited();

animate_previous = animate;

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
		}
		
		switch (global.game_mode)
		{
			case game_modes.speedrun:
			case game_modes.boss_rush:
				sfx_play_global(sfx_unlock_level);
				state_next_set(2);
				break;
			default:
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
		}
		break;
	case 2:
		frame = 0;
		if (!is_undefined(global.player_lead) && input_check_pressed("confirm", global.player_lead))
			state_next_set(3);
		break;
	case 3:
		if (state_begin)
		{
			if (global.game_state == game_states.gameplay && global.game_mode == game_modes.normal && _level_save.status == level_status.open && !is_undefined(_cutscene_room))
			{
				spawn_point_set(_cutscene_room);
				instance_create_layer(0, 0, "layer_instances", obj_room_transition_fade);
			}
			else
				instance_create(obj_room_transition_return);
			if (perfect_flag)
				_level_save.status = level_status.clear_perfect;
			else
				_level_save.status = level_status.clear_normal;
			levels_unlock();
		}
		frame = 0;
		break;
}
