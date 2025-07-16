/// @description Step

var _back_width = sprite_get_width(spr_background_toy_bridge);

scroll++;

if (scroll >= _back_width)
{
	scroll -= _back_width;
	scroll_previous -= _back_width;
}