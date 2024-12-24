/// @description Step

var _width = image_xscale * sprite_get_width(sprite_index);
var _height = image_yscale * sprite_get_height(sprite_index);
var _width_half = _width / 2;
var _height_half = _height / 2;

switch (state)
{
	case 0:
		if (state_begin)
		{
			visible = true;
			hitbox.active = hitbox_active.passive;
			can_grab = true;
			speed_v = 0;
		}
		break;
	case 1:
		if (state_begin)
			timer = 0;
		timer++;
		y = ystart + ((timer & 1) * 4);
		if (timer >= activate_timer)
			state_next_set(2);
		break;
	case 2:
		if (state_begin)
		{
			y = ystart;
			sfx_play_local(sfx_fall);
		}
		speed_v = min(speed_v + speed_grv, 6);
		y += speed_v;
		if (!in_view(x - _width_half, y - _height_half, x + _width_half, y + _height_half))
			state_next_set(3);
		break;
	case 3:
		if (state_begin)
		{
			timer = 48;
			visible = false;
			hitbox.active = hitbox_active.inactive;
			can_grab = false;
		}
		timer--;
		if (timer <= 0)
		{
			x = xstart;
			y = ystart;
			state_next_set(0);
			if (in_view(x - _width_half, y - _height_half, x + _width_half, y + _height_half))
				sfx_play_local(sfx_pop);
		}
		break;
}

// Inherit the parent event
event_inherited();

