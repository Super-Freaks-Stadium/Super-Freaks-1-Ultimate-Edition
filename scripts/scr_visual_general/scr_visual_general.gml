enum visuals_data
{
	aspect_ratio = 0,
	upscale,
	fullscreen,
	frame_rate,
	vsync,
	aa,
	shader,
	background_blur,
	screen_shake,
	upscale_internal,
	static_menu_bg,
}

#macro SCREEN_WIDTH_MIN 640
#macro SCREEN_WIDTH_MAX 840
#macro SCREEN_HEIGHT_MIN 360
#macro SCREEN_HEIGHT_MAX 480
#macro SCREEN_UPSCALE_MAX 4

/// @function visuals_init
function visuals_init()
{
	global.visuals_settings = [];
	global.surface_game = -1;
	global.surface_HUD = -1;
    
    global.font_16 = font_add_sprite(spr_font_16, ord("!"), true, 2);
    global.font_12 = font_add_sprite(spr_font_12, ord("!"), true, 2);
    global.font_title = font_add_sprite_ext(spr_font_title_card, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?,:\'\"", true, 2);
    /*
    font_enable_effects(font_normal, true, 
    {
        outlineEnable: true,
        outlineDistance: 1,
        outlineColour: c_black,
    });
    */
		
	aspect_ratio_list_init();
	framerate_list_init();
	screen_shaders_init();
	
	visuals_default();
	visuals_load();
		
	screen_set();
		
	application_surface_draw_enable(false);
	//surface_depth_disable(true);
		
	view_init();
}

/// @function visuals_save
function visuals_save()
{
	var _json = json_stringify(global.visuals_settings);
	string_save(_json, "visual.settings");
}

/// @function visuals_load
function visuals_load()
{
	var _json;
	var _array;
	var _i;
	
	if (file_exists("visual.settings"))
	{
		_json = string_load("visual.settings");
		_array = json_parse(_json);
		
		for (_i = 0; _i < array_length(_array); ++_i)
		{
			global.visuals_settings[_i] = _array[_i];
		}
	}
}

/// @function visuals_default
function visuals_default()
{
	global.visuals_settings[visuals_data.aspect_ratio] = 0;
	global.visuals_settings[visuals_data.upscale] = 1;
	global.visuals_settings[visuals_data.fullscreen] = false;
	global.visuals_settings[visuals_data.frame_rate] = 2;
	global.visuals_settings[visuals_data.vsync] = true;
	global.visuals_settings[visuals_data.aa] = 0;
	global.visuals_settings[visuals_data.shader] = 0;
	global.visuals_settings[visuals_data.background_blur] = false;
	global.visuals_settings[visuals_data.screen_shake] = true;
	global.visuals_settings[visuals_data.upscale_internal] = 2;
	global.visuals_settings[visuals_data.static_menu_bg] = false;
}

/// @function screen_set
function screen_set()
{
	var _width, _height, _width_upscale, _height_upscale;
	var _screen_width = screen_width_get();
	var _screen_height = screen_height_get();
	var _upscale = screen_upscale_get();
	var _upscale_internal = global.visuals_settings[visuals_data.upscale_internal];
	var _fullscreen = global.visuals_settings[visuals_data.fullscreen];
	var _window_width;
	var _window_height;
	var _framerate = global.framerate_list[global.visuals_settings[visuals_data.frame_rate]];
	var _display_width = display_get_width();
	var _display_height = display_get_height();
		
	display_reset(0, vsync_get());
	
	_width = _screen_width;
	_height = _screen_height;
	_width_upscale = _width * _upscale_internal;
	_height_upscale = _height * _upscale_internal;
	
	switch (_fullscreen)
	{
		case true:
			window_set_size(_width, _height);
			window_set_fullscreen(true);
			break;
		case false:
			_window_width = _width * _upscale;
			_window_height = _height * _upscale;
			window_set_fullscreen(false);
			window_set_rectangle((_display_width / 2) - (_window_width / 2), (_display_height / 2) - (_window_height / 2), _window_width, _window_height);
			break;
	}
		
	surface_resize(application_surface, _width_upscale, _height_upscale);
	view_set_wport(view_camera[0], _width);
	view_set_hport(view_camera[0], _height);
	display_set_gui_size(_width_upscale, _height_upscale);
	
	if (os_browser == browser_not_a_browser)
	{
		//show_debug_message("Display Framerate: " + string(_framerate));
		game_set_speed(_framerate, gamespeed_fps);
	}
	else
		game_set_speed(60, gamespeed_fps);
}

/// @function screen_width_get
function screen_width_get()
{
	var _aspect_ratio_list = global.aspect_ratio_list;
	var _aspect_ratio_current = global.visuals_settings[visuals_data.aspect_ratio];
	return _aspect_ratio_list[_aspect_ratio_current][aspect_ratio_data.width];
}

/// @function screen_height_get
function screen_height_get()
{
	var _aspect_ratio_list = global.aspect_ratio_list;
	var _aspect_ratio_current = global.visuals_settings[visuals_data.aspect_ratio];
	return _aspect_ratio_list[_aspect_ratio_current][aspect_ratio_data.height];
}

/// @function screen_upscale_set
/// @param {int} _upscale
function screen_upscale_set(_upscale)
{
	global.visuals_settings[visuals_data.upscale] = clamp(_upscale, 1, SCREEN_UPSCALE_MAX);
	screen_set();
}

/// @function screen_upscale_get
function screen_upscale_get()
{
	return global.visuals_settings[visuals_data.upscale];
}

/// @function vsync_set
/// @param {boolean} _flag = true
function vsync_set(_flag = true)
{
	global.visuals_settings[visuals_data.vsync] = _flag;
	
	gml_pragma("forceinline");
}

/// @function vsync_get
function vsync_get()
{
	return global.visuals_settings[visuals_data.vsync];
	
	gml_pragma("forceinline");
}

/// @function aa_set
/// @param {int} _aa = 0
function aa_set(_aa = 0)
{
	switch (display_aa)
	{
		case 2:
			_aa = clamp(_aa, 0, 2);
			break;
		case 6:
			_aa = clamp(_aa, 0, 4);
			break;
		case 12:
		case 14:
			_aa = clamp(_aa, 0, 8);
			break;
	}
	global.visuals_settings[visuals_data.aa] = _aa;
	screen_set();
}

/// @function aa_get
function aa_get()
{
	return global.visuals_settings[visuals_data.aa];
}

/// @function screen_shake_get
function screen_shake_get()
{
	return (global.visuals_settings[visuals_data.screen_shake] && !static_menu_bg_get());
}

/// @function background_blur_get
function background_blur_get()
{
	return global.visuals_settings[visuals_data.background_blur];
}

/// @function static_menu_bg_get
function static_menu_bg_get()
{
	return global.visuals_settings[visuals_data.static_menu_bg];
}