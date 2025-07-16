/// @description Step

var _target = player_nearest_alive();

// Inherit the parent event
event_inherited();

if (!is_undefined(_target))
{
	if (_target.x < x - 32)
		image_index = 0;
	else if (_target.x > x + 32)
		image_index = 2;
	else
		image_index = 1;
}

switch (state)
{
	case 0: //Idle
		if (state_begin)
		{
			//timer = 0;
		}
		
		timer++;
		deform_x = lerp(deform_x, 1, 0.75);
		deform_y = lerp(deform_y, 1, 0.75);
		
		if (timer >= 112)
		{
			if (instance_number(obj_drillobee) < BEE_SPAWN_LIMIT)
				state_next_set(1);
			else
				timer = 0;
		}
		break;
	case 1: //Spawn Prepare
		if (state_begin)
		{
			timer = 0;
		}
		
		timer++;
		deform_x = lerp(deform_x, 1.25, 0.125);
		deform_y = lerp(deform_y, 0.5, 0.125);
		
		if (timer >= 16)
		{
			state_next_set(2);
		}
		break;
	case 2: //Spawn
		if (state_begin)
		{
			timer = 0;
			if (instance_number(obj_drillobee) < BEE_SPAWN_LIMIT)
				instance_create_layer(x, y - 72, "layer_instances", obj_drillobee);
		}
		
		timer++;
		deform_x = lerp(deform_x, 0.5, 0.75);
		deform_y = lerp(deform_y, 1.25, 0.75);
		
		if (timer >= 16)
		{
			state_next_set(0);
			timer = 0;
		}
		break;
}