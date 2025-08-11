/// @description Step

// Inherit the parent event
event_inherited();

switch (state)
{
	case 0:
		if (frame == 15)
		{
			room_destination_set(spawn_point_room_get());
			state_next_set(1);
		}
		else
			circle_size = 1 - (min(frame, 10) / 10);
		break;
	case 1:
		if (state_begin)
			frame = 0;
		circle_size = (frame / 10);
		if (frame == 10)
			instance_destroy();
		break;
}
