function player_state_inactive()
{
	if (state_begin)
	{
		visible = false;
		camera.active = false;
		physics = player_physics_modifiers.normal;
		ball = false;
		hitbox.active = hitbox_active.inactive;
		rubber_band_can_slingshot = false;
		aura = 0;
		jump_strength = JUMP_STRENGTH_MIN;
        star_arrow = 0;
	}
	
	//if (button_jump == controls_action_states.press)
	if (input_player_connected(player_number))
	{
		state_next_set(player_states.drop_in, 999999999);
	}
}
