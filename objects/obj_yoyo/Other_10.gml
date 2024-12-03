/// @description Step

hitbox_x_offset_previous = hitbox.x_offset;
hitbox_y_offset_previous = hitbox.y_offset;

spin_angle_previous = spin_angle;
spin_length_previous = spin_length;

spin_angle = (spin_angle + spin_visual) mod 360;

switch (state)
{
	case 0: //Delay
		if (state_begin)
			timer = 0;
			
		timer = min(timer + 1, delay_start);
		
		if (timer == delay_start)
		{
			spin_visual = min(spin_visual + 1, 30);
			
			if (spin_visual == 30)
				state_next_set(1);
		}
		break;
	case 1: //Extend
		spin_length = min(spin_length + (spin_speed / 100), 1);
		hitbox.x_offset = lerp(x, destination_x, spin_length) - x;
		hitbox.y_offset = lerp(y, destination_y, spin_length) - y;
		
		if (spin_length == 1)
			state_next_set(2);
		break;
	case 2: //Delay
		if (state_begin)
			timer = 0;
			
		timer++;
		
		if (timer >= delay_return)
			state_next_set(3);
		break;
	case 3: //Retract
		spin_length = max(spin_length - (spin_speed / 100), 0);
		hitbox.x_offset = lerp(x, destination_x, spin_length) - x;
		hitbox.y_offset = lerp(y, destination_y, spin_length) - y;
		
		if (spin_length == 0)
		{
			spin_visual = max(spin_visual - 1, 0);
			
			if (spin_visual == 0)
				state_next_set(0);
		}
		break;
}