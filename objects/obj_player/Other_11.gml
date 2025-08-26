/// @description Step 2

if (y < -128)
	y = -128;

switch (state)
{
	case player_states.climb:
		if (state_next != player_states.climb)
			instance_attach = undefined;
		else if (hang_on == false || is_undefined(instance_attach) || !instance_exists(instance_attach))
		{
			instance_attach = undefined;
			state_next_set(player_states.normal);
		}
		break;
	default:
		break;
}

if (star_arrow > 0)
{
    instance_create_layer(x - 12 + random(24), y - 12 + random(24), "layer_instances", obj_yorb_collected_single);
    star_arrow--;
}