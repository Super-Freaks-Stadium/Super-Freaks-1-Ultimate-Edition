/// @description Step

var _back_width = sprite_get_width(spr_background_park_stars);

scroll += 0.5;

if (scroll >= _back_width)
{
	scroll -= _back_width;
	scroll_previous -= _back_width;
}

light_alpha = max(light_alpha - 0.1, 0);
index = min(index + 0.25, 2);
if (metronome_strike())
{
	light_alpha = 0.8;
	index = 0;
	rotate_left = random(360);
	rotate_right = random(360);
}