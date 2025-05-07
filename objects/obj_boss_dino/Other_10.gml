/// @description Step

var _player = player_nearest_alive();

// Inherit the parent event
event_inherited();

switch (state)
{
	case boss_dino_states.inactive:
		if (state_begin)
		{
			hitbox.active = hitbox_active.inactive;
			visible = false;
		}
		break;
	case boss_dino_states.normal:
		if (state_begin)
		{
			hitbox.active = hitbox_active.passive;
			visible = true;
			depth = 0;
		}
		
		if (!is_undefined(_player))
		{
			face = (sign(_player.x - x));
			if (face == 0)
				face = 1;
		}
		break;
	case boss_dino_states.fall:
		if (state_begin)
		{
            global.turbo.pause = true;
			sfx_play_global(sfx_zip);
			sprite_index = spr_player_death_dino;
			hitbox.active = hitbox_active.inactive;
			speed_y = 2;
		}
		
		speed_y += 0.25;
		y += speed_y;
		
		if (y >= room_height + 32)
        {
            if (global.difficulty == difficulty_levels.easy)
            {
                instance_destroy();
                level_beat();
            }
            else
			    state_next_set(boss_dino_states.jetpack);
        }
		break;
	case boss_dino_states.jetpack:
		if (state_begin)
		{
			sfx_play_global(sfx_slide_whistle_up);
			if (global.game_mode != game_modes.boss_rush)
				music_set(msc_boss_dino_2);
			sprite_index = spr_player_air_dino;
			image_index = 0;
			animate_speed = 0;
			speed_y = 0;
		}
		
		speed_y -= 0.25;
		y += speed_y;
		
		if (y <= 440)
		{
			instance_destroy();
			instance_create_layer(0, 0, "layer_instances", obj_boss_dino_ship);
			global.boss_phase = 1;
		}
		break;
}