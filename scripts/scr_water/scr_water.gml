enum water_types
{
	water = 0,
	lava = 1,
	lemonade = 2,
}

#macro c_water make_color_rgb(0, 137, 255)

/// @function water_init
function water_init()
{
	global.water_type = water_types.water;
	global.water_height = 0;
	global.water_height_previous = 0;
	global.water_current = 0;
	global.water_active = false;
	global.water_electric_timer = 0;
	global.water_frame = 0;
}

/// @function water_step
function water_step()
{
	global.water_height_previous = global.water_height;
	global.water_electric_timer = max(global.water_electric_timer - 1, 0);
	global.water_frame = global.water_frame + 0.125 mod 4;
}

/// @function water_draw
function water_draw()
{
	var _i;
	var _view_camera;
	var _view_x1, _view_y1, _view_x2, _view_y2, _view_width;
	var _water_height;
	var _water_flash = (global.water_electric_timer mod 4);
	
	if (global.water_active == false)
		exit;
		
	_view_camera = view_camera[view_current];
	_view_width = camera_get_view_width(_view_camera);
	_view_x1 = camera_get_view_x(_view_camera);
	_view_y1 = camera_get_view_y(_view_camera);
	_view_x2 = _view_x1 + _view_width;
	_view_y2 = _view_y1 + camera_get_view_height(_view_camera);
	_water_height = lerp(global.water_height_previous, global.water_height, global.delta);
	
	if (_water_height < _view_y2 + 32)
	{
		if (_water_flash)
		{
			switch (global.water_type)
			{
				case water_types.water:
					draw_set_color(c_yellow);
					draw_set_alpha(0.75);
					break;
				case water_types.lava:
					draw_set_color(c_yellow);
					draw_set_alpha(1);
					break;
				case water_types.lemonade:
					draw_set_color(c_white);
					draw_set_alpha(1);
					break;
			}
		}
		else
		{
			switch (global.water_type)
			{
				case water_types.water:
					if (_water_flash)
					{
						draw_set_alpha(0.5);
						draw_set_color(c_white);
						for (_i = 0; _i < ceil(_view_width / 32); ++_i)
						{
							draw_sprite(spr_water_surface_lemonade, floor(global.water_frame), _view_x1 + (_i * 32), _water_height);
						}
						draw_set_color(c_yellow);
					}
					else
					{
						draw_set_alpha(0.25);
						draw_set_color(c_water);
						for (_i = 0; _i < ceil(_view_width / 32); ++_i)
						{
							draw_sprite(spr_water_surface_normal, floor(global.water_frame), _view_x1 + (_i * 32), _water_height);
						}
					}
					break;
				case water_types.lava:
					draw_set_alpha(1);
					draw_set_color(c_red);
					for (_i = 0; _i < ceil(_view_width / 32); ++_i)
					{
						draw_sprite(spr_water_surface_lava, floor(global.water_frame), _view_x1 + (_i * 32), _water_height);
					}
					break;
				case water_types.lemonade:
					draw_set_alpha(1);
					draw_set_color(c_white);
					for (_i = 0; _i < ceil(_view_width / 32); ++_i)
					{
						draw_sprite(spr_water_surface_lemonade, floor(global.water_frame), _view_x1 + (_i * 32), _water_height);
					}
					draw_set_color(c_yellow);
					break;
			}
		}
		draw_rectangle(_view_x1, max(_water_height, _view_y1), _view_x2, _view_y2, false);
	}
}
