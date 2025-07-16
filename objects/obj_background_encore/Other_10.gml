/// @description Step

var _back_width = sprite_get_width(spr_encore_background);

scroll += 0.5;

if (scroll >= _back_width)
{
	scroll -= _back_width;
	scroll_previous -= _back_width;
}

index = (index + 0.0125) mod 4;