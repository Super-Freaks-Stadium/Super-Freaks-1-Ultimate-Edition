/// @description 

var _x1 = view_x1_get();
var _y1 = view_y1_get();
var _x2 = view_x2_get();
var _y2 = view_y2_get();
var _width = _x2 - _x1;
var _height = _y2 - _y1;
var _circle_x, _circle_y, _circle_radius, _frame_delta = global.delta;

if (!surface_exists(surface))
	surface = surface_create(_width, _height);
else
	surface_resize(surface, _width, _height);

surface_set_target(surface);
draw_clear_alpha(c_black, draw_alpha);
gpu_set_blendmode(bm_subtract);
draw_set_color(c_white);
if (instance_exists(obj_player))
{
	with (obj_player)
	{
		switch (state)
		{
			case player_states.inactive:
			case player_states.debug:
				break;
			default:
				_circle_x = lerp(x_start_frame, x, _frame_delta) - camera_get_view_x(view_camera[0]);
				_circle_y = lerp(y_start_frame, y, _frame_delta) - camera_get_view_y(view_camera[0]);
				_circle_radius = flashlight_radius;
		
				draw_set_alpha(0.5);
				draw_circle(_circle_x, _circle_y, _circle_radius + 10, false);
				draw_set_alpha(1);
				draw_circle(_circle_x, _circle_y, _circle_radius, false);
				break;
		}
	}
}
if (instance_exists(obj_level_obj))
{
	with (obj_level_obj)
	{
		if (flashlight_radius <= 0)
			continue;
		_circle_x = lerp(x_start_frame, x, _frame_delta) - camera_get_view_x(view_camera[0]);
		_circle_y = lerp(y_start_frame, y, _frame_delta) - camera_get_view_y(view_camera[0]);
		_circle_radius = flashlight_radius;
		
		draw_set_alpha(0.5);
		draw_circle(_circle_x, _circle_y, _circle_radius + 10, false);
		draw_set_alpha(1);
		draw_circle(_circle_x, _circle_y, _circle_radius, false);
	}
}
gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface_stretched(surface, _x1, _y1, _width, _height);