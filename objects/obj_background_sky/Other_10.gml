/// @description Step

var _back_width = sprite_get_width(spr_background_sky_clouds);

if (!global.visuals_settings[visuals_data.static_menu_bg])
    scroll++;

if (scroll >= _back_width)
{
	scroll -= _back_width;
	scroll_previous -= _back_width;
}