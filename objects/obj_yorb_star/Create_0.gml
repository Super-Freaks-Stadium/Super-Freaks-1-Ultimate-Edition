/// @description Init

event_inherited();

fast_forward = false;
despawn_area[0] = -32;
despawn_area[1] = -32;
despawn_area[2] = 32;
despawn_area[3] = 32;

animate_previous = 0;
animate = 0;
rotate_speed = 8;

hitbox = new comp_hitbox_AABB(,,,,, -32, -32, 32, 32);
animate_speed = 0.125;
flashlight_radius = 48;
depth = 4;

if (global.story_mode == story_modes.super_freaks && (hearts_maximum_get() != clamp(hearts_maximum_get(), 1, 10))
|| global.checkpoint_death_count < CHECKPOINT_DEATH_MAX 
|| checkpoint_id != checkpoint_id_get() 
|| (global.game_mode != game_modes.normal && global.game_mode != game_modes.free_play))
	instance_destroy();