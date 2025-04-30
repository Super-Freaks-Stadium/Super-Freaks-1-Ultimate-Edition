function player_state_death()
{
	if (state_begin)
	{
        sprint = 0;
		visible = true;
		camera.active = true;
		physics = player_physics_modifiers.normal;
		speed_h = 0;
		speed_v = -7.15;
		angle = 0;
		jump_buffer = 0;
		coyote_time = 0;
		instance_attach = undefined;
		aura = 0;
		jump_strength = JUMP_STRENGTH_MIN;
		
		collider_attach_clear();
		hitbox.active = hitbox_active.inactive;
		sprite_index = player_animation_get(character_index, player_animations.death);
		image_index = 0;
		sfx_play_global(player_deathsound_get(character_index));
		
		if (!players_alive())
		{
			sfx_play_global(sfx_record_scratch);
			music_pause();
		}
		
		timer_death = 0;
		rubber_band_can_slingshot = false;
		physics = player_physics_modifiers.normal;
	}
	
	if (speed_v < speed_fall)
		speed_v += min(speed_grv, speed_fall - speed_v);
		
	x += speed_h;
	y += speed_v;
	
	timer_death++;
	if (timer_death >= 64)
		player_death_reset();
}