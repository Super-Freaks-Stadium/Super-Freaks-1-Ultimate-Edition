function player_state_debug()
{
	if (state_begin)
	{
		visible = true;
		camera.active = true;
		physics = player_physics_modifiers.normal;
		ball = false;
		rubber_band_can_slingshot = false;
        star_arrow = 0;
	}
		
	//if (button_left == controls_action_states.hold) || (button_left == controls_action_states.press)
	if (input_check("left", player_number))
		x -= 3;
	//if (button_right == controls_action_states.hold) || (button_right == controls_action_states.press)
	if (input_check("right", player_number))
		x += 3;
	//if (button_up == controls_action_states.hold) || (button_up == controls_action_states.press)
	if (input_check("up", player_number))
		y -= 3;
	//if (button_down == controls_action_states.hold) || (button_down == controls_action_states.press)
	if (input_check("down", player_number))
		y += 3;
		
	player_pause_game();
}
