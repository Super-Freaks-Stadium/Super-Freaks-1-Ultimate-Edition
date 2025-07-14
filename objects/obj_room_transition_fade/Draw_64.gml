/// @description 

var _screen_width, _screen_height, _screen_width_half, _screen_height_half;
var _circle_size = lerp(circle_size_previous, circle_size, global.delta);

if (!surface_exists(global.surface_HUD))
	exit;
	
_screen_width = surface_get_width(global.surface_HUD);
_screen_height = surface_get_height(global.surface_HUD);
_screen_width_half = _screen_width / 2;
_screen_height_half = _screen_height / 2;
	
surface_set_target(global.surface_HUD);

draw_set_color(color);
draw_rectangle(0, 0, _screen_width, _screen_height, false);

if (circle_size > 0)
{
	gpu_set_blendmode(bm_subtract);
	draw_set_color(c_white);
	draw_circle(_screen_width_half, _screen_height_half,  _screen_width_half * _circle_size, false);
	gpu_set_blendmode(bm_normal);
}

surface_reset_target();